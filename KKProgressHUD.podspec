#
#  Be sure to run `pod spec lint KKProgressHUD.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "KKProgressHUD"
  s.version      = "0.0.3"
  s.summary      = "Loading"

  s.description  = <<-DESC
                  Loader and toast
                   DESC
  s.homepage     = "https://github.com/cmadc/KKProgressHUD"
  s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "CaiMing" => "davis_cai@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/cmadc/KKProgressHUD.git", :tag => "#{s.version}" }
  s.source_files = "Pod/Classes/**/*"
  s.resources = ['Pod/Resource/*.png']
  s.requires_arc = true
  s.dependency "MBProgressHUD"

end
