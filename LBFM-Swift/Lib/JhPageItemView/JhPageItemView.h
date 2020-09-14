//
//  JhPageItemView.h
//
//
//  Created by Jh on 2018/11/15.
//  Copyright © 2018 Jh. All rights reserved.
//  

#import <UIKit/UIKit.h>
#import "JhPageControl.h"


NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM (NSInteger ,JhLayoutStyle){
    
    /** 系统排列方式
     135
     246
     */
    JhSystemHorizontalArrangement = 0,
    
    /** 自定义排列方式
     123
     456
     */
    JhCustomHorizontalArrangement,
    
};






@class JhPageItemView;
@protocol JhPageItemViewDelegate <NSObject>
- (void)JhPageItemViewDelegate:(JhPageItemView *)JhPageItemViewDeleagte indexPath:(NSIndexPath * )indexPath;
@end




@interface JhPageItemView : UIView

- (instancetype)initWithFrame:(CGRect)frame withmaxColumn:(NSInteger )maxColumn maxRow:(NSInteger )maxRow;


/** 列 默认5 */
@property (nonatomic,assign) NSInteger maxColumn;
/** 行 默认2 */
@property (nonatomic,assign) NSInteger maxRow;
/** item 水平间距 默认5 */
@property (nonatomic, assign) CGFloat itemHorizontalMargin;
/** item 垂直间距 默认5 */
@property (nonatomic, assign) CGFloat itemVerticalMargin;
/** 左右离屏幕的间距 默认10 */
@property (nonatomic, assign) CGFloat kLeftRightMargin;
/** 上下按钮离屏幕的间距 默认10 */
@property (nonatomic, assign) CGFloat kTopBottomMargin;


/********************************* 滚动条相关 ********************************/

/** 系统样式slideBackView宽度 */
@property (nonatomic, assign) CGFloat slideBackView_width;
/** 系统样式sliderView宽度 */
@property (nonatomic, assign) CGFloat sliderView_width;
/** 滚动条 其他 颜色 */
@property(nonatomic,strong) UIColor *other_BGColor;
/** 滚动条 当前 颜色 */
@property(nonatomic,strong) UIColor *current_BGColor;
/** 滚动条 是否隐藏  默认NO */
@property (assign, nonatomic) BOOL pageControlIsHidden;

/** 滚动条 位置 默认居中 */
@property(nonatomic) JhPageControlContentMode PageControlContentMode;
/** 滚动条样式 默认按照 controlSize 设置的值,如果controlSize未设置 则为大小为5的小圆点 */
@property(nonatomic) JhPageControlStyle PageControlStyle;
/** 滚动条 距离初始位置 间距  默认0 */
@property (nonatomic) CGFloat PageControlMarginSpacing;
/** 滚动条 间距 默认3 */
@property (nonatomic) CGFloat PageControlSpacing;

/********************************* 滚动条相关 ********************************/


// 数据源
@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic, assign) JhLayoutStyle layoutStyle;

@property (nonatomic, weak) id<JhPageItemViewDelegate> delegate;



@end

NS_ASSUME_NONNULL_END
