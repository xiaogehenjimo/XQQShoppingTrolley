//
//  XQQShoppingController.m
//  XQQShoppingTrolley
//
//  Created by XQQ on 2017/1/17.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import "XQQShoppingController.h"
#import "XQQShopModel.h"
#import "XQQShopTableViewCell.h"
#import "XQQShopHeaderView.h"
#import "XQQShopBottomView.h"
#import "XQQCommodityModel.h"

#define xqq_shopName    @"shopName"
#define xqq_commoditys  @"commoditys"
#define xqq_commName    @"commodityName"
#define xqq_commPrice   @"commodityPrice"
#define xqq_commDesc    @"commodityDescription"


@interface XQQShoppingController ()<UITableViewDelegate,UITableViewDataSource,shopCellPressDelegate,xqq_shopBottomViewDelegate,xqq_headerViewDelegate>

/** 视图 */
@property(nonatomic, strong)  UITableView  *  myTableView;
/** 数据源 */
@property(nonatomic, strong)  NSMutableArray  *  dataArr;
/** 选择的数组 */
@property(nonatomic, strong)  NSMutableArray  *  selectedArr;
/** 下方的view */
@property(nonatomic, strong)  XQQShopBottomView  *  bottomView;
@end

@implementation XQQShoppingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    [self initData];
    
}


- (void)initData{

    NSArray * arr =  [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"xqq_shop" ofType:@"plist"]];
    
    for (NSDictionary * dict in arr) {
        XQQShopModel * shopModel = [[XQQShopModel alloc]init];
        [shopModel setValuesForKeysWithDictionary:dict];
        shopModel.isAllSelected = NO;
        [self.dataArr addObject:shopModel];
    }
    [self.myTableView reloadData];
    
    //初始化选择的数组
    for (NSInteger i = 0; i < self.dataArr.count; i ++) {
        NSMutableArray * tempArr = @[].mutableCopy;
        [self.selectedArr addObject:tempArr];
    }
}

- (void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"购物车";
    [self.view addSubview:self.myTableView];
    //创建下方的view
    _bottomView = [[XQQShopBottomView alloc]initWithFrame:CGRectMake(0, iphoneHeight - 70, iphoneWidth, 70)];
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
}

#pragma mark - activity

/*更新数据 tableView的 还有下方价格*/
- (void)updateData{
    
    [self updatePrice];
    [self.myTableView reloadData];
}
/*更新价格*/
- (void)updatePrice{
    //更新底部的价格
    [self.bottomView updateArr:self.selectedArr dataArr:self.dataArr];
    //判断每个店铺是否是全选状态
    for (NSInteger i = 0; i < self.dataArr.count; i ++) {
        XQQShopModel * shopModel = self.dataArr[i];
        NSMutableArray * selectArr = self.selectedArr[i];
        shopModel.isAllSelected = shopModel.commodityArr.count == selectArr.count ? YES : NO;
    }
}

#pragma mark - xqq_headerViewDelegate

/*分组头视图选择按钮被点击了*/
- (void)headerViewDidPress:(NSInteger)index shopModel:(XQQShopModel *)shopModel isSel:(BOOL)isSel{
    XQQShopModel * selShop = self.dataArr[index];
    selShop.isAllSelected = isSel;
    for (XQQCommodityModel * commModel in selShop.commodityArr) {
        commModel.isSelected = isSel;
    }
    //存入选择数组
     NSMutableArray * saveArr = self.selectedArr[index];
    if (isSel) {
        [saveArr setArray:selShop.commodityArr];
    }else{
        [saveArr removeAllObjects];
    }
    [self updateData];
}

#pragma mark - xqq_shopBottomViewDelegate
/*下方全选按钮点击了*/
- (void)selectedAllBtnDidPress:(UIButton *)button isSel:(BOOL)isSel{
        for (XQQShopModel * shopModel in self.dataArr) {
            shopModel.isAllSelected = isSel;
            for (XQQCommodityModel * commModel in shopModel.commodityArr) {
                commModel.isSelected = isSel;
            }
        }
    //添加到选择数组
    if (isSel) {
        for (NSInteger i = 0; i < self.dataArr.count; i ++) {
            NSMutableArray * tempArr = self.selectedArr[i];
            XQQShopModel * shopModel = self.dataArr[i];
            [tempArr setArray:shopModel.commodityArr];
        }
    }else{
        for (NSMutableArray * arr in self.selectedArr) {
            [arr removeAllObjects];
        }
    }
    [self updateData];
}

#pragma mark - shopCellPressDelegate

