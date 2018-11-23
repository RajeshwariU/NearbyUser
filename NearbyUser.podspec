#
# Be sure to run `pod lib lint NearbyUser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NearbyUser'
  s.version          = '0.1.5'
  s.summary          = 'Used to find the nearby users.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: This library is used to find the nearByUsers from your current location.
                       DESC

  s.homepage         = 'https://github.com/RajeshwariU/NearbyUser'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RajeshwariU' => 'rajeshwari.u@contus.in' }
  s.source           = { :git => 'https://github.com/RajeshwariU/NearbyUser.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.static_framework = true
  s.source_files = 'NearbyUser/Classes/**/*'
  s.requires_arc     = true
  s.swift_version = '4.0'
  # s.resource_bundles = {
  #   'NearbyUser' => ['NearbyUser/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'GoogleMaps'
  s.dependency 'GooglePlaces'
  s.dependency 'SDWebImage', '~> 4.0'
  s.dependency 'ACProgressHUD-Swift', '~> 1.3'
end
