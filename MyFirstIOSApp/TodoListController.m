//
//  TodoListController.m
//  MyFirstIOSApp
//
//  Created by Hilary Lin on 2019/5/5.
//  Copyright © 2019 Hilary Lin. All rights reserved.
//

#import "TodoListController.h"
#import "AddTodoController.h"
#import "Todo.h"
@import Firebase;

@interface TodoListController ()
    @property (strong, nonatomic) FIRDatabaseReference *ref;
    @property (strong, nonatomic) FIRDatabaseReference *todoRef;
@end

@implementation TodoListController {
    NSMutableArray<Todo *> *nonFinishedRow;
    NSMutableArray<Todo *> *finishedRow;
    NSMutableArray<NSMutableArray<Todo *> *> *twoDimensionData;
    UIActivityIndicatorView *loadingProgressDialog;
    int progressCount;
}

NSString *eventsCellId = @"events";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Todo";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle: @"Add" style: UIBarButtonItemStylePlain target: self action: @selector(handleAddEvent)];
    [self initailData];
}

- (void)initailData {
    nonFinishedRow = [[NSMutableArray<Todo *> alloc] init];
    finishedRow = [[NSMutableArray<Todo *> alloc] init];
    twoDimensionData = [[NSMutableArray<NSMutableArray<Todo *> *> alloc] initWithObjects: nonFinishedRow, finishedRow, nil];
    
    self.ref = [[FIRDatabase database] reference];
    self.todoRef = [_ref child:@"todos"];
    
    [self setUpLoadingProgressDialog];
    [self showProgressDialog];
    FIRDatabaseQuery *todosByNonfinished = [[_todoRef queryOrderedByChild:@"isDone"] queryEqualToValue: [NSNumber numberWithBool: NO]];
    [todosByNonfinished observeEventType: FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        [self addSnapshotDataToTodoArray: snapshot toArray: self->nonFinishedRow];
    }];
    
    FIRDatabaseQuery *todosByFinished = [[_todoRef queryOrderedByChild:@"isDone"] queryEqualToValue: [NSNumber numberWithBool: YES]];
    [todosByFinished observeEventType: FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        [self addSnapshotDataToTodoArray: snapshot toArray: self->finishedRow];
    }];

}

- (void)addSnapshotDataToTodoArray :(FIRDataSnapshot*) firebaseSnapshot toArray:(NSMutableArray*) targetArray{
    NSEnumerator *children = [firebaseSnapshot children];
    FIRDataSnapshot *child;
    [targetArray removeAllObjects];
    while (child = [children nextObject]) {
        NSDictionary *todoDict = [[NSDictionary alloc] init];
        todoDict = child.value;
        Todo *todo = [[Todo alloc] init];
        todo.todoId = child.key;
        todo.title = todoDict[@"title"];
        todo.isDone = todoDict[@"isDone"];
        [targetArray addObject: todo];
    }
    progressCount++;
    if (progressCount == 2){
        [self dismissProgressDialog];
    }
}

- (void)setUpLoadingProgressDialog {
    loadingProgressDialog = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingProgressDialog.frame = CGRectMake(0.0, 0.0, 60.0, 60.0);
    loadingProgressDialog.center = self.view.center;
    [self.view addSubview:loadingProgressDialog];
    [loadingProgressDialog bringSubviewToFront:self.view];
}

- (void)showProgressDialog {
    progressCount = 0;
    [loadingProgressDialog startAnimating];
    [self.view setUserInteractionEnabled: NO];
}

- (void)dismissProgressDialog {
    [loadingProgressDialog stopAnimating];
    [self.tableView reloadData];
    [self.view setUserInteractionEnabled: YES];
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
    Todo *todo =twoDimensionData[indexPath.section][indexPath.row];
    cell.textLabel.text = todo.title;
    return cell;
}

@end
