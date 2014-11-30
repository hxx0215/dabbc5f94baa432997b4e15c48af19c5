//
//  HNImageData.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-17.
//
//

#import "HNImageData.h"

@interface HNImageData()
@property (nonatomic, strong)NSMutableDictionary *imageDict;
@end


@implementation HNImageData
+ (instancetype)shared {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(id)init
{
    self = [super init];
    self.imageDict = [[NSMutableDictionary alloc]init];
    return self;
}

-(void)clearCatch
{
    [self.imageDict removeAllObjects];
}

-(UIImage *)imageWithLink:(NSString *)link
{
    UIImage *image = [self.imageDict objectForKey:link];
    if (image) {
        return image;
    }
    else
    {
        NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[link addPort]]];
        image = [[UIImage alloc]initWithData:data];
        //image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[link addPort]]]];
        image = image? image : [UIImage imageNamed:@"selectphoto.png"];
        if (link) {
            [self.imageDict setObject:image forKey:link];
        }
        return image;
    }
}
@end


