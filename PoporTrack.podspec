#
# Be sure to run `pod lib lint PoporTrack.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PoporTrack'
  s.version          = '0.0.2'
  s.summary          = 'A short description of PoporTrack.'

  s.homepage         = 'https://github.com/popor/PoporTrack'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'popor' => '908891024@qq.com' }
  s.source           = { :git => 'https://github.com/popor/PoporTrack.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'PoporTrack/Classes/**/*'
  
  s.ios.dependency 'PoporFoundation/PrefixCore'
  s.ios.dependency 'PoporFoundation/NSObject'
  #s.ios.dependency 'PoporFoundation/NSString'
  
  
end
