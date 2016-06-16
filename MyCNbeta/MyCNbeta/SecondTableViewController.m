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
#import "FirstWebViewController.h"
#define FONTSIZE 18
#define TITLEFONTSIZE 12
#define LABELWIDTH 304
#define GAPHEIGHT 10
@interface SecondTableViewController ()
{
    NSMutableArray      *_hotCommentsArr;
//    CGFloat             _labelWidth;
    NSDictionary        *_attributes;
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
    _attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:FONTSIZE],
                    NSForegroundColorAttributeName:[UIColor colorWithRed:40.0/225.0 green:102.0/225.0 blue:1.0 alpha:1]};
    
                    
                    
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *dic = noti.object;
        NSArray *arr = [dic objectForKey:@"result"];
        _hotCommentsArr = [HotCommentModel getCommentModelsWithArray:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            [self.tableView.mj_header endRefreshing];
        });
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"hotCommentGetSuccess" object:nil];
    });
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
//    NSAttributedString *atrString = [[NSAttributedString alloc]initWithString:aModel.content attributes:_attributes];
    cell.myLabel.font = [UIFont systemFontOfSize:FONTSIZE];
    cell.myLabel.text = aModel.content;
    UIView *view = [[UIView alloc]initWithFrame:cell.frame];
    view.backgroundColor = [UIColor colorWithRed:73.0/225.0 green:101.0/225.0 blue:1.0 alpha:1];
    cell.selectedBackgroundView = view;
    NSString *title = [NSString stringWithFormat:@" ————— 对《%@》的评论",aModel.subject];
    cell.titleLabel.text = title;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 列寬
//    CGFloat contentWidth = self.tableView.frame.size.width;
    
    
    // 該行要顯示的內容
    NSString *content = [[_hotCommentsArr objectAtIndex:indexPath.row]content];
    NSString *tempTitle   = [[_hotCommentsArr objectAtIndex:indexPath.row]subject];
    NSString *title = [NSString stringWithFormat:@" ————— 对《%@》的评论",tempTitle];
//    HotCommentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //cell.frame.size.width
    NSAttributedString *atrString = [[NSAttributedString alloc]initWithString:content attributes:_attributes];
    // 計算出顯示完內容需要的最小尺寸
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
//    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
    CGRect phoneFrmae = [[UIScreen mainScreen]bounds];
    CGRect labelRect = [atrString boundingRectWithSize:CGSizeMake(phoneFrmae.size.width-16, CGFLOAT_MAX) options:options context:nil];
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(phoneFrmae.size.width-16, CGFLOAT_MAX)
                                           options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TITLEFONTSIZE],
                                                             NSForegroundColorAttributeName:[UIColor blackColor]}
                                           context:nil];
    
    // 這裏返回需要的高度
    return labelRect.size.height+16+GAPHEIGHT+titleRect.size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    HotCommentModel *aModel = _hotCommentsArr[row];
    [HotCommentModel getArticleWithID:aModel.articleID Receiver:self selector:@selector(didGetHotCommentHtml:)];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)didGetHotCommentHtml:(NSNotification*)noti{
    NSDictionary *dic = noti.object;
    NSDictionary *temp = [dic objectForKey:@"result"];
    
    NSString *hometext = [temp objectForKey:@"hometext"];
    NSString *bodytext = [temp objectForKey:@"bodytext"];
    NSString *final = [hometext stringByAppendingString:bodytext];
    //    NSString *final = noti.object;
    
    
    [self performSegueWithIdentifier:@"hotCommentCellSelected" sender:final];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HotCommenthtmlGetSuccess" object:nil];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *temp = segue.destinationViewController;
    
    [temp setValue:sender forKey:@"htmlString"];
    
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
