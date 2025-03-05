require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

Pod::Spec.new do |s|
  s.name         = "SwiftTest"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => min_ios_version_supported }
  s.source       = { :git => "https://github.com/prateek0103/react-native-swift-test.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm,cpp,swift}"
  s.public_header_files = "ios/SwiftTest.h"
  s.private_header_files = "ios/generated/**/*.h"
  
  # Swift specific settings
  s.swift_version = "5.0"
  s.module_name = "SwiftTest"
  s.static_framework = true
  s.pod_target_xcconfig = {
    "DEFINES_MODULE" => "YES",
    "CLANG_ENABLE_MODULES" => "YES",
    "SWIFT_INSTALL_OBJC_HEADER" => "YES",
    "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/Headers/Public\" \"$(PODS_ROOT)/Headers/Private\" \"${PODS_ROOT}/boost\" \"${PODS_CONFIGURATION_BUILD_DIR}/React-Codegen/React_Codegen.framework/Headers\" \"${PODS_ROOT}/../../node_modules/react-native/ReactCommon\" \"${PODS_ROOT}/../../node_modules/react-native-swift-test/ios/generated\" \"$(PODS_ROOT)/../..\"/src/generated \"$(SRCROOT)/../generated\"",
    "OTHER_CPLUSPLUSFLAGS" => "-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1",
    "CLANG_CXX_LANGUAGE_STANDARD" => "c++17",
    "OTHER_CFLAGS" => "$(inherited) -DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1",
    "CLANG_CXX_LIBRARY" => "libc++"
  }

  # Use install_modules_dependencies helper to install the dependencies if React Native version >=0.71.0.
  # See https://github.com/facebook/react-native/blob/febf6b7f33fdb4904669f99d795eba4c0f95d7bf/scripts/cocoapods/new_architecture.rb#L79.
  if respond_to?(:install_modules_dependencies, true)
    install_modules_dependencies(s)
  else
    s.dependency "React-Core"

    # Don't install the dependencies when we run `pod install` in the old architecture.
    if ENV['RCT_NEW_ARCH_ENABLED'] == '1' then
      s.compiler_flags = folly_compiler_flags + " -DRCT_NEW_ARCH_ENABLED=1"
      # Extend existing config rather than replacing it
      s.pod_target_xcconfig[:HEADER_SEARCH_PATHS] = s.pod_target_xcconfig[:HEADER_SEARCH_PATHS] + " \"${PODS_CONFIGURATION_BUILD_DIR}/React-RCTFabric/RCTFabric.framework/Headers\""
      s.dependency "React-Codegen"
      s.dependency "RCT-Folly"
      s.dependency "RCTRequired"
      s.dependency "RCTTypeSafety"
      s.dependency "ReactCommon/turbomodule/core"
    end
  end
end
