//
//  SegmentViewLayout.h
//  SegmentViewLayout
//
//  Created by 唯赢 on 2017/12/27.
//  Copyright © 2017年 李立. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SegmentViewLayout;
@protocol SegmentViewLayoutDelegate <NSObject>
@required
- (CGSize)layout:(SegmentViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SegmentViewLayout : UICollectionViewLayout
@property (assign, nonatomic) IBInspectable UIEdgeInsets edgeInsets;
@property (assign, nonatomic) IBInspectable CGFloat minimumLineSpacing;      //行间距
@property (assign, nonatomic) IBInspectable CGFloat minimumInteritemSpacing; //列间距
@property (weak , nonatomic) id<SegmentViewLayoutDelegate> layoutDelegate;   //布局代理




@end



