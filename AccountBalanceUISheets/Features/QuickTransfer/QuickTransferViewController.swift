//
//  QuickTransferViewController.swift
//  AccountBalanceUISheets
//
//  Created by Sharma, Nitish (GT RET Consumer Serv EL- Delivery L, Group Transformation) on 28/11/2022.
//

import UIKit

protocol QuickTransferCoordinatorType: AnyObject {
    func dismiss(paymentSuccessfull: Bool, vc: QuickTransferViewController)
}

class QuickTransferViewController: UIViewController {
    private var max: Double = 1000
    @IBOutlet weak var amountLabel: UITextField!
    private unowned var coordinator: QuickTransferCoordinatorType
    private var repository: AccountRepository!
    private let demoOption: DemoOption!
    
    @IBAction func incrementPressed(_ sender: Any) {
        guard amountValue + 5 <= max else { amountValue = max
            return
        }
        amountValue += 5
    }
    @IBAction func decrementPressed(_ sender: Any) {
        guard amountValue - 5 >= 0 else { amountValue = 0
            return
        }
        amountValue -= 5
    }
    
    private var amountValue: Double = 0.00 {
        didSet {
            amountLabel?.text = String(round((oldValue * 100) / 100))
        }
    }

    init(repository: AccountRepository, coordinator: QuickTransferCoordinatorType, option: DemoOption = .dynamic) {
        self.repository = repository
        self.coordinator = coordinator
        self.demoOption = option
        super.init(nibName: String(describing: QuickTransferViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        amountLabel.text = String(round((amountValue * 100) / 100))
    }
    
    @IBAction func payPressed(_ sender: Any) {
        guard let amount = amountLabel.text else { return }
        MakePaymentService().pay(amount: amount) { [weak self] result in
            guard let self = self,
            self.demoOption != .default  else { return }
            self.coordinator.dismiss(paymentSuccessfull: result, vc: self)
        }
    }
}


/// Take it further
/// Exercises
/*
 1. Try builidng your own custom UIStepper and replace the buttons here
 2. Implement logic to update amount value when user enters it mannyaly
 3. // Check transfer amount to not be more than balance or max limit
 3. Use Data binding technique to update user data
 */

