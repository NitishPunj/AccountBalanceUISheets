//
//  AppManager.swift
//  AccountBalanceUISheets
//
//  Created by Sharma, Nitish (GT RET Consumer Serv EL- Delivery L, Group Transformation) on 28/11/2022.
//

import UIKit

final class AppManager {
    private let window: UIWindow
    private let appFlowCoordinator: AppCoordinator

    init(window: UIWindow) {
        self.window = window
        self.appFlowCoordinator = AppCoordinator(window: window)
    }

    public func startApp() {
        appFlowCoordinator.start()
    }
}
