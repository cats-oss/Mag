Pod::Spec.new do |s|
  s.name             = 'Mag'
  s.version          = '1.0.1'
  s.swift_version    = '5.0'
  s.summary          = 'Mag is Framework which wraps NSLayoutAnchor.'
  s.homepage         = 'https://github.com/cats-oss/Mag'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kyohei Ito' => 'ito_kyohei@cyberagent.co.jp' }
  s.source           = { :git => 'https://github.com/cats-oss/Mag.git', :tag => s.version.to_s }
  s.ios.deployment_target       = '10.0'
  s.tvos.deployment_target      = '10.0'
  s.osx.deployment_target       = '10.12'
  s.source_files     = 'Mag/**/*.{h,swift}'
  s.requires_arc     = true
end
