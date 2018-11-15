# NearbyUser

[![CI Status](https://img.shields.io/travis/RajeshwariU/NearbyUser.svg?style=flat)](https://travis-ci.org/RajeshwariU/NearbyUser)
[![Version](https://img.shields.io/cocoapods/v/NearbyUser.svg?style=flat)](https://cocoapods.org/pods/NearbyUser)
[![License](https://img.shields.io/cocoapods/l/NearbyUser.svg?style=flat)](https://cocoapods.org/pods/NearbyUser)
[![Platform](https://img.shields.io/cocoapods/p/NearbyUser.svg?style=flat)](https://cocoapods.org/pods/NearbyUser)

This library is used to find nearby user from your current location with respect to your radius.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Xcode 6 or later
- iOS 8 or later

## Installation

NearbyUser is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NearbyUser'
```
## Usage

- Objective C

`#import "NearbyUser-Swift.h"`

- Swift

`import NearbyUser`

###### How to use

1.Create object for mapManagers class[which is in pod] <br />  
Example: <br />
var mapObject = mapManagers() 

2.mapManagers class has below method with returntype of GMSMapView<br />
public func initLocationManagerWithRadiusAndMap(getRadius: String, googleMapView: GMSMapView) -> GMSMapView<br />
{<br />
return GMSMapView<br />
}<br />
usage of the above method is:<br />
`gMap = mapObject.initLocationManagerWithRadiusAndMap(getRadius: "yourradiusvalue", googleMapView: gMap)`<br />
(in viewDidLoad or wherever based on your preference)

3.mapManagers class has following variables:<br />
/// This variable is used to store all user informatiom from json/api<br />
public var userInformation: [[String: String]] = []<br />
/// This variable is used set custom marker image<br />
public var pinImage = UIImage()<br />
/// This variable is used for placeholder image inside the pin image <br />
public var userPlaceholderImage = UIImage()

usage of the above variables is:<br />
`mapObject.userInformation = "yourData from api/json"`<br />
`mapObject.pinImage = UIImage(named: "yourImage")!`<br />
`mapObject.userPlaceholderImage = UIImage(named: "yourImage")!`

4.The following methods to get users and marker within the radius<br />
/// This method is to get all users within the radius<br />
/// - Returns: value in [[String: String]]<br />
public func getAllVisibleUserFromRadius() -> [[String: String]] <br />
{<br />
return [[String: String]]<br />
}<br />

/// This method is to get all markers within the radius<br />
/// - Returns: GMSMarker<br />
public func getAllVisibleMarkerFromRadius() -> [GMSMarker]<br />
{<br />
return  [GMSMarker]<br />
}

Note:<br />
gMap - outlet of your GMSMapView[used in your project]<br />
mapObject - instance of mapManagers class

## Author

RajeshwariU, rajeshwari.u@contus.in

## License

NearbyUser is available under the MIT license. See the LICENSE file for more info.
