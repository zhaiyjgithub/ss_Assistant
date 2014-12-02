
#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface SS_BaseModel : NSObject

@property (nonatomic,copy)NSString * objectId;
@property (nonatomic,copy)NSString * createdAt;
@property (nonatomic,copy)NSString * updatedAt;

-(instancetype)initWithDictionary:(NSDictionary*)dic;
@end
