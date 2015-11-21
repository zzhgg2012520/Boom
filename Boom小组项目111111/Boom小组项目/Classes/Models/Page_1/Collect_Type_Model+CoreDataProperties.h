//
//  Collect_Type_Model+CoreDataProperties.h
//  Boom小组项目
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 仲勃翰. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Collect_Type_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Collect_Type_Model (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *subTitle;
@property (nullable, nonatomic, retain) NSString *img;
@property (nullable, nonatomic, retain) NSString *subId;

@end

NS_ASSUME_NONNULL_END
