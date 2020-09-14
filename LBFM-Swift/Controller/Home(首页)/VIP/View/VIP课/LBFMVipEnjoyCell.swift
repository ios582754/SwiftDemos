//
//  LBFMVipEnjoyCell.swift
//  LBFM-Swift
//
//  Created by liubo on 2019/2/25.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit
import Then
class LBFMVipEnjoyCell: UICollectionViewCell {
    // 图片
    private var imageView =  UIImageView().then {_ in
       
    }
    // 标题
    private var titleLabel = UILabel().then  {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 0
    }
    
    // 喜点
    private var couponLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13)
    }
//    let label = UILabel().then {
//      $0.textAlignment = .center
//      $0.textColor = .black
//      $0.text = "Hello, World!"
//    }
    // 会员免费
    private var freeLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.backgroundColor = UIColor.init(red: 203/255.0, green: 148/255.0, blue: 95/255.0, alpha: 1)
        $0.text = "会员免费"
        $0.textColor = UIColor.white
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpLayout(){
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-110)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        
        self.addSubview(self.couponLabel)
        self.couponLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.freeLabel)
        self.freeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(55)
            make.top.equalTo(self.couponLabel.snp.bottom).offset(5)
            make.height.equalTo(18)
        }
    }
    var categoryContentsModel:LBFMCategoryContents? {
        didSet {
            guard let model = categoryContentsModel else {return}
            self.imageView.kf.setImage(with: URL(string: model.coverLarge!))
            self.titleLabel.text = model.title
            // self.couponLabel.text = model.displayDiscountedPrice
            let text = NSMutableAttributedString(string: "")
            text.append(NSAttributedString(string: " \(model.displayDiscountedPrice ?? "0") ",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
            
            self.couponLabel.attributedText = text
            
        }
    }
}
