#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint add_to_wallet.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'add_to_wallet'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin interacting with Apple Wallet.'
  s.description      = <<-DESC
Flutter plugin exposing native PKAddPassButton to interact with the Apple Wallet
                       DESC
  s.homepage         = 'https://github.com/barkibu/add_to_wallet'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Barkibu' => 'leo@barkibu.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
