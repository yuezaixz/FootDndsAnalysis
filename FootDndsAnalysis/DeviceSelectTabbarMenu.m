//
//  TabbarMenu.m
//  FootDndsAnalysis
//
//  Created by 吴迪玮 on 15/12/9.
//  Copyright © 2015年 Paodong. All rights reserved.
//

#import "DeviceSelectTabbarMenu.h"

#define TOPSPACE 64.0

static NSString *FootBleDevTableViewCellIdentifier = @"FootBleDevTableViewCellIdentifier";

@interface DeviceSelectTabbarMenu()

@property (strong,nonatomic) UIView *normalRect;
@property (strong,nonatomic) UIView *springRect;
@property (nonatomic) CGFloat tabbarheight;
@property (nonatomic) CGRect terminalFrame;
@property (nonatomic) CGRect initialFrame;
@property (strong,nonatomic) UIWindow *keyWindow;
@property (strong,nonatomic) UIVisualEffectView *blurView;
@property (nonatomic) BOOL opened;
@property (strong,nonatomic) CADisplayLink *displayLink;
@property (nonatomic) NSInteger animationCount;
@property (strong,nonatomic) UIButton *animateButton;
@property (strong,nonatomic) UITableView *deviceView;

@end

@implementation DeviceSelectTabbarMenu

-(instancetype)initWithTabbarHeight:(CGFloat)tabbarHeight{
    _tabbarheight = tabbarHeight;
    _terminalFrame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    _initialFrame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - _tabbarheight-TOPSPACE, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    self = [super initWithFrame:_initialFrame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    self.keyWindow = [[UIApplication sharedApplication] keyWindow];
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    self.blurView.frame = self.bounds;
    self.blurView.alpha = 0.0;
    [self.keyWindow addSubview:self.blurView];
    
    
    self.backgroundColor = [UIColor clearColor];
    [self.keyWindow addSubview:self];
    
    self.normalRect = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)-30-50,30,30)];
    self.normalRect.backgroundColor = [UIColor blueColor];
    self.normalRect.hidden = YES;
    [self.keyWindow addSubview:self.normalRect];
    
    self.springRect = [[UIView alloc] initWithFrame:CGRectMake( CGRectGetWidth([UIScreen mainScreen].bounds)/2 - 30/2,self.normalRect.frame.origin.y,30,30)];
    self.springRect.backgroundColor = [UIColor yellowColor];
    self.springRect.hidden = YES;
    [self.keyWindow addSubview:self.springRect];
    
    [BleService sharedInstance].delegate = self;
    self.deviceView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOPSPACE+self.tabbarheight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) -  TOPSPACE - self.tabbarheight)];
    self.deviceView.backgroundColor = [UIColor clearColor];
    self.deviceView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.deviceView.delegate = self;
    self.deviceView.dataSource = self;
    [self.deviceView registerNib:[UINib nibWithNibName:@"FootBleDevTableViewCell" bundle:nil]
               forCellReuseIdentifier:FootBleDevTableViewCellIdentifier];
    self.deviceView.tableFooterView = [[UIView alloc] init];
    [self addSubview:self.deviceView];
    
    _animateButton = [[UIButton alloc] initWithFrame:CGRectMake(5, TOPSPACE + (self.tabbarheight - 30)/2, 50, 30)];
    [_animateButton setTitle:@"蓝牙" forState:UIControlStateNormal];
    [_animateButton addTarget:self action:@selector(triggerAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_animateButton];
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), TOPSPACE)];
    [path addQuadCurveToPoint:CGPointMake(0, TOPSPACE) controlPoint:CGPointMake(CGRectGetWidth(self.frame)/2, TOPSPACE-self.diff)];
    [path closePath];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [[UIColor colorWithRed:50/255.0 green:58/255.0 blue:68/255.0 alpha:1.0] setFill];
    CGContextFillPath(context);
}

