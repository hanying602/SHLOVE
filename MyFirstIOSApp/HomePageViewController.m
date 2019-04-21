//
//  HomePageViewController.m
//  MyFirstIOSApp
//
//  Created by Hilary Lin on 2019/4/21.
//  Copyright © 2019 Hilary Lin. All rights reserved.
//

#import "HomePageViewController.h"
#import "LoginController.h"

@interface HomePageViewController ()

@property (strong, nonatomic) UIImageView *heartImageView;
@property (strong, nonatomic) UIImageView *oliverImageView;
@property (strong, nonatomic) UIImageView *hilaryImageView;
@property (strong, nonatomic) UIView *hilaryContainerView;
@property (strong, nonatomic) UIView *oliverContainerView;
@property (strong, nonatomic) UILabel *daysNumberTextView;
@property (strong, nonatomic) UILabel *daysTextView;

@end

@implementation HomePageViewController {
    bool isLonginControllerPresented;
    double profileImageSize;
    double marginTop;
    UIColor *backgroundColor;
    UIColor *textColor;
    UIColor *buttonColor;
}

- (UIImageView*)oliverImageView {
    if (!_oliverImageView) {
        _oliverImageView = [[UIImageView alloc] initWithFrame: _oliverContainerView.bounds];
        _oliverImageView.image = [UIImage imageNamed:@"profile_picture_oliver"];
        [_oliverImageView.layer setCornerRadius: profileImageSize/2];
        [_oliverImageView.layer setBorderColor:[[UIColor colorWithRed:78.0/255.0 green:82.0/255.0 blue:85.0/255.0 alpha:1] CGColor] ];
        [_oliverImageView.layer setMasksToBounds:YES];
    }
    return _oliverImageView;
}

- (UIImageView*)hilaryImageView {
    if (!_hilaryImageView) {
        _hilaryImageView = [[UIImageView alloc] initWithFrame: _hilaryContainerView.bounds];
        _hilaryImageView.image = [UIImage imageNamed:@"profile_picture_hilary"];
        [_hilaryImageView.layer setCornerRadius: profileImageSize/2];
        [_hilaryImageView.layer setBorderColor:[[UIColor colorWithRed:78.0/255.0 green:82.0/255.0 blue:85.0/255.0 alpha:1] CGColor] ];
        [_hilaryImageView.layer setMasksToBounds:YES];
    }
    return _hilaryImageView;
}

- (UIImageView*)heartImageView {
    if (!_heartImageView) {
        _heartImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 40, 40)];
        _heartImageView.image = [UIImage imageNamed:@"heart"];
    }
    return _heartImageView;
}

- (UIView*)hilaryContainerView {
    if (!_hilaryContainerView) {
        _hilaryContainerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, profileImageSize, profileImageSize)];
        _hilaryContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
        [_hilaryContainerView.layer setShadowRadius:4.0f];
        [_hilaryContainerView.layer setShadowOffset:CGSizeMake(2, 2)];
        [_hilaryContainerView.layer setShadowOpacity:0.5f];
    }
    return _hilaryContainerView;
}

- (UIView*)oliverContainerView {
    if (!_oliverContainerView) {
        _oliverContainerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, profileImageSize, profileImageSize)];
        _oliverContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
        [_oliverContainerView.layer setShadowRadius:4.0f];
        [_oliverContainerView.layer setShadowOffset:CGSizeMake(2, 2)];
        [_oliverContainerView.layer setShadowOpacity:0.5f];
    }
    return _oliverContainerView;
}

- (UILabel*)daysNumberTextView {
    if (!_daysNumberTextView) {
        _daysNumberTextView = UILabel.new;
        _daysNumberTextView.text = @"100";
        _daysNumberTextView.translatesAutoresizingMaskIntoConstraints = false;
        _daysNumberTextView.textAlignment = NSTextAlignmentCenter;
        _daysNumberTextView.backgroundColor = UIColor.clearColor;
        _daysNumberTextView.font = [UIFont boldSystemFontOfSize: 72];
        _daysNumberTextView.textColor = buttonColor;
    }
    return _daysNumberTextView;
}

- (UILabel*)daysTextView {
    if (!_daysTextView) {
        _daysTextView = UILabel.new;
        _daysTextView.text = @"DAYS";
        _daysTextView.translatesAutoresizingMaskIntoConstraints = false;
        _daysTextView.textAlignment = NSTextAlignmentCenter;
        _daysTextView.backgroundColor = UIColor.clearColor;
        _daysTextView.font = [UIFont boldSystemFontOfSize: 18];
        _daysTextView.textColor = textColor;
    }
    return _daysTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    backgroundColor = [UIColor colorWithRed:0.84 green:0.81 blue:0.78 alpha:1.0];;
    textColor = [UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1.0];
    buttonColor = [UIColor colorWithRed:0.46 green:0.20 blue:0.25 alpha:1.0];
    
    profileImageSize = 80;
    marginTop = 150;
    
    self.view.backgroundColor = backgroundColor;
    
    UINavigationBar *bar = [self.navigationController navigationBar];
    bar.barTintColor = buttonColor;
    bar.translucent = NO;
    
    [self.view addSubview: self.heartImageView];
    [self.view addSubview: self.hilaryContainerView];
    [self.view addSubview: self.oliverContainerView];
    [self.view addSubview: self.daysNumberTextView];
    [self.view addSubview: self.daysTextView];

    [self.hilaryContainerView addSubview: self.hilaryImageView];
    [self.oliverContainerView addSubview: self.oliverImageView];
    
    self.hilaryContainerView.center = CGPointMake(self.view.frame.size.width - 100, marginTop);
    self.oliverContainerView.center = CGPointMake(100, marginTop);
    self.heartImageView.center = CGPointMake(self.view.frame.size.width/2, marginTop);
    
    [self setUpDaysNumberTextView];
    [self setUpDaysTextView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    if (!isLonginControllerPresented) {
        [self presentLoginController];
    }
    isLonginControllerPresented = YES;
}

- (void)setUpDaysNumberTextView {
    [self.daysNumberTextView.topAnchor constraintEqualToAnchor: self.heartImageView.bottomAnchor constant: 60].active = true;
    [self.daysNumberTextView.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor].active = true;
    [self.daysNumberTextView.widthAnchor constraintEqualToAnchor: self.view.widthAnchor constant: -100].active = true;
    [self.daysNumberTextView.heightAnchor constraintEqualToConstant: 80].active = true;
}

- (void)setUpDaysTextView {
    [self.daysTextView.topAnchor constraintEqualToAnchor: self.daysNumberTextView.bottomAnchor].active = true;
    [self.daysTextView.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor].active = true;
    [self.daysTextView.widthAnchor constraintEqualToAnchor: self.view.widthAnchor constant: -100].active = true;
    [self.daysTextView.heightAnchor constraintLessThanOrEqualToConstant: 50].active = true;
    self.daysNumberTextView.text = self.countDays;
}

- (NSString*)countDays {
    NSString *beginDateString = @"2018-10-02";
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat: @"yyyy-MM-dd"];
    NSDate *beginDate = [df dateFromString: beginDateString];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components: NSCalendarUnitDay fromDate: beginDate toDate: [NSDate date] options: 0];
    return [NSString stringWithFormat: @"%ld", [components day]];
}

- (void)presentLoginController {
    LoginController *loginController = LoginController.new;
    [self presentViewController:loginController animated:true completion:nil];
    //    [self.navigationController pushViewController: loginController animated:true];
}

@end
