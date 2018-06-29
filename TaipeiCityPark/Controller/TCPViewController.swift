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
    @IBOutlet weak var spotTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        spotTableView.delegate = self
        spotTableView.dataSource = self
        let nib = UINib(nibName: "SpotTableViewCell", bundle: nil)
            spotTableView.register(nib, forCellReuseIdentifier: "Cell")
        TCPClient().taskForGETSpot() { (spots, error) in
            guard error == nil else {
                print(error ?? "Found Error")
                return
            }

            if let mySpots = spots {
                self.spots = mySpots
                DispatchQueue.main.async {
                    self.spotTableView.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TCPViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SpotTableViewCell else {
            return UITableViewCell()
        }

        cell.spotNameLabel.text = spots[indexPath.row].spotName
        cell.spotIntroductionLabel.text = spots[indexPath.row].introduction

        return cell
    }
}

