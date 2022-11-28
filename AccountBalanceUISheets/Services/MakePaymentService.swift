//
//  MakePaymentService.swift
//  AccountBalanceUISheets
//
//  Created by Sharma, Nitish (GT RET Consumer Serv EL- Delivery L, Group Transformation) on 28/11/2022.
//

import Foundation

final class MakePaymentService {
    
    var throwError: Bool = false
    func pay(amount: String, completion: @escaping (Bool) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            return  self.throwError ? completion(false) : completion(true)
        }
    }
}
