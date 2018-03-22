Pod::Spec.new do |s|
  s.name         = "PictureProcessKit"
  s.version      = "1.0"
  s.ios.deployment_target = '8.0'
  s.summary      = "A collection for picture-processing tool ，updating ..."
  s.homepage     = "https://github.com/HeterPu/PictureProcessKit"
  s.license      = "MIT"
  s.author             = { "HuterPu" => "wycgpeterhu@sina.com" }
  s.social_media_url   = "http://weibo.com/u/2342495990"
  s.source       = { :git => "https://github.com/HeterPu/PictureProcessKit.git", :tag => s.version }
  s.source_files  = "PictureProcessKitTest/PictureProcessKitTest/PictureProcessKit/**/*.{h,m,c}"
  s.requires_arc = true

  s.frameworks = 'Foundation', 'UIKit'
end
