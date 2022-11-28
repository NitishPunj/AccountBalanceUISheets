//
//  AccountHomeTableViewController.swift
//  AccountBalanceUISheets
//
//  Created by Sharma, Nitish (GT RET Consumer Serv EL- Delivery L, Group Transformation) on 28/11/2022.
//

import UIKit

class AccountHomeTableViewController: UITableViewController {
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    var repository: AccountRepository!
    
    var coordinator: AccountHomeCoordinatorType?
    var favAccount: AccountCardView! {
        didSet {
            balanceLabel?.text = favAccount.amountString
            accountLabel?.text = favAccount.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Good day!"
        favAccount = repository.account
    }
    
    @IBAction func fav1Selected(_ sender: Any) {
        print("Paying Lalita")
        coordinator?.quickTransfer(demoOption: .default)
    }
    
    @IBAction func fav2Selected(_ sender: Any) {
        print("Paying Darcy")
        coordinator?.quickTransfer(demoOption: .medium)
    }
    
    @IBAction func fav3Selected(_ sender: Any) {
        print("Paying CreditCard")
        coordinator?.quickTransfer(demoOption: .dynamic)
    }
    
    func updateView() {
        favAccount = repository.account
    }
    
}
