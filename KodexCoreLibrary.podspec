#
# Be sure to run `pod lib lint KodexCoreLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KodexCoreLibrary'
  s.version          = '1.1.9'
  s.summary          = 'Basic Kodex Core Library'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/jawadkodextech/KodexCoreLibrary'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jawadkodextech' => 'jawadali1008@gmail.com' }
  s.source           = { :git => 'https://github.com/jawadkodextech/KodexCoreLibrary.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '13.0'
  s.static_framework = true
  s.source_files = 'KodexCoreLibrary/Classes/**/*.swift'
   # s.resource_bundles = {
   #    'KodexCoreLibrary' => ['KodexCoreLibrary/**/*.png','KodexCoreLibrary/**/*.pdf','KodexCoreLibrary/Classes/**/*.xib']
  # }

 s.resources = "KodexCoreLibrary/Assets/Media.xcassets", 'KodexCoreLibrary/Views/**/*.xib', "KodexCoreLibrary/Fonts/*.ttf"
   
   s.public_header_files = 'KodexCoreLibrary/Classes/*.h'
   s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'IQKeyboardManager'
#    s.dependency 'KingfisherWebP'
   s.dependency 'Kingfisher'
   s.dependency 'PasswordTextField'
   s.dependency 'Alamofire'
   s.dependency 'SwiftyJSON'
   s.dependency 'SnapKit'
   s.dependency 'RSReusable'
   s.dependency 'Device'
   s.dependency 'Zoomy'
   s.dependency 'YPImagePicker'
   s.dependency 'Toast-Swift'
   s.dependency 'GoogleMaps'
   s.dependency 'GooglePlaces'
   s.dependency 'FacebookCore'
   s.dependency 'FacebookLogin'
   s.dependency 'FacebookShare'
#   s.dependency 'GoogleSignIn'
   s.dependency 'DropDown'
   s.dependency 'SkeletonView'
   s.dependency 'PinCodeTextField'
   s.dependency 'ESTabBarController-swift'
   s.dependency 'SideMenu'
#    s.dependency 'MaterialComponents/TextFields'
   s.dependency 'ActiveLabel'
   s.dependency 'AWSAuthUI'#, '~> 2.6.13'
   s.dependency 'AWSMobileClient'#, '~> 2.6.13'
   s.dependency 'AWSDynamoDB'#, '~> 2.6.13'
   s.dependency 'AWSS3'#, '~> 2.6.13'
   s.dependency 'AWSCognito'#, '~> 2.6.13'
   s.dependency 'MaterialComponents/BottomSheet'
   s.dependency 'MaterialComponents/BottomSheet+ShapeThemer'
   s.dependency 'TouchVisualizer'
   s.dependency 'NVActivityIndicatorView'
   s.dependency 'Lightbox'
   s.dependency 'Zoomy'
end
