//
//  LBFMHomeVipHeaderView.swift
//  LBFM-Swift
//
//  Created by liubo on 2019/2/25.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit
import Then
class LBFMHomeVipHeaderView: UITableViewHeaderFooterView {
    // 标题
    private var titleLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20)
    }
    
    private var moreBtn = UIButton().then {
//        let button = UIButton.init(type: UIButton.ButtonType.custom)
        $0.setTitle("更多 >", for: UIControl.State.normal)
        $0.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
       
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpLayout()
        self.tintColor = UIColor.red
    }
    
    func setUpLayout(){
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "最热有声读物"
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        self.addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(15)
            make.top.equalTo(10)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
    var titStr: String? {
        didSet{
            guard let string = titStr else {return}
            self.titleLabel.text = string
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
