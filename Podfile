source 'https://gitee.com/mirrors/CocoaPods-Specs.git'

platform :ios, '9.0'

target 'online-iOS' do
  
  inhibit_all_warnings!
  use_frameworks!
  
  pod 'BaiduMapKit', '~> 6.1.0'
  pod 'BMKLocationKit', '~> 2.0.0'
  pod 'Masonry', '~> 1.1.0'
  pod 'MJRefresh', '~> 3.5.0'
  pod 'MJExtension', '~> 3.2.2'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'SDCycleScrollView','~> 1.82'
  pod 'Charts', '~> 3.6.0'

  pod 'Bugly','~> 2.5.71'
  pod 'JPush', '~> 3.4.0'
  pod 'YTKNetwork', '~> 3.0.4'
  
  # 友盟分享
  pod 'UMCShare/Social/WeChat', '~> 6.10.2'
  pod 'UMCShare/Social/QQ', '~> 6.10.2'
  
  # 代码提交规范
  pod 'SpaceCommander', '~> 2.0.0'
  
end


post_install do |installer|
    
    `./Pods/SpaceCommander/setup-repo.sh`
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
        end
    end
end
