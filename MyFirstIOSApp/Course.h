//
//  Course.h
//  MyFirstIOSApp
//
//  Created by Hilary Lin on 2019/4/20.
//  Copyright © 2019 Hilary Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Course : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *numberOfLessons;

@end

NS_ASSUME_NONNULL_END
