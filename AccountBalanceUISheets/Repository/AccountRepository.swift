//
//  AccountRepository.swift
//  AccountBalanceUISheets
//
//  Created by Sharma, Nitish (GT RET Consumer Serv EL- Delivery L, Group Transformation) on 28/11/2022.
//

import Foundation

class AccountRepository {
    var account: AccountCardView = .demo
    
    func updateBalance() {
        account.amount = account.amount - 50
    }
}
