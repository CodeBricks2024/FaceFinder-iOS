# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def libraries_ui
 # UI
    pod 'Toaster'
		pod 'SnapKit'
    pod 'NVActivityIndicatorView', '~> 5'
end

def libraries_network
  # Network
    pod 'Moya/RxSwift', '~> 15.0'
end

def libraries_reactive
	# Rx
	pod 'RxSwift', '~> 6'
  pod 'RxCocoa', '~> 6'
  pod 'RxGesture'
  pod 'Action', '~> 5.0'
  pod 'lottie-ios'
	pod 'RxDataSources', '~> 5.0'
end

target 'FaceFinder' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FaceFinder
  libraries_ui
	libraries_reactive
  libraries_network

end
