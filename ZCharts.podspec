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
  s.version          = "2.0.0"
  s.summary          = "ZCharts 是一个图表库,支持的图表类型有曲线图. 区域图、柱状图、饼状图、散状点图"
  s.description      = <<-DESC
                       ZCharts 是一个图表库， 能够很简单便捷的为应用程序添加有交互性的图表，并且免费提供给个人学习、个人网站和非商业用途使用。ZCharts支持的图表类型有曲线图. 区域图、柱状图、饼状图、散状点图
                       DESC
  s.homepage         = "https://github.com/zhuayi/ZCharts.git"
  s.license          = 'MIT'
  s.author           = { "zhuayi" => "2179942@qq.com" }
  s.source           = { :git => "https://github.com/zhuayi/ZCharts.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = { 'ZCharts' => ['Pod/Assets/*'] }

end
