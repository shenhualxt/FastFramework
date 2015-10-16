//
//  CollectionViewController.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/13.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "CollectionViewController.h"
#import "CustomCollectionViewCell.h"

@interface CollectionViewController ()<UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic) HRCollectionViewBindingHelper *helper;

@property(nonatomic, strong) NSMutableArray *toolsArray;

@end

@implementation CollectionViewController

-(instancetype)init{
    UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
    layout.sectionInset=UIEdgeInsetsMake(4, 6, 4, 6);
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.helper=[HRCollectionViewBindingHelper bindWithCollectionView:self.collectionView dataSource:RACObserve(self, toolsArray) selectionCommand:nil templateCellClass:[CustomCollectionViewCell class]];
    self.helper.delegate=self;
}

//根据不同屏幕宽度调整cell宽度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-24)/2, self.helper.cellHeight);
}

-(NSMutableArray *)toolsArray{
    if (!_toolsArray) {
        _toolsArray = [NSMutableArray array];
        for (int i = 0; i < 20; ++i) {
            [_toolsArray addObject:[NSString stringWithFormat:@"title%d",i]];
        }
    }
    return _toolsArray;
}

@end
