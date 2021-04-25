#import <Foundation/Foundation.h>

#import <NSXPCConnection.h>

//#import "CLSimulationManager.h"

#import "LocationHeaders/CLSimulationManager.h"

#import <CoreLocation/CoreLocation.h>

//#import <xpc/xpc.h>
#import <Foundation/Foundation.h>



void runXPC(){
    NSXPCConnection *con = [[NSXPCConnection alloc] initWithServiceName:@"com.apple.locationd.simulation"];
    if (!con) {
        NSLog(@"con is null!!");
        return;
    }
    [con resume];
}

void changePosition(){
    
    double x = 70,y = 70;
    NSLog(@"请输入经度:");
    scanf("%lf",&x);
    NSLog(@"请输入维度:");
    scanf("%lf",&y);
    
    
    CLSimulationManager *clmanager = [[CLSimulationManager alloc] init];
    [clmanager clearSimulatedLocations ];

    CLLocation *location = [[CLLocation alloc] initWithLatitude:x longitude:y]; //DTSimulation进程中使用的方式，只模拟了经纬度
    
    CLLocationCoordinate2D location_2d = CLLocationCoordinate2DMake(x, y);
    
    //CLLocation *location = [[CLLocation alloc] initWithCoordinate:location_2d altitude:70.21 horizontalAccuracy:12 verticalAccuracy:12 timestamp:[[NSDate alloc] init]];
    
    //CLLocation *location = [[CLLocation alloc] initWithCoordinate:location_2d altitude:66.666 horizontalAccuracy:12 verticalAccuracy:21 course:70 speed:66 timestamp:[[NSDate alloc] init]];
    
    
    [clmanager appendSimulatedLocation: location];

    NSLog(@"start simulation!");
    
    [clmanager startLocationSimulation];
    
    NSLog(@"end simulation!");
}

void originPosition(){
    CLSimulationManager *clmanager = [[CLSimulationManager alloc] init];
    [clmanager clearSimulatedLocations];
    [clmanager stopLocationSimulation];
    
}

int main (int argc, const char * argv[])
{

    @autoreleasepool
    {
        int chice = 0;
        NSLog(@"0:修改位置，其他:还原位置");
        scanf("%d",&chice);
        
        if (chice == 0) {
            changePosition();
        }else{
            originPosition();
        }
        
    	// insert code here...
    	NSLog(@"Hello, World!");	
    }
	return 0;
}

