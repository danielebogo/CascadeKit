Pod::Spec.new do |s|
  s.name             = 'Cascade'
  s.version          = '1.0.0'
  s.summary          = 'A short description of Cascade.'

  s.description      = <<-DESC
TODO: We will add one asap.
                       DESC

  s.homepage         = 'https://github.com/danielebogo/Cascade'
  s.license          = { :type => 'Apache', :file => 'LICENSE' }
  s.authors           = { 'Daniele Bogo' => 'me@bogodaniele.com',
                          'Ennio Masi' => 'ennio.masi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielebogo/Cascade.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Cascade/**/*'
end
