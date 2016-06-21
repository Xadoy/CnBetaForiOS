//
//  CommentsTableViewController.m
//  MyCNbeta
//
//  Created by Adoy on 6/16/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "CommentsModel.h"
#import "CommentsTableViewCell.h"
#import "MJRefresh.h"
#define FONTSIZE 17.0
@interface CommentsTableViewController ()
{
    NSMutableArray      *_commentsArr;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputVIewBottomDistance;
@end

@implementation CommentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.textField.delegate = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];
    [self.tableView.mj_header beginRefreshing];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveKeyBoardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

    
//    [self setupInputView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewDidLayoutSubviews{

}
- (IBAction)didClickPublishComment:(UIButton *)sender {
    [CommentsModel stringForPublishComment:_textField.text withArticleID:_articleID];
    [self errorWithMessage:@"评论功能正在开发中，因api无法使用，（而且我抓包技能未加点，其实点赞功能api也用不了,嘘...）"];
}

-(void)didGetJson:(NSNotification*)noti{
    
    NSArray *arr = noti.object;
    
    
    if(arr.count>0){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            _commentsArr = [CommentsModel getCommentModelsWithArray:arr];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                [self.tableView.mj_header endRefreshing];
            });
        });
    }
    else{
        NSLog(@"No comments");
        [self errorWithMessage:@"目前尚未有评论"];
        [self.tableView.mj_header endRefreshing];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"hotCommentGetSuccess" object:nil];
    
}
-(void)refreshTableView{
    [CommentsModel getCommentListWithID:self.articleID Receiver:self selector:@selector(didGetJson:)];
    NSLog(@"refreshing");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _commentsArr.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    if (row == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTitle" forIndexPath:indexPath];
        return cell;
    }
    else{
        row--;
        CommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentContent" forIndexPath:indexPath];
        CommentsModel *aModel = _commentsArr[row];
        cell.contentLabel.text = aModel.content;
        cell.timeLabel.text = aModel.date;
        cell.tid=aModel.tid;
        cell.tid=aModel.articleID;
        cell.votingDelegate = self;
        cell.supportCountsLabel.text = aModel.supportCounts;
        cell.supportCountsLabel.highlightedTextColor = [UIColor redColor];
        cell.againstCountsLabel.text = aModel.againstCounts;
        cell.againstCountsLabel.highlightedTextColor = [UIColor redColor];
        cell.supportCountsLabel.highlighted = cell.likeButton.selected;
        cell.againstCountsLabel.highlighted = cell.dislikeButton.selected;
        return cell;
    }
    // Configure the cell...
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row==0)
        return 50;
    
    // 該行要顯示的內容
    NSString *content = [[_commentsArr objectAtIndex:indexPath.row-1]content];

    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

    CGRect phoneFrmae = [[UIScreen mainScreen]bounds];
    CGRect labelRect = [content boundingRectWithSize:CGSizeMake(phoneFrmae.size.width-54, CGFLOAT_MAX)
                                           options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONTSIZE],
                                                                        NSForegroundColorAttributeName:[UIColor blackColor]}
                                           context:nil];
    
    // 這裏返回需要的高度
    return labelRect.size.height+43+8+8+22;
}
-(void)errorWithMessage:(NSString*)msg{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *aa = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:aa];
    [self presentViewController:ac animated:YES completion:nil];
}
-(void)didFinishVoting:(NSNotification*)noti{
    NSDictionary *msg = noti.object;
    if([[msg objectForKey:@"status"]isEqualToString:@"success"]){
        NSLog(@"vote 成功");
    }
    else{
        NSLog([msg objectForKey:@"result"]);
    }
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"didReceiveVotingResponse" object:nil];
}

#pragma VotingDelegate

-(void)upVoteButtonDidClickFromCell:(CommentsTableViewCell*)cell{
//    if(sender.selected){
//        NSLog(@"Cancel Upvote:%@",tid);
//    }
//    else{
//        NSLog(@"Did Upvote:%@",tid);
//    }
//    sender.selected = !sender.selected;
    if (!cell.likeButton.selected)
    {
        cell.likeButton.selected = YES;
        cell.supportCountsLabel.highlighted = YES;
        
        
        int count = [cell.supportCountsLabel.text intValue];
        count++;
        cell.supportCountsLabel.text = [NSString stringWithFormat:@"%d",count];
        [CommentsModel commentWithID:cell.tid articleID:self.articleID like:YES Receiver:self selector:@selector(didFinishVoting:) notiName:@"didReceiveVotingResponse"];
    }
    else{
        [self errorWithMessage:@"你已经投过票了"];
    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_textField endEditing:YES];
}

-(void)downVodeButtonDidClickFromCell:(CommentsTableViewCell*)cell{
//    if(sender.selected){
//        NSLog(@"Cancel Downvote:%@",tid);
//    }
//    else{
//        NSLog(@"Did Downvote:%@",tid);
//    }
//    sender.selected = !sender.selected;
    if (!cell.dislikeButton.selected)
    {
        cell.dislikeButton.selected = YES;
        cell.againstCountsLabel.highlighted = YES;
        int count = [cell.againstCountsLabel.text intValue];
        count++;
        cell.againstCountsLabel.text = [NSString stringWithFormat:@"%d",count];
        [CommentsModel commentWithID:cell.tid articleID:self.articleID like:NO Receiver:self selector:@selector(didFinishVoting:) notiName:@"didReceiveVotingResponse"];
    }
    else{
        [self errorWithMessage:@"你已经投过票了"];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    
    NSLog(@"voting finish");
    [super viewWillDisappear:animated];
}
-(void)receiveKeyBoardFrameWillChange:(NSNotification*)noti{
    
    NSDictionary    *dict = noti.userInfo;
    int curve = [[dict objectForKey:UIKeyboardAnimationCurveUserInfoKey]intValue];
    float time = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    NSValue *number = [dict objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [number CGRectValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:time];
    [UIView setAnimationCurve:curve];
    _inputView.frame = CGRectMake(0, rect.origin.y-50, _inputView.frame.size.width, 50);
//    _tableView.frame = CGRectMake(0, 64, _tableView.frame.size.width, _inputView.frame.origin.y-64);
    [UIView commitAnimations];
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
