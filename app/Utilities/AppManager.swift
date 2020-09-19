//
//  AppManager.swift
//  app
//
//  Created by apple on 19/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import CoreData

class AppManager: NSObject {
    
    class var sharedInstance: AppManager
    {
        struct Static
        {
            static let instance : AppManager = AppManager()
        }
        return Static.instance
    }

    func save(desc: String, isCredit: Bool, amount: Int, callback : @escaping (Bool)-> Void) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      let entity =
        NSEntityDescription.entity(forEntityName: "Transactions",
                                   in: managedContext)!
      
      let record = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
        record.setValue(desc, forKeyPath: "desc")
        record.setValue(amount, forKeyPath: "balance")
        if isCredit{
            record.setValue(amount, forKeyPath: "credit")
            record.setValue(0, forKeyPath: "debit")
        }else{
            record.setValue(amount, forKeyPath: "debit")
            record.setValue(0, forKeyPath: "credit")
        }
        record.setValue(Date(), forKeyPath: "date")
      
      do {
        try managedContext.save()
        callback(true)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
        callback(false)
      }
    }
    
    func fetchData(callback : @escaping ([TransactionModel])-> Void){
        
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Transactions")
        
        do {
            let sort = NSSortDescriptor(key: "date", ascending: true)
            fetchRequest.sortDescriptors = [sort]
          let records = try managedContext.fetch(fetchRequest)
            
            print(records)
            var result = [TransactionModel]()
            var bal = 0
            for record in records as [NSManagedObject] {

                print(record)
                print(record.value(forKey: "date")!)
                print(record.value(forKey: "balance")!)
                var model = TransactionModel()
                let credit = record.value(forKey: "credit") as! Int
                model.isCredit = credit != 0
                model.date = record.value(forKey: "date") as! Date
                model.desc = record.value(forKey: "desc") as! String
                if credit != 0{
                    model.isCredit = true
                    model.amount = record.value(forKey: "credit") as! Int
                    model.balance = bal + model.amount
                    bal = bal + model.amount
                }else{
                    model.isCredit = false
                    model.amount = record.value(forKey: "debit") as! Int
                    model.balance = bal - model.amount
                    bal = bal - model.amount
                }
                result.append(model)
            }
            
            callback(result.reversed())
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
            callback([TransactionModel]())
        }
    }
}
