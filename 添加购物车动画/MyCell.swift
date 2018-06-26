//
//  MyCell.swift
//  添加购物车动画
//
//  Created by caimengnan on 2018/6/25.
//  Copyright © 2018年 frameworkdemo. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    
    
    @IBOutlet var myImageView: UIImageView!
    
    @IBOutlet var myLabel: UILabel!
    
    var clickCallBack:(() -> (Void))?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    @IBAction func addToShopCartAction(_ sender: UIButton) {
        clickCallBack!()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
