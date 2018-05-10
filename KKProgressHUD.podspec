#
#  Be sure to run `pod spec lint KKProgressHUD.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "KKProgressHUD"
  s.version      = "0.0.7"
  s.summary      = "Loading"

  s.description  = <<-DESC
                  Loader and toast
                   DESC
  s.homepage     = "https://kakatrip.cn/"
  s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "CaiMing" => "ming.cai@kakatrip.cn" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://git.oschina.net/kakaBTravel/KKProgressHUD.git", :tag => "#{s.version}" }
  s.source_files = "Pod/Classes/**/*"
  s.requires_arc = true
  s.dependency "MBProgressHUD"

end