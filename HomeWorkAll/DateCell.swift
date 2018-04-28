//
//  DateCell.swift
//  HomeWorkAll
//
//  Created by CLINK on 2018/4/23.
//  Copyright © 2018年 CLINK. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell {
    var label: UILabel!
    var label2: UILabel!
    var lableImageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blue
        
        label = UILabel(frame: CGRect(x: 0, y: 0,
                                          width: UIScreen.main.bounds.size.width,
                                          height: 40))
        
        //label.text = "這世界多麽美好"
        label.textColor = UIColor.orange
        label.font = UIFont.systemFont(ofSize: 36)
        
        self.addSubview(label)
        
        
        
        label2 = UILabel(frame: CGRect(x: 0, y: 40,
                                           width: UIScreen.main.bounds.size.width,
                                           height: 30))
        
        
        //label2.text = "空氣這麽清晰"
        label2.textColor = UIColor.white
        label2.font = UIFont.systemFont(ofSize: 28)
        self.addSubview(label2)
       
   
       
        lableImageView = UIImageView()
        
        lableImageView.contentMode = .scaleAspectFit
        lableImageView.contentMode = UIViewContentMode.center
        lableImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lableImageView)
        lableImageView.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 2).isActive = true
        lableImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lableImageView.leftAnchor.constraint(equalTo: label2.leftAnchor).isActive = true
        lableImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
