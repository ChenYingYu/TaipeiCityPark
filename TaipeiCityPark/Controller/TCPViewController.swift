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
    var imageCache = [String: UIImage?]()
    let spinner = UIActivityIndicatorView()
    @IBOutlet weak var spotTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        spotTableView.delegate = self
        spotTableView.dataSource = self
        let nib = UINib(nibName: "SpotTableViewCell", bundle: nil)
            spotTableView.register(nib, forCellReuseIdentifier: "Cell")
        requestSpot()
    }

    func requestSpot() {
        self.runSpinner(spinner, in: self.view)
        TCPClient().taskForGETSpot(offset: spots.count) { [weak self] (spots, error) in
            guard error == nil else {
                print(error ?? "Found Error")
                DispatchQueue.main.async {
                    self?.spinner.stopAnimating()
                }
                return
            }
            
            if let mySpots = spots {
                self?.spots += mySpots
                DispatchQueue.main.async {
                    self?.spotTableView.reloadData()
                }
            }
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
            }
        }
    }
}

extension TCPViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SpotTableViewCell, spots.count > indexPath.row else {
            return UITableViewCell()
        }

        cell.spotNameLabel.text = spots[indexPath.row].spotName
        cell.spotIntroductionLabel.text = spots[indexPath.row].introduction

        if let image = imageCache[spots[indexPath.row].spotName] {
            cell.spotImageView.image = image
        } else {
            if let imageURL = URL(string: spots[indexPath.row].imageURL) {
                do {
                    let imageData = try Data(contentsOf: imageURL)
                    let image = UIImage(data: imageData)
                    cell.spotImageView.image = image
                    imageCache.updateValue(image, forKey: spots[indexPath.row].spotName)
                } catch let error {
                    print("Image parse failed. Error: \(error)")
                }
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = spots.count - 1
        if indexPath.row == lastItem {
            requestSpot()
        }
    }
}

extension UIViewController {
    func runSpinner(_ spinner: UIActivityIndicatorView, in view: UIView) {
        spinner.color = UIColor.gray
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
    }
}
