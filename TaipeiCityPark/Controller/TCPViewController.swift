//
//  TCPViewController.swift
//  TaipeiCityPark
//
//  Created by ChenAlan on 2018/6/29.
//  Copyright © 2018年 ChenAlan. All rights reserved.
//

import UIKit

class TCPViewController: UIViewController {
    var spots = [Spot]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        TCPClient().taskForGETSpot()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

