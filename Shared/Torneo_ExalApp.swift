import SwiftUI
import FirebaseCore
import FirebaseAuth


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Torneo_ExalApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

   
      var body: some Scene {
        WindowGroup {
          NavigationView {
            ContentView()
            
          }
        }
      }
}


