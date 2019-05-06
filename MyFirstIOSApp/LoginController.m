//
//  LoginController.m
//  MyFirstIOSApp
//
//  Created by Hilary Lin on 2019/4/20.
//  Copyright © 2019 Hilary Lin. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()
    
@property (strong, nonatomic) UIView *inputsContainerView;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UIView *nameSeperatorView;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIImageView *logoImageView;

@end

@implementation LoginController {
    UIColor *backgroundColor;
    UIColor *textColor;
    UIColor *buttonColor;
}

- (UIImageView*)logoImageView {
    if (!_logoImageView) {
        _logoImageView = UIImageView.new;
        _logoImageView.image = [UIImage imageNamed:@"relationship"];
        _logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _logoImageView;
}

- (UIView*)inputsContainerView {
    if (!_inputsContainerView) {
        _inputsContainerView = UIView.new;
        _inputsContainerView.backgroundColor = UIColor.whiteColor ;
        _inputsContainerView.translatesAutoresizingMaskIntoConstraints = false;
        _inputsContainerView.layer.cornerRadius = 5;
        _inputsContainerView.layer.masksToBounds = NO;
        _inputsContainerView.layer.shadowOffset = CGSizeMake(2,2);
        _inputsContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
        _inputsContainerView.layer.shadowOpacity = 0.3;
    }
    return _inputsContainerView;
}

- (UIButton*)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType: UIButtonTypeSystem];
        _loginButton.backgroundColor = buttonColor;
        _loginButton.translatesAutoresizingMaskIntoConstraints = false;
        _loginButton.layer.cornerRadius = 5;
        [_loginButton setTitle: @"Login" forState: UIControlStateNormal];
        [_loginButton setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
        [_loginButton.titleLabel setFont: [UIFont boldSystemFontOfSize: 18]];
    }
    return _loginButton;
}

- (UITextField*)nameTextField {
    if (!_nameTextField) {
        _nameTextField = UITextField.new;
        _nameTextField.placeholder = @"Name";
        _nameTextField.translatesAutoresizingMaskIntoConstraints = false;        
        _nameTextField.textColor = textColor;
        [_nameTextField setTintColor: buttonColor];
    }
    return _nameTextField;
}

- (UIView*)nameSeperatorView {
    if (!_nameSeperatorView) {
        _nameSeperatorView = UIView.new;
        _nameSeperatorView.backgroundColor = [UIColor colorWithDisplayP3Red:0.88 green:0.88 blue:0.88 alpha:1.0];
        _nameSeperatorView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _nameSeperatorView;
}

- (UITextField*)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = UITextField.new;
        _passwordTextField.placeholder = @"Password";
        _passwordTextField.translatesAutoresizingMaskIntoConstraints = false;
        _passwordTextField.textColor = textColor;
        _passwordTextField.secureTextEntry = YES;
        [_passwordTextField setTintColor: buttonColor];
    }
    return _passwordTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    backgroundColor = [UIColor colorWithRed:0.84 green:0.81 blue:0.78 alpha:1.0];
    textColor = [UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1.0];
    buttonColor = [UIColor colorWithRed:0.46 green:0.20 blue:0.25 alpha:1.0];
    
    self.view.backgroundColor = backgroundColor;
    
    [self.view addSubview: self.inputsContainerView];
    [self.view addSubview: self.loginButton];
    [self.view addSubview: self.logoImageView];
    
    [self setUpInputsContainerView];
    [self setUpLoginButton];
    [self setUpLogoImageView];
    
    [self.loginButton addTarget: self action: @selector(handleLogin) forControlEvents: UIControlEventTouchUpInside];

}

-(void)textFieldDone:(UITextField*)textField
{
    [textField resignFirstResponder];
}

- (void)setUpInputsContainerView {
    [self.inputsContainerView.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor].active = true;
    [self.inputsContainerView.centerYAnchor constraintEqualToAnchor: self.view.centerYAnchor constant:-20].active = true;
    [self.inputsContainerView.widthAnchor constraintEqualToAnchor: self.view.widthAnchor constant:-120].active = true;
    [self.inputsContainerView.heightAnchor constraintEqualToConstant:100].active = true;
    
    [self.inputsContainerView addSubview: self.nameTextField];
    [self.inputsContainerView addSubview: self.nameSeperatorView];
    [self.inputsContainerView addSubview: self.passwordTextField];
    
    [self.nameTextField.leftAnchor constraintEqualToAnchor: self.inputsContainerView.leftAnchor constant:12].active = true;
    [self.nameTextField.topAnchor constraintEqualToAnchor: self.inputsContainerView.topAnchor].active = true;
    [self.nameTextField.widthAnchor constraintEqualToAnchor: self.inputsContainerView.widthAnchor].active = true;
    [self.nameTextField.heightAnchor constraintEqualToAnchor: self.inputsContainerView.heightAnchor multiplier: 0.5].active = true;
    [self.nameTextField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.nameSeperatorView.leftAnchor constraintEqualToAnchor: self.inputsContainerView.leftAnchor].active = true;
    [self.nameSeperatorView.topAnchor constraintEqualToAnchor: self.nameTextField.bottomAnchor].active = true;
    [self.nameSeperatorView.widthAnchor constraintEqualToAnchor: self.inputsContainerView.widthAnchor].active = true;
    [self.nameSeperatorView.heightAnchor constraintEqualToConstant: 1].active = true;
    
    
    [self.passwordTextField.leftAnchor constraintEqualToAnchor: self.inputsContainerView.leftAnchor constant:12].active = true;
    [self.passwordTextField.topAnchor constraintEqualToAnchor: self.nameTextField.bottomAnchor].active = true;
    [self.passwordTextField.widthAnchor constraintEqualToAnchor: self.inputsContainerView.widthAnchor].active = true;
    [self.passwordTextField.heightAnchor constraintEqualToAnchor: self.inputsContainerView.heightAnchor multiplier: 0.5].active = true;
    [self.passwordTextField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void)setUpLogoImageView {
    [self.logoImageView.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor].active = true;
    [self.logoImageView.bottomAnchor constraintEqualToAnchor: self.inputsContainerView.topAnchor constant: -12].active = true;
    [self.logoImageView.widthAnchor constraintEqualToConstant: 60].active = true;
    [self.logoImageView.heightAnchor constraintEqualToConstant: 60].active = true;
}

- (void)setUpLoginButton {
    [self.loginButton.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor].active = true;
    [self.loginButton.topAnchor constraintEqualToAnchor: self.inputsContainerView.bottomAnchor constant:12].active = true;
    [self.loginButton.widthAnchor constraintEqualToAnchor: self.inputsContainerView.widthAnchor].active = true;
    [self.loginButton.heightAnchor constraintEqualToConstant: 40].active = true;
}

- (void)handleLogin {
//    [self.view endEditing:YES];
//    if ([_nameTextField.text isEqualToString:@"OliverSu"] && [_passwordTextField.text isEqualToString:@"0114"]){
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSString *currentLevelKey = @"isLoggedIn";
    
    [preferences setBool:YES forKey:currentLevelKey];
    //  Save to disk
    const BOOL didSave = [preferences synchronize];
    if (didSave){
        [self dismissViewControllerAnimated:true completion:nil];
    }
//    } else {
//        [self showUIAlertView];
//    }
}

- (void)showUIAlertView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登入失敗" message:@"帳號或密碼錯誤" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:true completion:nil];
}

@end
