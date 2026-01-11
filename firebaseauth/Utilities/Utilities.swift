//
//  Utilities.swift
//  firebaseauth
//
//  Created by Chanuth Kausilu on 2026-01-11.
//

import UIKit

@MainActor
final class Utilities {

    static let shared = Utilities()
    private init() {}

    /// The active key window for the foreground scene
    var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first(where: { $0.activationState == .foregroundActive })?
            .keyWindow
    }

    /// Root view controller of the key window
    var rootViewController: UIViewController? {
        keyWindow?.rootViewController
    }

    /// The currently visible (top-most) view controller
    func topViewController(
        from controller: UIViewController? = nil
    ) -> UIViewController? {

        let controller = controller ?? rootViewController

        if let navigationController = controller as? UINavigationController {
            return topViewController(from: navigationController.visibleViewController)
        }

        if let tabBarController = controller as? UITabBarController {
            return topViewController(from: tabBarController.selectedViewController)
        }

        if let presented = controller?.presentedViewController {
            return topViewController(from: presented)
        }

        return controller
    }
}
