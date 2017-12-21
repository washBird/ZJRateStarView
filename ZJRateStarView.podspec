#
#  Be sure to run `pod spec lint ZJRateStarView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ZJRateStarView"
  s.version      = "0.1"
  s.summary      = "A Star-rating component"

  s.description  = <<-DESC
  					   a star-rating component 
  					   that you can change the star image, 
  					   can rate half or float star, 
  					   can custom star numbers...
                   DESC

  s.homepage     = "https://github.com/washBird/ZJRateStarView"
  s.license      = { :type => "MIT", :file => "LICENSE"}
  s.author       = { "zoujie" => "http://www.jianshu.com/u/53c30d50712c" }
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/washBird/ZJRateStarView.git", :tag => "#{s.version}" }

  s.source_files = "ZJRateStarView/ZJRateStarView/*.{h,m}"
  s.resources    = "ZJRateStarView/ZJRateStarView/ZJRateStarView.bundle"

end
