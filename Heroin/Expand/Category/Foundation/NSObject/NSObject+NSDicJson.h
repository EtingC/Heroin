//
//  NSObject+NSDicJson.h
//  Heroin
//
//  Created by Benson on 2018/9/20.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSDicJson)

//通过对象返回一个NSDictionary，键是属性名称，值是属性值。
+ (NSDictionary*)getObjectData:(id)obj;

//将getObjectData方法返回的NSDictionary转化成JSON
+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;

//直接通过NSLog输出getObjectData方法返回的NSDictionary
+ (void)print:(id)obj;

//获取属性名称数组
- (NSDictionary *)classPropsFor:(Class)klass;

@end
