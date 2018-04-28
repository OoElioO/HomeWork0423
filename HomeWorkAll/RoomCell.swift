//
//  RoomCell.swift
//  HomeWorkAll
//
//  Created by CLINK on 2018/4/23.
//  Copyright © 2018年 CLINK. All rights reserved.
//

import UIKit

class RoomCell: UICollectionViewCell {
    var label: UILabel!
    var label2: UILabel!
    var label3: UILabel!
    var label4: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.green
        label = UILabel(frame: CGRect(x: 0, y: 0,
                                          width: UIScreen.main.bounds.size.width,
                                          height: 25))
        
        label.text = "總統套房"
        label.textColor = UIColor.orange
        label.font = UIFont.systemFont(ofSize: 24)
        
        self.addSubview(label)
        label2 = UILabel(frame: CGRect(x: 0, y: 25,
                                      width: UIScreen.main.bounds.size.width,
                                      height: 16))
        
        label2.text = "總統套房"
        label2.textColor = UIColor.orange
        label2.font = UIFont.systemFont(ofSize: 14)
        
        self.addSubview(label2)
        label3 = UILabel(frame: CGRect(x: 0, y: 40,
                                      width: UIScreen.main.bounds.size.width,
                                      height: 16))
        
        label3.text = "總統套房"
        label3.textColor = UIColor.orange
        label3.font = UIFont.systemFont(ofSize: 14)
        
        self.addSubview(label3)
        label4 = UILabel(frame: CGRect(x: 0, y: 55,
                                      width: UIScreen.main.bounds.size.width,
                                      height: 16))
        
        label4.text = "總統套房"
        label4.textColor = UIColor.orange
        label4.font = UIFont.systemFont(ofSize: 14)
        
        self.addSubview(label4)
        // Do any additional setup after loading the view.
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
