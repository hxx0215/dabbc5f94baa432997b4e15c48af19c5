//
//  HNPaySupport.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-30.
//
//

#import "HNPaySupport.h"
#import "JSONKit.h"
#import "NSString+Crypt.h"
#import "HNLoginData.h"

@interface HNPaySupport()<NSXMLParserDelegate,NSURLConnectionDataDelegate>
@property (nonatomic, strong)NSString *bank_type;
@property (nonatomic, strong)NSString *bargainor_id;
@property (nonatomic, strong)NSString *callback_url;
@property (nonatomic, strong)NSString *charset;
@property (nonatomic, strong)NSString *desc;
@property (nonatomic, strong)NSString *notify_url;
@property (nonatomic, strong)NSString *sp_billno;
@property (nonatomic, strong)NSString *total_fee;
@property (nonatomic, strong)NSString *ver;
@property (nonatomic, strong)NSString *mysign;
@property (nonatomic, strong)NSString *privateKey;
@property (nonatomic, strong)NSString *fee_type;
@property(nonatomic) BOOL finished;
@property(nonatomic,strong) NSString *token;
@end
@implementation HNPaySupport

+ (instancetype)shared {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)updataDic:(NSDictionary *)dic;
{
    [self setValue:[dic objectForKey:@"bank_type"] forKey:@"bank_type"];
    [self setValue:[dic objectForKey:@"bargainor_id"] forKey:@"bargainor_id"];
    [self setValue:[dic objectForKey:@"callback_url"] forKey:@"callback_url"];
    [self setValue:[dic objectForKey:@"charset"] forKey:@"charset"];
    [self setValue:[dic objectForKey:@"desc"] forKey:@"desc"];
    [self setValue:[dic objectForKey:@"notify_url"] forKey:@"notify_url"];
    [self setValue:[dic objectForKey:@"sp_billno"] forKey:@"sp_billno"];
    [self setValue:[dic objectForKey:@"total_fee"] forKey:@"total_fee"];
    
    [self setValue:[dic objectForKey:@"ver"] forKey:@"ver"];
    [self setValue:[dic objectForKey:@"mysign"] forKey:@"mysign"];
    [self setValue:[dic objectForKey:@"privateKey"] forKey:@"privateKey"];
    
}
-(NSString *)getToken
{
    NSString * ONLINE_PAY_KEY = @"key";
    NSString * ONLINE_PAY_INIT = @"https://www.tenpay.com/app/mpay/wappay_init.cgi";
    NSString * ONLINE_PAY = @"https://www.tenpay.com/app/mpay/mp_gate.cgi";
    NSString * ADDRESS_CONNECTOR = @"?";
    NSString * PARAM_CONNECTOR = @"&";
    NSString * VALUES_CONNECTOR = @"=";
    NSString * ONLINE_PAY_SIGN = @"sign";
    NSString * ONLINE_PAY_TOKEN = @"token_id";
    
    NSString *str = nil;
    
    
    NSString *m_Ver = [NSString stringWithFormat:@"%@=%@",@"ver",self.ver];
    NSString *m_CharSet = [NSString stringWithFormat:@"%@=%@",@"charset",self.charset];
    NSString *m_Bank_Type = [NSString stringWithFormat:@"%@=%@",@"bank_type",self.bank_type];
    NSString *m_Desc = [NSString stringWithFormat:@"%@=%@",@"desc",self.desc];
    NSString *m_Bargainor = [NSString stringWithFormat:@"%@=%@",@"bargainor_id",self.bargainor_id];
    NSString *m_Billno = [NSString stringWithFormat:@"%@=%@",@"sp_billno",self.sp_billno];
    NSString *m_Total = [NSString stringWithFormat:@"%@=%ld",@"total_fee",self.total_fee.integerValue];
    NSString *m_FeeType = [NSString stringWithFormat:@"%@=%@",@"fee_type",@"1"];
    NSString *m_Notify = [NSString stringWithFormat:@"%@=%@",@"notify_url",self.notify_url];
    NSString *m_Callback = [NSString stringWithFormat:@"%@=%@",@"callback_url",self.callback_url];
    
    NSArray *keys = [NSArray arrayWithObjects:m_Ver,m_CharSet,m_Bank_Type,m_Desc,m_Bargainor,m_Billno,m_Total,m_FeeType,m_Notify,m_Callback, nil];
    
    NSComparator cmptr = ^(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        switch(result)
        {
            case NSOrderedAscending:
                return NSOrderedAscending;
            case NSOrderedDescending:
                return NSOrderedDescending;
            case NSOrderedSame:
                return NSOrderedSame;
            default:
                return NSOrderedSame;
        }
    };
    NSArray *sortArray = [keys sortedArrayUsingComparator:cmptr];
    NSString *desString = nil;
    for (int i=0; i<sortArray.count; i++) {
        NSString *sstring = [sortArray objectAtIndex:i];
        if (desString) {
            desString = [NSString stringWithFormat:@"%@%@%@",desString,sstring,PARAM_CONNECTOR];
        }
        else
            desString = [NSString stringWithFormat:@"%@%@",sstring,PARAM_CONNECTOR];
    }
    
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@",desString,ONLINE_PAY_KEY,VALUES_CONNECTOR,self.privateKey];
    sign = [[sign stringFromMD5] uppercaseString];
    
    
    NSString *param = [NSString stringWithFormat:@"%@%@%@%@",desString,ONLINE_PAY_SIGN,VALUES_CONNECTOR,sign];
    str = [NSString stringWithFormat:@"%@%@%@",ONLINE_PAY_INIT,ADDRESS_CONNECTOR,param];
    
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:received];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser setDelegate:self];
    [parser parse];
    
    //ONLINE_PAY + ADDRESS_CONNECTOR +ONLINE_PAY_TOKEN + VALUES_CONNECTOR +token;
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@",ONLINE_PAY,ADDRESS_CONNECTOR,ONLINE_PAY_TOKEN,VALUES_CONNECTOR,self.token];
    return url;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (string.length>1) {
        self.token = string;
        NSLog(@"Value:%@",string);
    }
    
}

-(void)doLoadingPay:(NSString *)url
{

    
    if ([self.delegate respondsToSelector:@selector(didGetPayUrl:)])
    {
        [self.delegate didGetPayUrl:url];
    }
}
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}
-(void) getPayToken:(NSString *)declareId cid:(NSString*)connid payType:(HNPayType)type
{
    NSMutableDictionary *sendDic = [[NSMutableDictionary alloc] init];
    [sendDic setObject:[HNLoginData shared].mshopid forKey:@"mshopid"];
    [sendDic setObject:declareId forKey:@"declareid"];
    [sendDic setObject:connid forKey:@"connid"];
//    [sendDic setObject:[NSNumber numberWithInteger:(type)] forKey:@"type"];
    [sendDic setObject:[NSString stringWithFormat:@"%d",type] forKey:@"type"];
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.pay.info" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        if (data)
        {
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (!retStr){
                [self showBadServer];
                return ;
            }
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSLog(@"%@",retJson);
            NSDictionary* dic = [retJson objectFromJSONString];
            NSInteger count = [[dic objectForKey:@"total"] integerValue];
            if (0!=count)
            {
                NSArray *dataArr = [dic objectForKey:@"data"];
                NSDictionary *dicData = [dataArr objectAtIndex:0];
                [self updataDic:dicData];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"服务器没有数据" delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                [alert show];
            }
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
        NSString* url = [self getToken];
        [self performSelectorOnMainThread:@selector(doLoadingPay:) withObject:url waitUntilDone:YES];
    }];

}
@end
