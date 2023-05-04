//
//  ADNavigationRouter.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 29/04/23.
//

import UIKit

/// App Navigation Class
class ADNavigator {
    enum ScreenType {
        case verificationScreen
        case dashboard
    }

    enum TransitionType {
        //Set Root View Controller
        case root
        ///Push the View Controller
        case push
    }

    private class var window: UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: \.isKeyWindow) else {
            return nil
        }
        return window
    }

    /**
    Make transition to specified View Controller

     - Parameters:
        - screen: `ScreenType` to navigate on.
        - transitionType: `TransitionType` for the visual effects and update navigation stack. default is push
        -  data:  Dictionary<String:Any> containing data to pass on provieded screen

     - Returns: Void
     */
    class func navigateTo(screen: ScreenType,
                          transitionType: TransitionType = .push,
                          data: [String:Any]? = nil) {
        var viewController:UIViewController = UIViewController()
        viewController = ADNavigator.getViewController(screen: screen, data: data)
        makeTransitionToScreen(viewController: viewController, transitionType: transitionType)
    }

    ///Move back to previous View Controller
    class func navigateBack() {
        guard let window = window else {
            assertionFailure("Could not get window for navigation")
            return
        }
        let topViewController = window.topMostWindowController()
        guard let navController = topViewController as? UINavigationController else {
            assertionFailure("Could not get Navigation Controller")
            return
        }
        navController.popViewController(animated: true)
    }

    class func getViewController(screen: ScreenType, data: [String:Any]?) -> UIViewController {
        switch screen {
        case .verificationScreen: return getVerificationScreen(data: data)
        case.dashboard: return getDashboardScreen(data: data)
        }
    }

    class func  makeTransitionToScreen(viewController: UIViewController, transitionType: TransitionType) {
        if transitionType == .root {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                assertionFailure("No scene")
                return
            }
            windowScene.windows.first?.rootViewController = viewController
            return
        }
        
        guard let window = window else {
            assertionFailure("Could not get window for navigation")
            return
        }
        let topViewController = window.topMostWindowController()
        guard let navController = topViewController as? UINavigationController else {
            assertionFailure("Could not get Navigation Controller")
            return
        }
        navController.pushViewController(viewController, animated: true)
    }

  
}

//MARK: StoryBoards
extension ADNavigator {
    class func onBoardingStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    class func DashboardStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Dashboard", bundle: Bundle.main)
    }
}

//MARK: UIViewControllers
extension ADNavigator {
     class func getVerificationScreen(data: [String: Any]?) -> VerificationViewController {
         guard let vc = onBoardingStoryboard().instantiateViewController(withIdentifier: "VerificationViewController") as? VerificationViewController else {
             assertionFailure("Could not get vc - \(VerificationViewController.description())")
             return VerificationViewController()
         }
         var viewModel: VerificationViewModel?
         if let user = data?["user"] as? User {
             viewModel = VerificationViewModel(user: user)
         }
         vc.viewModel = viewModel
         return vc
     }

     class func getDashboardScreen(data: [String: Any]?) -> DashboardViewController {
         guard let vc = DashboardStoryboard().instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController else {
             assertionFailure("Could not get vc - \(DashboardViewController.description())")
             return DashboardViewController()
         }
         var viewModel: DashboardViewModel?
         if let user = data?["user"] as? User {
             viewModel = DashboardViewModel(user: user)
         }
         vc.viewModel = viewModel
         return vc
     }
}
