#
#  Be sure to run `pod spec lint WirexUtils.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name             = "WirexUtils"
  s.summary          = "WirexUtils is a set of utility functions & classes used in Wirex iOS client."
  s.version          = "0.9.0"
  s.homepage         = "https://wirexapp.com"
  s.license          = 'MIT'
  s.author           = { "Eugen Fedchenko" => "eugenf78@gmail.com" }
  s.source           = { :git => "https://github.com/wirexapp/WirexUtils.git", :tag => s.version.to_s }
  #s.social_media_url = 'https://twitter.com/hyperoslo'
  s.platform     = :ios, '10.0'
  s.requires_arc = true
  s.source_files = 'Source/**/*'
  s.frameworks = 'Foundation'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.2' }

end
