import UIKit
import Flutter
import GoogleMaps
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure();
    GMSServices.provideAPIKey("AIzaSyBnDRMsZRpggqHJ60tyjJCxCGxCnK8PXR8");
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, 
    didFinishLaunchingWithOptions: launchOptions)
  }
}
