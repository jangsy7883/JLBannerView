Pod::Spec.new do |s|
  s.name         = "JLBannerView"
  s.version      = "1.6"
  s.summary      = "JLBannerView"
  s.homepage     = "https://github.com/jangsy7883/JLBannerView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "hmhv" => "jangsy7883@gmail.com" }
  s.source       = { :git => "https://github.com/jangsy7883/JLBannerView.git", :tag => s.version }
  s.source_files = 'JLBannerView/*.{h,m}'
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
end
