Pod::Spec.new do |s|
  s.name             = 'CascadeKit'
  s.version          = '1.0.0'
  s.summary          = 'A short description of CascadeKit.'

  s.description      = <<-DESC
TODO: We will add one asap.
                       DESC

  s.homepage         = 'https://github.com/cascadekit/CascadeKit'
  s.license          = { :type => 'Apache', :file => 'LICENSE' }
  s.authors           = { 'Daniele Bogo' => 'me@bogodaniele.com',
                          'Ennio Masi' => 'ennio.masi@gmail.com' }
  s.source           = { :git => 'https://github.com/cascadekit/CascadeKit', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'CascadeKit/**/*'
end
