#
# Be sure to run `pod lib lint TBDropboxKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TBDropboxKit'
  s.version          = '1.2.0'
  s.summary          = 'Dropbox ObjC synchronization kit using API v2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Stable version, core updated to ObjectiveDropboxOfficial 3.4.0.
  Please refer to the readme in github. For some reason the cocoapods ignoring README.md :(
  This framework provide basic two way synchronization functionality for dropbox and changes nofification in both ways.
  It uses official dropbox API version 2 under the hood.
  It was written using SOLID principles in DRY mode"
                       DESC

  s.homepage         = 'https://github.com/truebucha/TBDropboxKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'truebucha' => 'truebucha@gmail.com' }
  s.source           = { :git => 'https://github.com/truebucha/TBDropboxKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/truebucha'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.requires_arc = true

  s.source_files = 'TBDropboxKit/Classes/**/*'

  # s.resource_bundles = {
  #   'TBDropboxKit' => ['TBDropboxKit/Assets/*.png']
  # }

  s.public_header_files = 'TBDropboxKit/Classes/**/*.h'
  s.frameworks = 'Foundation'
  s.dependency 'ObjectiveDropboxOfficial', '~> 3.4.0'
  s.dependency 'CDBKit', '~> 1.1'
  s.dependency 'CDBDelegateCollection', '~> 1.1'
  s.dependency 'TBLogger', '~> 1.1'

  end
