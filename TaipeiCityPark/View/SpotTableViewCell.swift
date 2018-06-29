//
//  SpotTableViewCell.swift
//  TaipeiCityPark
//
//  Created by ChenAlan on 2018/6/29.
//  Copyright © 2018年 ChenAlan. All rights reserved.
//

import UIKit

class SpotTableViewCell: UITableViewCell {
    @IBOutlet weak var spotImageView: UIImageView!
    @IBOutlet weak var spotNameLabel: UILabel!
    @IBOutlet weak var spotIntroductionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    
}
