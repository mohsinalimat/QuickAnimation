
Pod::Spec.new do |s|

 

  s.name         = "QuickAnimation"
  s.version      = "0.0.1"
  s.summary      = "iOS utility classes for creating common animations quickly,referred to Unity Dotween.
The library is based on the facebook's pop library."
  s.homepage     = "https://github.com/SpadeChen/QuickAnimation"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "SpadeChen"
  s.platform     = :ios, "6.0"
  s.ios.deployment_target = "6.0"
  s.source       = { :git => 'https://github.com/SpadeChen/QuickAnimation.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.public_header_files = "Classes/**/*.h"
  s.frameworks = 'UIKit', 'QuartzCore','CoreFoundation','CoreText'

  s.dependency "pop", "~> 1.0.9"

end
