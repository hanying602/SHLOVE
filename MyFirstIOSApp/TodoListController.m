//
//  TodoListController.m
//  MyFirstIOSApp
//
//  Created by Hilary Lin on 2019/5/5.
//  Copyright © 2019 Hilary Lin. All rights reserved.
//

#import "TodoListController.h"
#import "AddTodoController.h"
@import Firebase;

@interface TodoListController ()
    @property (strong, nonatomic) FIRDatabaseReference *ref;
    @property (strong, nonatomic) FIRDatabaseReference *todoRef;
@end

@implementation TodoListController {
    NSMutableArray *nonFinishedRow;
    NSMutableArray *finishedRow;
    NSMutableArray *twoDimensionData;
}

NSString *eventsCellId = @"events";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Todo";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle: @"新增" style: UIBarButtonItemStylePlain target: self action: @selector(handleAddEvent)];
    [self initailData];
}

- (void)initailData {
    nonFinishedRow = [NSMutableArray array];
    finishedRow = [NSMutableArray array];
    twoDimensionData = [[NSMutableArray alloc] initWithObjects: nonFinishedRow, finishedRow, nil];
    
    self.ref = [[FIRDatabase database] reference];
    self.todoRef = [_ref child:@"todos"];

    FIRDatabaseQuery *todosByNonfinished = [[_todoRef queryOrderedByChild:@"isDone"] queryEqualToValue: @NO];
    [todosByNonfinished observeEventType: FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        NSEnumerator *children = [snapshot children];
        FIRDataSnapshot *child;
        while (child = [children nextObject]) {
            [self->nonFinishedRow addObject: child.value[ @"title"]];
        }
        [self.tableView reloadData];
    }];
    
    FIRDatabaseQuery *todosByFinished = [[_todoRef queryOrderedByChild:@"isDone"] queryEqualToValue: @YES];
    [todosByFinished observeEventType: FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        NSEnumerator *children = [snapshot children];
        FIRDataSnapshot *child;
        while (child = [children nextObject]) {
            [self->finishedRow addObject: child.value[ @"title"]];
        }
        [self.tableView reloadData];
    }];

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    label.text = section==0 ? @"待完成" :@"已完成";
    label.backgroundColor = [UIColor grayColor];
    return label;
}

- (void)handleAddEvent {
    AddTodoController *addTodoController = AddTodoController.new;
    [self.navigationController pushViewController: addTodoController animated: true];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return twoDimensionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [twoDimensionData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: eventsCellId];
    cell.textLabel.text = twoDimensionData[indexPath.section][indexPath.row];
    return cell;
}

@end
