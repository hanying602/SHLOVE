//
//  ViewController.m
//  MyFirstIOSApp
//
//  Created by Hilary Lin on 2019/4/18.
//  Copyright © 2019 Hilary Lin. All rights reserved.
//

#import "ViewController.h"
#import "Course.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<Course *> *courses;

@end

@implementation ViewController

NSString *cellId = @"Courses";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchCoursesUsingJSON];
    self.navigationItem.title = @"Courses";
    [self.tableView registerClass: UITableViewCell.class forCellReuseIdentifier:cellId];
}

- (void)fetchCoursesUsingJSON {
    NSLog(@"Fetching Courses");
    NSString *urlString = @"https://api.letsbuildthatapp.com/jsondecodable/courses";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Finshed fetching courses.....");
        
        NSString *dummyString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"dummyString: %@", dummyString);
        
        NSError *err;
        NSArray *coursesJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err){
            NSLog(@"Failed to serialize into JSON : %@", err);
            return;
        }
        
        NSMutableArray<Course *> *courses = NSMutableArray.new;
        
        for (NSDictionary *courseDict in coursesJSON) {
            NSString *name = courseDict[@"name"];
            NSNumber *numberOfLessons = courseDict[@"number_of_lessons"];
            Course *course = Course.new;
            course.name = name;
            course.numberOfLessons = numberOfLessons;
            [courses addObject:course];
        }
        
        self.courses = courses;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });

    }] resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    Course *course = self.courses[indexPath.row];
    cell.textLabel.text = course.name;
    cell.detailTextLabel.text = course.numberOfLessons.stringValue;
    return cell;
}


@end
