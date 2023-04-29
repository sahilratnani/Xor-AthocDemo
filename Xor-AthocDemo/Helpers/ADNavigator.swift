//
//  ADNavigationRouter.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 29/04/23.
//

import UIKit

class ADNavigator {
    enum ScreenType {
        case verificationScreen
        case dashboard
    }

    enum TransitionType {
        case root
        case push
    }

    private class var window: UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: \.isKeyWindow) else {
            return nil
        }
        return window
    }

    class func navigateTo(screen: ScreenType,
                          transitionType: TransitionType = .push,
                          data: [String:Any]? = nil) {
        var viewController:UIViewController = UIViewController()
        viewController = ADNavigator.getViewController(screen: screen, data: data)
        makeTransitionToScreen(viewController: viewController, transitionType: transitionType)
    }

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
