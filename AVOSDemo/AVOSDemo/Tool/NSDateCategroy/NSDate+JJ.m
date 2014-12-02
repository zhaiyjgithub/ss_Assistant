//
//  NSDate+JJ.m
//  易商
//
//  Created by 伍松和 on 14/10/24.
//  Copyright (c) 2014年 Ruifeng. All rights reserved.
//

#import "NSDate+JJ.h"

@implementation NSDate (JJ)
#pragma mark -关于日期

+(NSDate *)dateString:(NSString *)dateString
               Format:(NSString*)format{
    
    
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:dateString];
    
}

+(NSDate *)dateString:(NSString *)dateString
{
    return  [NSDate dateString:dateString Format:@"yyyy-MM-dd"];
}

#pragma mark -传一个NSDate跟日期格式得到正确日期字符串

+(NSString*)getRealDateTime:(NSDate *)date
                 withFormat:(NSString*)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    
    NSString *confromTimespStr = [formatter stringFromDate:date];
    
    return  confromTimespStr;
}
#pragma mark -传一个时间戳跟日期格式得到正确日期字符串

+(NSString*)getRealTime:(NSString *)timestamp
             withFormat:(NSString*)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    
    timestamp=[timestamp substringToIndex:10];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestamp floatValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return  confromTimespStr;
}
#pragma mark -根据一个Date得到一个时间戳(10位的,看需求)
+(NSString*)getTimeStampWithDate:(NSDate*)date{
    
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)[date timeIntervalSince1970]];
    return timeSp;
}
#pragma mark -根据一个Date得到一个时间戳(13位的,看需求)
+(NSString*)getTimeStampWith13Date:(NSDate*)date{
    
    
    NSTimeInterval time = ([date timeIntervalSince1970]); // returned as a double
    long digits = (long)time; // this is the first 10 digits
    int decimalDigits = (int)(fmod(time, 1) * 1000); // this will get the 3 missing digits
    NSString *timeStamp_13=[NSMutableString stringWithFormat:@"%ld%d",digits,decimalDigits];

    return timeStamp_13;
}
//生日那些
+(NSString*)getRealTime:(NSString *)timestamp{
    
    
    return  [self getRealTime:timestamp withFormat:@"yyyy-MM-dd"];
    
    
}
+(NSString*)getDayRealTime:(NSString *)timestamp{
    
    
    return  [self getRealTime:timestamp withFormat:@"HH:mm"];
    
}
+(NSString *) compareCurrentTime:(NSDate*) compareDate

//

{   NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    int temp = 0;
    
    NSString *result;
    
    if (timeInterval < 60) {
        
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    
    else if((temp = timeInterval/60) <60){
        
        //1个小时内
        result=[NSString stringWithFormat:@"%d分钟前",temp];
        
    }
    
    
    
    else if((temp = temp/60) <24){
        
        //一天内?
        result=[NSString stringWithFormat:@"%d小时前",temp];
        
    }
    
    
    
    else if((temp = temp/24) <30){
        
        result = [NSDate getRealDateTime:compareDate withFormat:@"MM-dd"];
        //显示日期
        
    }
    
    
    
    else if((temp = temp/30) <12){
        
        result = [NSDate getRealDateTime:compareDate withFormat:@"MM-dd"];
        
    }
    
    else{
        
        temp = temp/12;
        
        result = [NSDate getRealDateTime:compareDate withFormat:@"yyyy-MM-dd"];
        
    }
    
    
    
    return  result;
    
}

#pragma mark - 计算星座
+(NSString *)getAstroWithMonth:(int)m day:(int)d{
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    
    NSString *astroFormat = @"102123444543";
    
    NSString *result;
    
    if (m<1||m>12||d<1||d>31){
        
        return @"错误日期格式!";
        
    }
    
    if(m==2 && d>29)
        
    {
        
        return @"错误日期格式!!";
        
    }else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            
            return @"错误日期格式!!!";
            
        }
        
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    return result;
    
}
#pragma mark -未读
+(NSDate*)getDateWithTime:(NSTimeInterval)time{
    
    NSDate *confromDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    // NSString *confromTimespStr = [formatter stringFromDate:confromDate];
    
    return confromDate;
    
}
@end
