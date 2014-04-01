//
//  RootViewController.m
//  TroyStory5
//
//  Created by Claire Jencks on 4/1/14.
//  Copyright (c) 2014 Claire Jencks. All rights reserved.
//

#import "RootViewController.h"
#import "RootViewController.h"
#import "Trojans.h"



@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *prowessTextField;

@property (strong, nonatomic) IBOutlet UITableView *trojansTableView;


@property NSArray* trojans;


@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //same as: [NSArray arrayWithObjects: @1, @2, @3, nil];
    //self.trojans = @[@"Bob: the Trojan", @"Cynthia: warrior queen"];

}
- (IBAction)onTrojanConquest:(id)sender
{
    //create new core data object
    Trojans* trojan = [NSEntityDescription insertNewObjectForEntityForName:@"Trojans" inManagedObjectContext:self.managedObjectContext];
    trojan.name = self.nameTextField.text;
    trojan.prowess = [NSNumber numberWithInt:self.prowessTextField.text.intValue];
    [self.managedObjectContext save:nil];
    [self load];
    [self.prowessTextField resignFirstResponder];
}

-(void)load;
{
    NSFetchRequest* request = [[NSFetchRequest alloc]initWithEntityName:@"Trojans"];
    NSSortDescriptor* sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSSortDescriptor* sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"prowess" ascending:YES];
    NSArray* sortDescriptorsArray = [NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil];
    request.sortDescriptors = sortDescriptorsArray;
    NSArray* trojans = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    if (trojans.count){
        self.trojans = trojans;
    }
    
    [self.trojansTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return self.trojans.count; //same as [[self trojans] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    Trojans *trojan = self.trojans[indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellReuseID"];
    cell.textLabel.text = trojan.name;
    cell.detailTextLabel.text = trojan.prowess.description;
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
