//
//  ViewController.m
//  JSONDemo
//
//  Created by 蘋果 on 2016/3/17.
//  Copyright © 2016年 蘋果. All rights reserved.
//

#import "ViewController.h"
#define CellIdentifier_customCell @"customCell"

@interface ViewController ()
{
    NSMutableArray *myObject;
    // A dictionary object
    NSDictionary *dictionary;
    
    // Define keys
    NSString *SiteName;
    NSString *UVI;
    NSString *PublishAgency;
    NSString *County;
    NSString *WGS84Lon;
    NSString *WGS84Lat;
    NSString *PublishTime;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SiteName = @"SiteName";
    UVI = @"UVI";
    PublishAgency = @"PublishAgency";
    County = @"County";
    WGS84Lon = @"WGS84Lon";
    WGS84Lat = @"WGS84Lat";
    PublishTime = @"PublishTime";
    
    myObject = [[NSMutableArray alloc] init];
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:@"http://opendata.epa.gov.tw/ws/Data/UV/?$orderby=PublishAgency&$skip=0&$top=1000&format=json"]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *SiteName_data = [dataDict objectForKey:@"SiteName"];
        NSString *UVI_data = [dataDict objectForKey:@"UVI"];
        NSString *PublishAgency_data = [dataDict objectForKey:@"PublishAgency"];
        NSString *County_data = [dataDict objectForKey:@"County"];
        NSString *WGS84Lon_data = [dataDict objectForKey:@"WGS84Lon"];
        NSString *WGS84Lat_data = [dataDict objectForKey:@"WGS84Lat"];
        NSString *PublishTime_data = [dataDict objectForKey:@"PublishTime"];
        
        NSLog(@"SiteName: %@",SiteName_data);
        NSLog(@"UVI: %@",UVI_data);
        NSLog(@"PublishAgency: %@",PublishAgency_data);
        NSLog(@"County: %@",County_data);
        NSLog(@"WGS84Lon: %@",WGS84Lon_data);
        NSLog(@"WGS84Lat: %@",WGS84Lat_data);
        NSLog(@"PublishTime: %@",PublishTime_data);
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      SiteName_data, SiteName,
                      UVI_data, UVI,
                      PublishAgency_data,PublishAgency,
                      County_data,County,
                      WGS84Lon_data,WGS84Lon,
                      WGS84Lat_data,WGS84Lat,
                      PublishTime_data,PublishTime,
                      nil];
        [myObject addObject:dictionary];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return myObject.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_customCell];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier_customCell];
    }
    
    
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    NSMutableString *siteName;
    //text = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:title]];
    siteName = [NSMutableString stringWithFormat:@"測站名稱 : %@ ",
            [tmpDict objectForKeyedSubscript:SiteName]];
    
    NSMutableString *uvi;
    uvi = [NSMutableString stringWithFormat:@"紫外線指數 : %@ ",
              [tmpDict objectForKey:UVI]];
    
    NSMutableString *publishagency;
    publishagency = [NSMutableString stringWithFormat:@"發布機關 : %@ ",
              [tmpDict objectForKey:PublishAgency]];
    
    NSMutableString *county;
    county = [NSMutableString stringWithFormat:@"縣市 : %@ ",
              [tmpDict objectForKey:County]];
    
    NSMutableString *lon;
    lon = [NSMutableString stringWithFormat:@"經度 : %@ ",
              [tmpDict objectForKey:WGS84Lon]];
    
    NSMutableString *lat;
    lat = [NSMutableString stringWithFormat:@"緯度 : %@ ",
              [tmpDict objectForKey:WGS84Lat]];
    NSMutableString *time;
    time = [NSMutableString stringWithFormat:@"發布時間 : %@ ",
              [tmpDict objectForKey:PublishTime]];
    
    UILabel *siteNameLabel = (UILabel *)[cell viewWithTag:100];
    UILabel *uviLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *publishagencyLabel = (UILabel *)[cell viewWithTag:102];
    UILabel *countyLabel = (UILabel *)[cell viewWithTag:103];
    UILabel *lonLabel = (UILabel *)[cell viewWithTag:104];
    UILabel *latLabel = (UILabel *)[cell viewWithTag:105];
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:106];
    
    siteNameLabel.text = siteName;
    uviLabel.text = uvi;
    publishagencyLabel.text = publishagency;
    countyLabel.text = county;
    lonLabel.text = lon;
    latLabel.text = lat;
    timeLabel.text = time;
    
    return cell;
}

@end
