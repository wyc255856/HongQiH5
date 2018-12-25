#
#  Be sure to run `pod spec lint HongQiH5.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "HongQiH5"
  s.version      = "1.0.0"
  s.summary      = "A short description of HongQiH5SDK."

  s.description  = <<-DESC
		   HongQi H5 Easy Fast!
                   DESC

  s.homepage     = "http://EXAMPLE/HongQiH5"

  s.license      = "Copyright (c) 2018年 HongQiH5SDK. All rights reserved."

  s.author             = { "张三" => "zhangsan0103@gmail.com" }

  s.platform     = :ios, "8.0"

  s.ios.deployment_target = "8.0"

   s.source       = { :git => "https://github.com/wyc255856/HongQiH5.git", :tag => "#{s.version}" }



   s.source_files  = "HongQiH5", "HongQiH5SDKiOS/HongQiH5SDK/*.{h,m,c}"
  s.exclude_files = "Classes/Exclude"
  s.resource = "HongQiH5SDKiOS/HongQiH5SDK/CarResource.bundle"

end
