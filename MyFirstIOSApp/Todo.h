//
//  Todo.h
//  MyFirstIOSApp
//
//  Created by Hilary Lin on 2019/5/6.
//  Copyright © 2019 Hilary Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Todo : NSObject

@property (strong, nonatomic) NSString *todoId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *isDone;

@end

NS_ASSUME_NONNULL_END
