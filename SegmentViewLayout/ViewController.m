//
//  ViewController.m
//  SegmentViewLayout
//
//  Created by 唯赢 on 2017/12/27.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "SegmentViewLayout.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, SegmentViewLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *sizes;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sizes = @[[NSValue valueWithCGSize:CGSizeMake(50, 30)],
                   [NSValue valueWithCGSize:CGSizeMake(100, 30)],
                   [NSValue valueWithCGSize:CGSizeMake(70, 30)],
                   [NSValue valueWithCGSize:CGSizeMake(30, 30)],
                   [NSValue valueWithCGSize:CGSizeMake(120, 30)],
                   [NSValue valueWithCGSize:CGSizeMake(40, 30)],
                   [NSValue valueWithCGSize:CGSizeMake(90, 30)],
                   [NSValue valueWithCGSize:CGSizeMake(200, 30)]];
    
    SegmentViewLayout *layout = [[SegmentViewLayout alloc] init];
    layout.layoutDelegate = self;
    layout.minimumInteritemSpacing = 10;
    layout.edgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    self.collectionView.collectionViewLayout = layout;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.sizes.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"测试数据-%lu", indexPath.row];
    return cell;
}

- (CGSize)layout:(SegmentViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.sizes objectAtIndex:indexPath.row] CGSizeValue];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
