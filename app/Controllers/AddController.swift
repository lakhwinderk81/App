//
//  AddController.swift
//  app
//
//  Created by apple on 19/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class AddController: UIViewController {
    
    @IBOutlet var tfType:UITextField?
    @IBOutlet var tfDescription:UITextField?
    @IBOutlet var tfAmount:UITextField?
    
    var itemPicker: UIPickerView = UIPickerView()
    var pickerItems = ["Credit", "Debit"]

    override func viewDidLoad() {
        super.viewDidLoad()
        itemPicker.delegate = self
        tfType?.inputView = itemPicker
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTransactionAction(sender: UIButton){
        if tfType?.text != "" && tfDescription?.text != "" && tfAmount?.text != ""{
            let isCredit = tfType?.text == "Credit"
            let amount :Int = Int(tfAmount?.text ?? "0")!
            AppManager.sharedInstance.save(desc: tfDescription?.text ?? "", isCredit: isCredit, amount: amount, callback: {result in
                if result{
                    self.dismiss(animated: true, completion: nil)
                    if let oldVc = self.presentingViewController as? ViewController{
                        oldVc.setData()
                    }
                }else{
                    print("enable to save")
                }
            })
        }
    }
}

extension AddController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfType?.text = self.pickerItems[row]
    }
}
