//
//  ThirdViewController.m
//  MyCNbeta
//
//  Created by Adoy on 6/15/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "ThirdViewController.h"
#import "NewsModel.h"
#import "ThirdTableViewCell.h"
#import "MJRefresh.h"
@interface ThirdViewController ()

{
     NSMutableArray      *_newsArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];
    [_tableView.mj_header beginRefreshing];


}
-(void)didGetHtml:(NSNotification*)noti{
    NSDictionary *dic = noti.object;
    NSDictionary *temp = [dic objectForKey:@"result"];
    
    NSString *hometext = [temp objectForKey:@"hometext"];
    NSString *bodytext = [temp objectForKey:@"bodytext"];
    NSString *final = [hometext stringByAppendingString:bodytext];
    //    NSString *final = noti.object;
    
    
    [self performSegueWithIdentifier:@"thirdCellSelected" sender:final];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"htmlGetSuccess" object:nil];
    
}
-(void)didGetJson:(NSNotification*)noti{
    NSMutableDictionary *dic = noti.object;
    NSArray *arr = [dic objectForKey:@"result"];
    //    NSLog(@"%d",arr.count);
    _newsArr = [NewsModel getNewsModelsWithArray:arr];
    [_tableView reloadData];
    
    [_tableView.mj_header endRefreshing];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"topTenJsonGetSuccess" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navigationBarTopTenLogo"]];
    img.frame = CGRectMake(0, 0, 122,38);
    self.navigationController.topViewController.navigationItem.titleView = img;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsArr.count;//temp for test
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell3" forIndexPath:indexPath];
    
    NSUInteger row = [indexPath row];
    NewsModel *temp = _newsArr[row];
    NSString *title = [NSString stringWithFormat:@"%d. %@",row+1,temp.title];
    cell.titleLabel.text =title;
    
    cell.thumbImg.image = temp.thumbImg;
    cell.summaryLabel.text = temp.summary;
    cell.timeLabel.text = temp.pubTime;
    
    
    // set cells' selection style
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:73/255.0
                                                      green:101/255.0
                                                       blue:225/255.0
                                                      alpha:1];
    cell.selectedBackgroundView =  customColorView;
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    NewsModel *aModel = _newsArr[row];
    [NewsModel getArticleWithID:aModel.articleID Receiver:self selector:@selector(didGetHtml:)];
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)refreshTableView{
    [NewsModel getTopTenNewsListWithReceiver:self selector:@selector(didGetJson:)];
    NSLog(@"refreshing");
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *temp = segue.destinationViewController;
    
    [temp setValue:sender forKey:@"htmlString"];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
