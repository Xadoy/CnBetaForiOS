//
//  FourthViewTableViewController.m
//  MyCNbeta
//
//  Created by Adoy on 6/16/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "FourthViewTableViewController.h"
#import "ProgressHUD.h"
@interface FourthViewTableViewController ()
{

    NSArray         *_allSelectorArrs;
}
@end

@implementation FourthViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *selectorArr0 = @[@"caching",@"emptyMethod",@"emptyMethod",@"deleteCachedImg"];
    NSArray *selectorArr1 = @[@"emptyMethod",@"emptyMethod",@"emptyMethod"];
    _allSelectorArrs = @[selectorArr0,selectorArr1];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"设置";
    title.textColor = [UIColor whiteColor];
    title.textAlignment=NSTextAlignmentCenter;
    title.frame = CGRectMake(0, 0, 122,38);
    self.navigationController.topViewController.navigationItem.titleView = title;
    
    _cacheSizeLabel.text = [NSString stringWithFormat:@"%.1f MB",[[SDImageCache sharedImageCache]getSize]/1024.0];
    NSLog(@"image counts:%lu",(unsigned long)[[SDImageCache sharedImageCache]getDiskCount]);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%d,%d",indexPath.section,indexPath.row);
    SEL tempSelector = NSSelectorFromString(_allSelectorArrs[indexPath.section][indexPath.row]);
    
    [self performSelector:tempSelector withObject:nil];
    
}


#pragma mark -methods for section 0
-(void)caching{
    
}
-(void)deleteCachedImg{
    [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
        [ProgressHUD showSuccess:@"清除完成"];
        _cacheSizeLabel.text = [NSString stringWithFormat:@"%.1f MB",[[SDImageCache sharedImageCache]getSize]/1024.0];
    }];
    
}
-(void)emptyMethod{
    
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