- (void)triggerAction{
    if (!self.opened) {
        self.opened = YES;
        [self startAnimation];
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
            self.springRect.center = CGPointMake(self.springRect.center.x, self.springRect.center.y - 40);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
                self.frame = self.terminalFrame;
            } completion:nil];
            [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^(){
                self.normalRect.center = CGPointMake(self.normalRect.center.x, 100);
                self.blurView.alpha = 1.0;
            } completion:nil];
            [UIView animateWithDuration:1.3 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^(){
                self.springRect.center = CGPointMake(self.springRect.center.x, 100);
            } completion:^(BOOL finished){
                [self stopAnimation];
            }];
        }];
    } else {
        self.opened = NO;
        [self startAnimation];
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
            self.frame = self.initialFrame;
        } completion:nil];
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
            self.normalRect.center = CGPointMake(self.normalRect.center.x, CGRectGetHeight([UIScreen mainScreen].bounds)-30-50);
            self.blurView.alpha = 0.0;
        } completion:nil];
        
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
            self.springRect.center = CGPointMake(self.springRect.center.x, CGRectGetHeight([UIScreen mainScreen].bounds)- 30 - 50 + 10);
        } completion:^(BOOL isFinish){
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
                self.springRect.center = CGPointMake(self.springRect.center.x, CGRectGetHeight([UIScreen mainScreen].bounds)- 30 - 50 -40);
            } completion:^(BOOL isFinish){
                [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
                    self.springRect.center = CGPointMake(self.springRect.center.x, CGRectGetHeight([UIScreen mainScreen].bounds)- 30 - 50);
                } completion:^(BOOL isFinish){
                    [self stopAnimation];
                }];
            }];
        }];
    }
}

- (void)update:(CADisplayLink *)displayLink{
    id normalRectLayer = self.normalRect.layer.presentationLayer;
    id springRectLayer = self.springRect.layer.presentationLayer;
    CGRect normalRectFrame = [[normalRectLayer valueForKey:@"frame"] CGRectValue];
    CGRect springRectFrame = [[springRectLayer valueForKey:@"frame"] CGRectValue];
    CGFloat tempDiff = normalRectFrame.origin.y - springRectFrame.origin.y;
    tempDiff = tempDiff >= 0 ? tempDiff : tempDiff/3;//减小幅度
    self.diff = tempDiff;
    [self setNeedsDisplay];
}

- (void)startAnimation{
    if (!self.displayLink) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    self.animationCount++;
}

- (void)stopAnimation{
    self.animationCount--;
    if (!self.animationCount) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

-(void)setOpened:(BOOL)opened{
    if (opened) {
        self.peripherals = [BleService sharedInstance].currentPeripherals;
        [[BleService sharedInstance] startSearch:3];
    } else {
        [[BleService sharedInstance] stop];
    }
    _opened = opened;
}

-(void)setPeripherals:(NSArray *)peripherals{
    _peripherals = peripherals;
    [self.deviceView reloadData];
}

#pragma mark - device
- (void)successScanPeripherals:(NSArray *)peripherals{
    self.peripherals = peripherals;
}
- (void)successConnectPeripheral:(FootPeripheal *)footPeripheral{
    [[BleService sharedInstance] stop];
    self.peripherals = nil;
    [self.deviceView reloadData];
    NSLog(@"成功连接");
}
- (void)successFindWriteCharct:(LGCharacteristic *)writeCharct{
    NSLog(@"成功找到写特征");
}
- (void)successFindReadCharct:(LGCharacteristic *)readCharct{
    NSLog(@"成功找到读特征");
}

#pragma mark - FootBleDevTableViewCellDelegate
- (void)connectPeripheral:(LGPeripheral *)peripheral{
    [[BleService sharedInstance] connectPeripheral:peripheral];
}


#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.peripherals count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FootBleDevTableViewCell *cell = [self.deviceView dequeueReusableCellWithIdentifier:FootBleDevTableViewCellIdentifier];
    [cell setPeripheral:[self.peripherals objectAtIndex:indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)table heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}










@end