/** 左侧选择按钮点击 */
- (void)leftSelBtnDidPress:(XQQCommodityModel *)commodModel cell:(XQQShopTableViewCell *)cell isSel:(BOOL)isSel{
    NSInteger shopModelIndex;
    NSInteger commodModelIndex;
    for (XQQShopModel * shopModel in self.dataArr) {
        for (XQQCommodityModel * commModel in shopModel.commodityArr) {
            if (commModel == commodModel) {
                commModel.isSelected = isSel;
                shopModelIndex = [self.dataArr indexOfObject:shopModel];
                commodModelIndex = [shopModel.commodityArr indexOfObject:commModel];
                NSMutableArray * tempArr = self.selectedArr[shopModelIndex];
                if (isSel) {
                    //装入数组
                    if (![tempArr containsObject:commodModel]) {
                        [tempArr addObject:commodModel];
                        if (tempArr.count == shopModel.commodityArr.count) {
                            shopModel.isAllSelected = YES;
                        }else{
                            shopModel.isAllSelected = NO;
                        }
                    }
                }else{
                    if ([tempArr containsObject:commodModel]) {
                        [tempArr removeObject:commodModel];
                        shopModel.isAllSelected = NO;
                    }
                }
            }
        }
    }
    [self updateData];
}

/** 减号按钮点击 */
- (void)minusBtnDidPress:(XQQCommodityModel *)commodModel cell:(XQQShopTableViewCell *)Cell{
    [self disposeShopData:commodModel cell:Cell isAdd:NO];
}
/** 加号按钮点击 */
- (void)addBtnDidPress:(XQQCommodityModel *)commodModel cell:(XQQShopTableViewCell *)Cell{
    [self disposeShopData:commodModel cell:Cell isAdd:YES];
}

/**处理数据*/
- (void)disposeShopData:(XQQCommodityModel*)commModel cell:(XQQShopTableViewCell*)Cell isAdd:(BOOL)isAdd{

    NSInteger shopModelIndex;
    NSInteger commodModelIndex;
    for (XQQShopModel * shopModel in self.dataArr) {
        for (XQQCommodityModel * comm in shopModel.commodityArr) {
            if (comm == commModel) {
                shopModelIndex = [self.dataArr indexOfObject:shopModel];
                commodModelIndex = [shopModel.commodityArr indexOfObject:commModel];
                NSMutableArray * tempArr = self.selectedArr[shopModelIndex];
                //是选中的那个
                NSInteger count = comm.commCount;
                if (isAdd) {
                    if (count == 99) {
                        return;
                    }
                    count ++ ;
                }else{
                    if (count == 1) {
                        return;
                    }
                    count -- ;
                }
                comm.commCount = count;
                //更新选中数组中的个数
                if ([tempArr containsObject:comm]) {
                    NSInteger index = [tempArr indexOfObject:comm];
                    XQQCommodityModel * model = tempArr[index];
                    model.commCount = count;
                }
            }
        }
    }
    [self updateData];
}

/** cell被点击了 */
- (void)shopCellDidPress:(XQQShopModel *)commodModel cell:(XQQShopTableViewCell *)Cell{
    NSLog(@"点击了cell,进入商品详情");
}

#pragma mark - UITabelViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    XQQShopModel * shopModel = self.dataArr[section];
    return shopModel.commodityArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    XQQShopModel * shopModel = self.dataArr[section];
    XQQShopHeaderView * view = [[XQQShopHeaderView alloc]initWithFrame:CGRectMake(0, 0, iphoneWidth, 50)];
    view.shopModel = self.dataArr[section];
    view.index = section;
    view.delegate = self;
    
    return shopModel.commodityArr.count > 0 ? view : nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XQQShopTableViewCell * cell = [XQQShopTableViewCell cellForTableView:tableView indexPath:indexPath];
    cell.dataModel = [self.dataArr[indexPath.section] commodityArr][indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    XQQShopModel * shopModel = self.dataArr[section];
    
    return shopModel.commodityArr.count > 0 ? 50.0 : 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"确认要删除这个商品吗?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alertAct = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //删除数据源
            XQQShopModel * shopModel = self.dataArr[indexPath.section];
            XQQCommodityModel * commodModel = shopModel.commodityArr[indexPath.row];
            NSMutableArray * tempArr = shopModel.commodityArr.mutableCopy;
            [tempArr removeObject:commodModel];
            shopModel.commodityArr = tempArr;
            //删除选中的数组
            if (commodModel.isSelected) {
                NSMutableArray * selectedArr = self.selectedArr[indexPath.section];
                if ([selectedArr containsObject:commodModel]) {
                    [selectedArr removeObject:commodModel];
                }
            }
            //删除UI
//            [self updatePrice];//更新下方总价格
            [self updateData];
//            [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        }];
        UIAlertAction * cacelAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:alertAct];
        [alert addAction:cacelAct];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
//- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UITableViewRowAction * action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        
//    }];
//    action1.backgroundColor = [UIColor redColor];
//    
//    UITableViewRowAction * action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        
//    }];
//    action2.backgroundColor = [UIColor grayColor];
//    return @[action1,action2];
//}

#pragma mark - setter&getter

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, iphoneWidth, iphoneHeight - 64 - 70) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

- (NSMutableArray *)selectedArr{
    if (!_selectedArr) {
        _selectedArr = @[].mutableCopy;
    }
    return _selectedArr;
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

@end
