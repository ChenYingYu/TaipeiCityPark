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
        TCPClient().taskForGETSpot() { (spots, error) in
            guard error == nil else {
                print(error ?? "Found Error")
                return
            }

            if let mySpots = spots {
                self.spots = mySpots
                print(self.spots)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

