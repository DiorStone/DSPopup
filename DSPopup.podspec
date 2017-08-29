Pod::Spec.new do |s|

  s.name         = "DSPopup"
  s.version      = "0.1.0"
  s.summary      = "a api for popup."
  s.homepage     = "https://github.com/DiorStone/DSPopup"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Dior-Stone" => "mrdaios@gmail.com" }
  s.source       = { :git => "https://github.com/DiorStone/DSPopup.git", :tag => s.version }

  s.source_files  = "Sources/**/*.{swift}"

  s.ios.deployment_target = '8.0'
end
