//
//  LBFMHomeVipCategoriesCell.swift
//  LBFM-Swift
//
//  Created by liubo on 2019/2/25.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit

/// 添加cell点击代理方法
protocol LBFMHomeVipCategoriesCellDelegate:NSObjectProtocol {
    func homeVipCategoriesCellItemClick(id:String,url:String,title:String)
}

class LBFMHomeVipCategoriesCell: CustomTableCell {
    weak var delegate : LBFMHomeVipCategoriesCellDelegate?
    
    private var categoryBtnList:[LBFMCategoryBtnModel]?
    // MARK: - 懒加载九宫格分类按钮
//    -(JhPageItemView *)pageItemView2{
//    if (!_pageItemView2) {
//
//        CGRect femwe =  CGRectMake(0, 350, Kwidth, 90*2+5*2+5*2);
//        JhPageItemView *view =  [[JhPageItemView alloc]initWithFrame:femwe withmaxColumn:5 maxRow:2];
//        view.backgroundColor = [UIColor redColor];
//        view.kTopBottomMargin = 5;
//        view.kLeftRightMargin = 10;
//        view.itemHorizontalMargin = 5.f;
//        view.itemVerticalMargin = 5.f;
//        view.current_BGColor=[UIColor yellowColor];
//        view.layoutStyle = JhCustomHorizontalArrangement;
//
//        view.PageControlStyle = JhPageControlStyelDotAndRectangle;//圆点 + 长条 样式
//        view.PageControlContentMode = JhPageControlContentModeRight;
//        view.PageControlMarginSpacing = 10;
//        view.PageControlSpacing = 5;
//
//        view.delegate =self;
//        self.pageItemView2 = view;
//        [self.view addSubview: self.pageItemView2];
//
//    }
//    return _pageItemView2;
//}
    private lazy var collectionView: JhPageItemView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width:LBFMScreenWidth / 5, height:80)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
//        frame(forAlignmentRect:)
        let collectionView = JhPageItemView(frame:CGRect(x: 0,y: 0,width: LBFMScreenWidth,height: 120) , withmaxColumn: 5, maxRow: 2)
        collectionView.backgroundColor = UIColor.red
        collectionView.kTopBottomMargin = 5
        collectionView.kLeftRightMargin = 0;
        collectionView.itemHorizontalMargin = 5;
        collectionView.itemVerticalMargin = 5;
        collectionView.current_BGColor = UIColor.yellow;
        collectionView.layoutStyle = .customHorizontalArrangement;
        collectionView.pageControlStyle = .styelDotAndRectangle;//圆点 + 长条 样式
        collectionView.pageControlContentMode = .right ;
           collectionView.pageControlMarginSpacing = 10;
           collectionView.pageControlSpacing = 5;
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.height.width.equalToSuperview()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var categoryBtnModel : [LBFMCategoryBtnModel]? {
        didSet {
            guard let model = categoryBtnModel else {return}
            var arrs:[JhPageItemModel] = [];
             self.categoryBtnList = model
            self.categoryBtnList?.forEach({ (modelsss) in
                let mods:JhPageItemModel = JhPageItemModel()
                mods.text = modelsss.title!
                mods.img = modelsss.coverPath!
                arrs.append(mods)
            })
            arrs.removeLast()
            arrs.removeLast()
            arrs.removeLast()
            arrs.removeLast()
            self.collectionView.dataArray = arrs
        }
    }
}

extension LBFMHomeVipCategoriesCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryBtnList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LBFMVipCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LBFMVipCategoryCell", for: indexPath) as! LBFMVipCategoryCell
        cell.backgroundColor = UIColor.white
        cell.categoryBtnModel = self.categoryBtnList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let string = self.categoryBtnList?[indexPath.row].properties?.uri else {
            let id = "0"
            let url = self.categoryBtnList?[indexPath.row].url ?? ""
            delegate?.homeVipCategoriesCellItemClick(id: id, url: url, title: (self.categoryBtnList?[indexPath.row].title)!)
            return
        }
        let id = getUrlCategoryId(url: string)
        let url = self.categoryBtnList?[indexPath.row].url ?? ""
        delegate?.homeVipCategoriesCellItemClick(id: id, url: url,title:(self.categoryBtnList?[indexPath.row].title)!)
    }
    
    
    func getUrlCategoryId(url:String) -> String {
        // 判断是否有参数
        if !url.contains("?") {
            return ""
        }
        var params = [String: Any]()
        // 截取参数
        let split = url.split(separator: "?")
        let string = split[1]
        // 判断参数是单个参数还是多个参数
        if string.contains("&") {
            // 多个参数，分割参数
            let urlComponents = string.split(separator: "&")
            // 遍历参数
            for keyValuePair in urlComponents {
                // 生成Key/Value
                let pairComponents = keyValuePair.split(separator: "=")
                let key:String = String(pairComponents[0])
                let value:String = String(pairComponents[1])
                
                params[key] = value
            }
        } else {
            // 单个参数
            let pairComponents = string.split(separator: "=")
            // 判断是否有值
            if pairComponents.count == 1 {
                return "nil"
            }
            
            let key:String = String(pairComponents[0])
            let value:String = String(pairComponents[1])
            params[key] = value as AnyObject
        }
        return params["category_id"] as! String
    }
}
