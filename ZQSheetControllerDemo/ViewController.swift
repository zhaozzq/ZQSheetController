//
//  ViewController.swift
//  ZQSheetControllerDemo
//
//  Created by zhaozq on 2018/6/28.
//  Copyright © 2018年 HYJF. All rights reserved.
//

import UIKit
import ZQSheetController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func show(_ sender: UIButton) {
//        let sheet = ZQSheetController()
//        //sheet.show()
//        sheet.show {
//            print("show")
//        }

        let sheet1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sheet")
        
        if let sheet = sheet1 as? ZQSheetController {
            sheet.presentingHeight = 300.0
            //sheet.backgroundColor = UIColor.red
            sheet.show()
        }
    }
    
}

