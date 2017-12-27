//
//  SegmentViewLayout.m
//  SegmentViewLayout
//
//  Created by 唯赢 on 2017/12/27.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "SegmentViewLayout.h"

@interface SegmentViewLayout ()
@property (assign, nonatomic) CGFloat contentWidth;             // 内容宽度
@property (strong, nonatomic) NSMutableArray *layoutAttributes; //布局属性列表
@property (strong, nonatomic) NSMutableArray *xList;            // x 坐标列表
@property (strong, nonatomic) NSMutableArray *widthList;        // 宽度列表

@end

@implementation SegmentViewLayout


- (NSMutableArray *)layoutAttributes
{
    if (!_layoutAttributes)
    {
        _layoutAttributes = [[NSMutableArray alloc] init];
    }
    
    return _layoutAttributes;
}

- (NSMutableArray *)xList {
    if (!_xList) {
        _xList = [NSMutableArray new];
    }
    
    return _xList;
}

- (NSMutableArray *)widthList {
    if (!_widthList) {
        _widthList = [NSMutableArray new];
    }
    
    return _widthList;
}

- (void)prepareLayout {
    [super prepareLayout];
    // 删除之前的布局信息
    [self.xList removeAllObjects];
    [self.layoutAttributes removeAllObjects];
    //获取所有的Cell的布局属性: UICollectionViewFlowLayoutAttributes 对象
    //读取行
    NSInteger numberOfRows = [self.collectionView numberOfItemsInSection:0];
    // 计算cell的frame
    CGSize size = CGSizeZero;
    for (NSInteger row = 0; row < numberOfRows; row++) {
        if ([self.layoutDelegate respondsToSelector:@selector(layout:sizeForItemAtIndexPath:)]) {
            size = [self.layoutDelegate layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
            CGFloat height = self.collectionView.bounds.size.height - (self.edgeInsets.top + self.edgeInsets.bottom);
            CGFloat y = self.edgeInsets.top;
            CGFloat x = 0;
            if (row) {
                CGRect frame = [self.widthList.lastObject CGRectValue];
                x = frame.origin.x + frame.size.width + self.minimumInteritemSpacing;
            } else {
                x = self.edgeInsets.left;
            }
            
            [self.widthList addObject:[NSValue valueWithCGRect:CGRectMake(x, y, size.width, height)]];
        }
    }
    // 获取Cell尺寸
    for (NSInteger row = 0; row < numberOfRows; row++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.layoutAttributes addObject:attribute];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //返回 rect 区域的所有布局属性
    return [self.layoutAttributes copy];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //根据indexPath获取当前Cell的LayoutAttributes
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.frame = [[self.widthList objectAtIndex:indexPath.row] CGRectValue];
    return attribute;
}


- (CGSize)collectionViewContentSize {
    NSInteger numberOfRows = [self.collectionView numberOfItemsInSection:0];
    CGFloat contentWidth = self.edgeInsets.left + self.edgeInsets.right;
    contentWidth += (numberOfRows - 1) * self.minimumInteritemSpacing;
    for (NSInteger row = 0; row < numberOfRows; row++) {
        CGRect frame = [[self.widthList objectAtIndex:row] CGRectValue];
        contentWidth += frame.size.width;
    }
    
    return CGSizeMake(contentWidth, self.collectionView.bounds.size.height);
}

@end






