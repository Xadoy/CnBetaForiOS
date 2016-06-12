//
//  SecondTableViewController.m
//  MyCNbeta
//
//  Created by Adoy on 6/12/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "SecondTableViewController.h"
#import "HotCommentTableViewCell.h"
#import "HotCommentModel.h"
#import "MJRefresh.h"
#define FONTSIZE 17.0
@interface SecondTableViewController ()
{
    NSMutableArray      *_hotCommentsArr;
}
@end

@implementation SecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height);
    _hotCommentsArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshCommentList)];
    [self.tableView.mj_header beginRefreshing];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navigationBarCommentLogo"]];
    img.frame = CGRectMake(0, 0, 122,38);
    self.navigationController.topViewController.navigationItem.titleView = img;
}

-(void)didGetCommentList:(NSNotification*)noti{
    NSMutableDictionary *dic = noti.object;
    NSArray *arr = [dic objectForKey:@"result"];
    _hotCommentsArr = [HotCommentModel getCommentModelsWithArray:arr];
    [self.tableView reloadData];
    
    [self.tableView.mj_header endRefreshing];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"hotCommentGetSuccess" object:nil];
}

-(void)refreshCommentList{
    [HotCommentModel getHotCommentWithReceiver:self selector:@selector(didGetCommentList:)];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _hotCommentsArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseC1" forIndexPath:indexPath];
    
    NSUInteger row = [indexPath row];
    HotCommentModel *aModel = _hotCommentsArr[row];
    cell.myLabel.text = aModel.content;
    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 列寬
    CGFloat contentWidth = self.tableView.frame.size.width;
    // 用何種字體進行顯示
    UIFont *font = [UIFont systemFontOfSize:FONTSIZE];
    
    // 該行要顯示的內容
    NSString *content = [[_hotCommentsArr objectAtIndex:indexPath.row]content];
    // 計算出顯示完內容需要的最小尺寸
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
    
    // 這裏返回需要的高度
    return size.height; 
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
