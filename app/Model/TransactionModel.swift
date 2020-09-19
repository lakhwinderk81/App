//
//  TransactionModel.swift
//  app
//
//  Created by apple on 19/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

struct TransactionModel {
    var isCredit :Bool = false
    var desc :String = ""
    var amount :Int = 0
    var balance :Int = 0
    var date:Date = Date()
} 
