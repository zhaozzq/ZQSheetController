Pod::Spec.new do |s|
  s.name         = "ZQSheetController"
  s.version      = "0.1"
  s.source       = { :git => "https://github.com/zhaozzq/ZQSheetController.git", :tag => "#{s.version}" }
  s.summary      = "SheetController."
  s.description  = "SheetController."
  s.homepage     = "https://github.com/zhaozzq/ZQSheetController"
  s.license      = 'MIT'
  s.authors      = {'zhaozzq' => 'zhao_zzq2012@163.com'}
  s.social_media_url   = "https://twitter.com/ZHAOZQMOS"
  s.ios.deployment_target = "9.0"
  # s.osx.deployment_target = "10.9"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"
  s.source_files  = "ZQSheetController/Source/**/*.swift"
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.1'}
end