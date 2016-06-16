//
//  FirstViewController.m
//  MyCNbeta
//
//  Created by Adoy on 6/6/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "FirstViewController.h"
#import "NewsModel.h"
#import "ThirdTableViewCell.h"
#import "MJRefresh.h"
@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray      *_newsArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSLog(@"%@",[NewsModel stringForNewsList]);

    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];
    [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreNews)];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)didGetHtml:(NSNotification*)noti{
    NSDictionary *dic = noti.object;
    NSDictionary *temp = [dic objectForKey:@"result"];
    
    NSString *hometext = [temp objectForKey:@"hometext"];
    NSString *bodytext = [temp objectForKey:@"bodytext"];
    NSString *final = [hometext stringByAppendingString:bodytext];
    //    NSString *final = noti.object;
    
    
    [self performSegueWithIdentifier:@"cellSelected" sender:final];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"htmlGetSuccess" object:nil];
    
}
-(void)didGetJson:(NSNotification*)noti{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *dic = noti.object;
        NSArray *arr = [dic objectForKey:@"result"];
        //    NSLog(@"%d",arr.count);
        _newsArr = [NewsModel getNewsModelsWithArray:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            [_tableView.mj_header endRefreshing];
        });
        
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"jsonGetSuccess" object:nil];
    });

}
-(void)didGetMoreNews:(NSNotification*)noti{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *dic = noti.object;
        NSArray *arr = [dic objectForKey:@"result"];
        NSArray *modelArr = [NewsModel getNewsModelsWithArray:arr];
    
        for(NewsModel *aNewsModel in modelArr){
            [_newsArr addObject:aNewsModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        
            [_tableView.mj_footer endRefreshing];
        });
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"moreNewsGetSuccess" object:nil];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsArr.count;//temp for test
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];

    NSUInteger row = [indexPath row];
    NewsModel *temp = _newsArr[row];
    cell.titleLabel.text =temp.title;
    
    cell.thumbImg.image = temp.thumbImg;
    cell.summaryLabel.text = temp.summary;
    cell.timeLabel.text = temp.pubTime;
    
    
    
    
    //view counts and comments
    cell.viewCountsLabel.text = (temp.viewCounts.length<5)?temp.viewCounts:@"9999+";
    cell.commentCountsLabel.text = (temp.commentCounts.length<5)?temp.commentCounts:@"9999+";
//    CGRect timeLabelRect = cell.timeLabel.frame;
//    UIImageView *imgView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"eye_24"]];
//    imgView2.frame = CGRectMake(timeLabelRect.origin.x+250, timeLabelRect.origin.y+5, 15, 10);
//    [cell addSubview:imgView2];
    
    
    
    
    // set cells' selection style
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:73/255.0
                                                      green:101/255.0
                                                       blue:225/255.0
                                                      alpha:1];
    cell.selectedBackgroundView =  customColorView;
    
    
    return cell;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navigationBarLogo"]];
    img.frame = CGRectMake(0, 0, 122,38);
    self.navigationController.topViewController.navigationItem.titleView = img;
}

-(void)refreshTableView{
    [NewsModel getNewsListWithReceiver:self selector:@selector(didGetJson:)];
    NSLog(@"refreshing");
}
-(void)getMoreNews{
    NewsModel *lastNews = [_newsArr lastObject];
    
    [NewsModel getArticleAfterID:lastNews.articleID Receiver:self selector:@selector(didGetMoreNews:)];
    NSLog(@"loading");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    NewsModel *aModel = _newsArr[row];
    [NewsModel getArticleWithID:aModel.articleID Receiver:self selector:@selector(didGetHtml:)];
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *temp = segue.destinationViewController;
    
    [temp setValue:sender forKey:@"htmlString"];
    
}

#pragma mark ===========================for override================================
-(void)viewWillAppearForOverRide:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
