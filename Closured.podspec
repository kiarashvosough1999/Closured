
Pod::Spec.new do |spec|


  spec.name         = "Closured"
  spec.version      = "1.0.0"
  spec.summary      = "Pure Swift Library To Manage Closures"


  spec.description  = <<-DESC
       This pod will help you manage closure
                   DESC

  spec.homepage     = "https://github.com/kiarashvosough1999/Closured.git"


  spec.license      = { :type => "MIT", :file => "LICENSE" }


  spec.author       = { "kiarashvosough1999" => "vosough.k@gmail.com" }


  spec.ios.deployment_target = '9.0'
  spec.osx.deployment_target = '10.15'

  spec.source = { :git => "https://github.com/kiarashvosough1999/Closured.git", :tag => "#{spec.version}" }

  spec.source_files  =  "Closured/**/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"
  
  spec.swift_versions = ['5.1', '5.2', '5.3', '5.4' , '5.5']
  spec.framework = "Foundation"


end
