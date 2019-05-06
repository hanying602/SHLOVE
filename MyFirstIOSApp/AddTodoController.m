//
//  AddTodoController.m
//  MyFirstIOSApp
//
//  Created by Hilary Lin on 2019/5/6.
//  Copyright © 2019 Hilary Lin. All rights reserved.
//

#import "AddTodoController.h"
#import "Todo.h"
@import Firebase;

@interface AddTodoController ()
    @property (strong, nonatomic) FIRDatabaseReference *ref;
    @property (strong, nonatomic) FIRDatabaseReference *todoRef;
    @property (strong, nonatomic) UITextField *titleTextField;
@end

@implementation AddTodoController {
    UIColor *backgroundColor;
    UIColor *textColor;
    UIColor *buttonColor;
    UIActivityIndicatorView *loadingProgressDialog;
}

- (UITextField*)titleTextField {
    if (!_titleTextField) {
        _titleTextField = UITextField.new;
        _titleTextField.placeholder = @"Event";
        _titleTextField.translatesAutoresizingMaskIntoConstraints = false;
        _titleTextField.backgroundColor = [UIColor whiteColor];
//        _titleTextField.textColor = textColor;
//        [_titleTextField setTintColor: buttonColor];
    }
    return _titleTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    backgroundColor = [UIColor colorWithRed:0.84 green:0.81 blue:0.78 alpha:1.0];
    textColor = [UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1.0];
    buttonColor = [UIColor colorWithRed:0.46 green:0.20 blue:0.25 alpha:1.0];
    self.view.backgroundColor = backgroundColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle: @"Done" style: UIBarButtonItemStylePlain target: self action: @selector(handleNewTodoEvent)];
    
    self.ref = [[FIRDatabase database] reference];
    self.todoRef = [_ref child:@"todos"];
    
    [self.view addSubview: self.titleTextField];
    [self setUpNameTextField];
    [self setUpLoadingProgressDialog];
}

- (void)setUpNameTextField {
    [self.titleTextField.leftAnchor constraintEqualToAnchor: self.view.leftAnchor constant: 12].active = true;
    [self.titleTextField.topAnchor constraintEqualToAnchor: self.view.topAnchor constant: 12].active = true;
    [self.titleTextField.widthAnchor constraintEqualToConstant:200].active = true;
    [self.titleTextField.heightAnchor constraintEqualToConstant:50].active = true;
    [self.titleTextField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void)setUpLoadingProgressDialog {
    loadingProgressDialog = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingProgressDialog.frame = CGRectMake(0.0, 0.0, 60.0, 60.0);
    loadingProgressDialog.center = self.view.center;
    [self.view addSubview:loadingProgressDialog];
    [loadingProgressDialog bringSubviewToFront:self.view];
}

- (void)handleNewTodoEvent {
    [loadingProgressDialog startAnimating];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.leftBarButtonItem.enabled = NO;
    
    Todo *todo = [[Todo alloc] init];
    todo.todoId = @([[NSDate date] timeIntervalSince1970]*1000000).stringValue;
    todo.title = self.titleTextField.text;
    todo.isDone = [NSNumber numberWithBool: NO];

    [[_todoRef child: todo.todoId]
     setValue:@{@"title": todo.title,
                @"isDone": todo.isDone
                } withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
                    [self->loadingProgressDialog stopAnimating];
                    [self.navigationController popViewControllerAnimated: YES];
                }];
}

-(void)textFieldDone:(UITextField*)textField
{
    [textField resignFirstResponder];
}


@end
