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
struct YourApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
          if Auth.auth().currentUser != nil {
              HomeView() // Usuario autenticado
          } else {
              LoginView() // No autenticado
        }
      }
    }
  }
}
