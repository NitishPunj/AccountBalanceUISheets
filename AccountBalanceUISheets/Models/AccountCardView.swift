//
//  AccountCardView.swift
//  AccountBalanceUISheets
//
//  Created by Sharma, Nitish (GT RET Consumer Serv EL- Delivery L, Group Transformation) on 28/11/2022.
//

import Foundation

struct AccountCardView {
    var name: String
    var amount: Double
    
    init(name: String, amount: Double) {
        self.name = name
        self.amount = amount
    }
}

extension AccountCardView {
    static var demo: AccountCardView {
        AccountCardView(name: "Demo Account", amount: 3500.00)
    }
    var amountString: String {
       return "£ " + String(round((amount * 100) / 100))
    }
}
