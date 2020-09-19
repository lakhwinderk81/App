//
//  ViewController.swift
//  app
//
//  Created by apple on 19/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tblBalance:UITableView?
    var arrayTracnsactions = [TransactionModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setData()
    }
    
    func setData(){
        AppManager.sharedInstance.fetchData(callback: {reult in
            self.arrayTracnsactions = reult
            self.tblBalance?.reloadData()
        })
    }

    @IBAction func addTrasctionAction(sender: UIButton){
        let addVc = self.storyboard?.instantiateViewController(withIdentifier: "AddController") as! AddController
        self.present(addVc, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayTracnsactions.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceTblCell") as! BalanceTblCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceTblCell") as! BalanceTblCell
        cell.lblDescription?.text = arrayTracnsactions[indexPath.row].desc
        if arrayTracnsactions[indexPath.row].isCredit{
            cell.lblCredit?.text = arrayTracnsactions[indexPath.row].amount.description
            cell.lblDebit?.text = ""
        }else{
            cell.lblDebit?.text = arrayTracnsactions[indexPath.row].amount.description
            cell.lblCredit?.text = ""
        }
        cell.lblBalance?.text = arrayTracnsactions[indexPath.row].balance.description
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/YYYY"
        cell.lblDate?.text = dateformatter.string(from: arrayTracnsactions[indexPath.row].date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
