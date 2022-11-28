//
//  AppCoordinator.swift
//  AccountBalanceUISheets
//
//  Created by Sharma, Nitish (GT RET Consumer Serv EL- Delivery L, Group Transformation) on 28/11/2022.
//
import UIKit
final class AppCoordinator {
    
    private let window: UIWindow
    private let navigationController = UINavigationController()
    private let respository = AccountRepository()
    private var homeVC: AccountHomeTableViewController?
    
    
    init(window: UIWindow) {
        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AccountHomeTableViewController") as? AccountHomeTableViewController  else { return }
        vc.coordinator = self
        vc.repository = respository
        homeVC = vc
        navigationController.setViewControllers([vc], animated: true)
    }
}


protocol AccountHomeCoordinatorType:AnyObject {
    func quickTransfer(demoOption: DemoOption)
}

enum DemoOption {
    case medium
    case dynamic
    case `default`
}

extension UISheetPresentationController.Detent.Identifier {
    static let small = UISheetPresentationController.Detent.Identifier("small")
}

extension AppCoordinator: AccountHomeCoordinatorType {

    func quickTransfer(demoOption: DemoOption) {
        
        guard navigationController.presentedViewController == nil else {
            navigationController.dismiss(animated: true) {
                self.quickTransfer(demoOption: demoOption)
            }
            return
        }
        
        switch demoOption {
        case .medium:
            demoOptionMedium()
        case .dynamic:
            demoOptionDynamic()
        case .default:
            demoOptionDefault()
        }
    }
    
    private func demoOptionDefault() {
        let vc = QuickTransferViewController(repository: respository, coordinator: self, option: .default)
        vc.modalPresentationStyle = .formSheet
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    private func demoOptionMedium() {
        let vc = QuickTransferViewController(repository: respository, coordinator: self)
        vc.modalPresentationStyle = .formSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [
                .medium()
            ]
            sheet.largestUndimmedDetentIdentifier = .none
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheet.preferredCornerRadius = 30.0
        }
        navigationController.present(vc, animated: true, completion: nil)
    }
    
   // @available(iOS 15.0, *)
    private func demoOptionDynamic() {
        let vc = QuickTransferViewController(repository: respository, coordinator: self)
        vc.modalPresentationStyle = .popover
        if let popover = vc.popoverPresentationController {
            let sheet = popover.adaptiveSheetPresentationController
            sheet.detents = [
                .medium(),
                .large()
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30.0
            sheet.largestUndimmedDetentIdentifier = .large // to undim the presenting controller .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true // for scroll view to avoid resizing when scrolling
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        navigationController.present(vc, animated: true, completion: nil)
    }
    
}

extension AppCoordinator: QuickTransferCoordinatorType {
    func dismiss(paymentSuccessfull: Bool, vc: QuickTransferViewController) {
        if paymentSuccessfull {
            respository.updateBalance()
        }
        
        func dismiss() {
            vc.dismiss(animated: true) { [weak self] in
               self?.homeVC?.updateView()
            }
        }

        if let sheet = vc.popoverPresentationController?.adaptiveSheetPresentationController {
           
            switch sheet.selectedDetentIdentifier {
            case .medium?:
                dismiss()
                
            case .large?:
                sheet.animateChanges {
                    sheet.selectedDetentIdentifier = .medium
                    homeVC?.updateView()
                }
            default:
                dismiss()
            }
        }
        
        else if let  _  =  vc.sheetPresentationController {
            dismiss()
        }
    }
}

/// Take it further
/// Exercises
/*
 iOS 16 we can even further customise decents using .custom
 */
