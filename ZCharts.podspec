#
# Be sure to run `pod lib lint ZCharts.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ZCharts"
  s.version          = "1.1.0"
  s.summary          = "基于drawRect的 一款柱状图."
  s.description      = <<-DESC
                       基于drawRect的 一款柱状图
                       DESC
  s.homepage         = "https://github.com/zhuayi/ZCharts.git"
  s.license          = 'MIT'
  s.author           = { "zhuayi" => "2179942@qq.com" }
  s.source           = { :git => "https://github.com/zhuayi/ZCharts.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ZCharts' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  #s.dependency 'UIView-ZQuartz', :git => 'https://github.com/zhuayi/UIView-ZQuartz.git'
end
