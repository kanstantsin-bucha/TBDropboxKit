#
# Be sure to run `pod lib lint TBDropboxKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TBDropboxKit'
  s.version          = '1.0.1'
  s.summary          = 'Dropbox ObjC synchronization kit using API v2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This framework provide basic two way synchronization functionality for dropbox.
It is using dropbox API version 2. It writed using SOLID principles"
                       DESC

  s.homepage         = 'https://github.com/truebucha/TBDropboxKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'truebucha' => 'truebucha@gmail.com' }
  s.source           = { :git => 'https://github.com/truebucha/TBDropboxKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/truebucha'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TBDropboxKit/Classes/**/*'

  # s.resource_bundles = {
  #   'TBDropboxKit' => ['TBDropboxKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ObjectiveDropboxOfficial', '~> 2.0'
  s.dependency 'CDBKit', '~> 0.0'
  s.dependency 'CDBDelegateCollection', '~> 0.0'
end
