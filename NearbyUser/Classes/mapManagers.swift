//
//  mapManagers.swift
//  NearByUsers-NearByUsers
//
//  Created by user on 12/11/18.
//

import UIKit
import CoreLocation
import GoogleMaps
import SDWebImage
import ACProgressHUD_Swift


@objc public class mapManagers: NSObject , CLLocationManagerDelegate,GMSMapViewDelegate {
    /// This variable is for CLLocationManager
    var locationManager : CLLocationManager = CLLocationManager()
    /// This variable stores the radius in string
    var radiusString = String()
    /// This variable is for GMSMapView
    //    var setGoogleMaps = GMSMapView()
    /// This variable is used to store all marker
    var markersArray = [GMSMarker]()
    /// This variable is used to store all user informatiom from json/api
    @objc public var userInformation: [[String: String]] = []
    /// This variable is used to store only the user within the given radius
    var  visibleUser = [[String: String]]()
    /// This variable is used to store the current location of the user
    @objc public var  currentLocationCoordinates = CLLocationCoordinate2D()
    /// This variable is used set custom marker image
    @objc public var pinImage = UIImage()
    /// This variable is used to placeholder image
    @objc public var userPlaceholderImage = UIImage()
    /// This variable is used to store GMSMapView
    var commonGoogleMapView : GMSMapView = GMSMapView()
    
    
    // MARK: - CLLocationManager Delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Public methods
    
    
    /// This method is used to initiate locationManager
    ///
    /// - Parameters:
    ///   - getRadius: get radius from user to display there contact within the radius
    ///   - googleMapView: GMSMapView
    @objc(initLocationManagerWithRadiusAndMap: :)
    public func initLocationManagerWithRadiusAndMap(getRadius: String, googleMapView: GMSMapView) -> GMSMapView
    {
        // Ask for Authorisation from the User.
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            commonGoogleMapView = googleMapView
            commonGoogleMapView.delegate = self
            commonGoogleMapView.isOpaque = false
            commonGoogleMapView.alpha = CGFloat(0.3)
            ACProgressHUD.shared.progressText = ""
            ACProgressHUD.shared.hudBackgroundColor = .clear
            ACProgressHUD.shared.showHUD()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 10
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.startUpdatingLocation()
            radiusString = getRadius
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let location = self.locationManager.location?.coordinate
                self.cameraMoveToLocation(toLocation: location, googleMapView: self.commonGoogleMapView)
                ACProgressHUD.shared.hideHUD()
                self.commonGoogleMapView.isOpaque = true
                self.commonGoogleMapView.alpha = CGFloat(1.0)
            }
            
        }
        return commonGoogleMapView
    }
    
    /// This is used to zoom the user currentLocation with radius using GMSCircle
    ///
    /// - Parameter toLocation: CLLocationCoordinate2D
    /// - googleMapView: GMSMapView
    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?, googleMapView: GMSMapView) {
        if toLocation != nil {
            currentLocationCoordinates = toLocation!
            var toMeter : Double  = Double(radiusString)!
            toMeter = toMeter * 1000
            let circle = GMSCircle()
            circle.radius = toMeter // Meters
            // SET ZOOM LEVEL
            var zoomLevel: Int = 10
            let radius: Double = toMeter + toMeter / 2
            let scale: Double = radius / 500
            zoomLevel = Int(16 - log(scale) / log(2))
            zoomLevel += 1
            circle.fillColor = UIColor.lightGray.withAlphaComponent(0.5)
            circle.position = toLocation! // Your CLLocationCoordinate2D  position
            circle.strokeWidth = 0.2;
            circle.strokeColor = UIColor.lightGray
            circle.map = googleMapView;
            // Add it to the map
            circle.map?.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: Float(zoomLevel))
            setMarkerForAllNearByUsers(userInformation: userInformation, googleMapView: googleMapView)
        }
    }
    
    /// This method is to get all users within the radius
    ///
    /// - Returns: value in [[String: String]]
    @objc public func getAllVisibleUserFromRadius() -> [[String: String]] {
        return visibleUser
    }
    /// This method is to get all markers within the radius
    ///
    /// - Returns: GMSMarker
    @objc public func getAllVisibleMarkerFromRadius() -> [GMSMarker] {
        return markersArray
    }
    
    // MARK: - Private methods
    
    /// This method is to set custom marker for all nearby users
    ///
    /// - Parameter userInformation: this dictionary contains all user information from json
    /// - googleMapView: GMSMapView
    func setMarkerForAllNearByUsers(userInformation: [[String: String]],googleMapView: GMSMapView)
    {
        visibleUser .removeAll()
        markersArray.removeAll()
        for user in userInformation {
            let userLat = user[kLatitude]
            let userLon = user[kLongitude]
            let latitudess = (userLat as NSString?)!.doubleValue
            let longitudess = (userLon as NSString?)!.doubleValue
            let myLocation = CLLocation(latitude: currentLocationCoordinates.latitude, longitude: currentLocationCoordinates.longitude)
            let newLocation = CLLocation(latitude: latitudess, longitude: longitudess)
            let distanceKiloMeters = (myLocation.distance(from: newLocation))/1000
            let toKiloMeter : Double  = Double(radiusString)!
            if(distanceKiloMeters <= toKiloMeter)
            {
                let user_marker = GMSMarker()
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
                let pinImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
                pinImageView.image = pinImage
                let groupImage = UIImageView(frame: CGRect(x: 15, y: 4, width: 40, height: 40))
                groupImage.backgroundColor = UIColor.lightGray
                let userProfile = user[kUserImage]
                groupImage.sd_setImage(with: URL(string: userProfile!), placeholderImage: userPlaceholderImage)
                view.addSubview(pinImageView)
                groupImage.layer.cornerRadius = 21
                groupImage.layer.masksToBounds = true
                view.addSubview(groupImage)
                let markerIcon: UIImage? = image(from: view)
                user_marker.icon = markerIcon
                user_marker.position = CLLocationCoordinate2D(latitude: latitudess, longitude: longitudess)
                user_marker.map = googleMapView
                markersArray .append(user_marker)
                visibleUser.append(user)
                print(markersArray.count)
            }
        }
    }
    
    /// This function is to set marker icon
    ///
    /// - Parameter view: UIView
    /// - Returns: UIImage
    func image(from view: UIView?) -> UIImage? {
        if UIScreen.main.responds(to: #selector(getter: UIScreen.scale)) {
            UIGraphicsBeginImageContextWithOptions(view?.frame.size ?? CGSize.zero, _: false, _: UIScreen.main.scale)
        } else {
            UIGraphicsBeginImageContext((view?.frame.size)!)
        }
        if let aContext = UIGraphicsGetCurrentContext() {
            view?.layer.render(in: aContext)
        }
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
