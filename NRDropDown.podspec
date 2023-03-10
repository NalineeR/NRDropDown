#
# Be sure to run `pod lib lint NRDropDown.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NRDropDown'
  s.version          = '0.1.4'
  s.summary          = 'Custom Drop down with selection icon'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  In this version of DropDown you can add a drop easily with following types -
  1. Left selection (you can provide your custom icon)
  2. Right selection (you can provide your custom icon)
  3. Selection background (you can provide your custom Background colour for selection).
                       DESC

  s.homepage         = 'https://github.com/NalineeR/NRDropDown'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NalineeR' => 'nalinee.rajpurohit95@gmail.com' }
  s.source           = { :git => 'https://github.com/NalineeR/NRDropDown.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '10.0'
  s.source_files = 'NRDropDown/Classes/**/*.swift'
  
  # s.resource_bundles = {
  #   'NRDropDown' => ['NRDropDown/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.requires_arc = true
  s.resources = "Resources/**/*.{png,xib}"
end
