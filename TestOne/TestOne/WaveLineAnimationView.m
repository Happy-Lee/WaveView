//
//  WaveLineAnimationView.m
//  Test
//
//  Created by Qiang Lee on 2019/8/25.
//  Copyright © 2019 JMFT. All rights reserved.
//

#import "WaveLineAnimationView.h"

@interface WaveLineAnimationView ()
{
//    CGFloat waveSpeed;      // 波纹速度
//    CGFloat waterWaveHeight;
    CGFloat waterWaveWidth;

    CGFloat offsetX;           // 波浪x位移

    CGFloat currentWavePointY; // 当前波浪上市高度Y（高度从大到小 坐标系向下增长）
}
@property (nonatomic, strong) CAShapeLayer *firstLayer;
@property (nonatomic, strong) CAShapeLayer *secondLayer;
@property (nonatomic, strong) CAShapeLayer *thirdLayer;

@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation WaveLineAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self configData];
        [self setup];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self customLayer];
}

- (void)configData{
    _waveCycle = 1.0 * M_PI / self.bounds.size.width;
    _waveCycleSecond = 1.5 * M_PI / self.bounds.size.width;
    _waveCycleThird = 2.0 * M_PI / self.bounds.size.width;

    waterWaveWidth  = self.bounds.size.width;

    _waveSpeed = 0.1/M_PI;// 波速

    offsetX = 0;
    _waveAmplitude = 50; //
    _waveAmplitudeSecond = 50;
    _waveAmplitudeThird = 30;

    currentWavePointY = 0;
}


- (void)setup{
    self.firstLayer = [CAShapeLayer layer];
    self.firstLayer.fillColor = [UIColor colorWithRed:200.0/255.0 green:234.0/255.0 blue:1.0 alpha:0.8].CGColor;

    [self.layer addSublayer:self.firstLayer];

    self.secondLayer = [CAShapeLayer layer];
    self.secondLayer.fillColor =  [UIColor colorWithRed:126.0/255.0 green:202.0/255.0 blue:1.0 alpha:0.4].CGColor;
    [self.layer addSublayer:self.secondLayer];

    self.thirdLayer = [CAShapeLayer layer];
    self.thirdLayer.fillColor = [UIColor colorWithRed:50.0/255.0 green:164.0/255.0 blue:1.0 alpha:0.5].CGColor;
    [self.layer addSublayer:self.thirdLayer];
    [self startWave];
}

- (void)startWave{
    if (self.timer == nil) {
        self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveAnimation)];
        [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)waveAnimation{
    [self setNeedsDisplay];
}

- (void)customLayer{
    // 波浪位移
    offsetX += _waveSpeed;
    [self configFirst];
    [self configSecond];
    [self configThird];
}

- (void)configFirst{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 正弦波浪公式
        y = self.waveAmplitude * sin(self.waveCycle * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);

    _firstLayer.path = path;
    CGPathRelease(path);
}

- (void)configSecond{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 余弦波浪公式
        y = self.waveAmplitudeSecond * cos(self.waveCycleSecond * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);

    _secondLayer.path = path;
    CGPathRelease(path);
}


- (void)configThird{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 余弦波浪公式
        y = self.waveAmplitudeThird * cos(self.waveCycleThird * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);

    _thirdLayer.path = path;
    CGPathRelease(path);
}

#pragma mark - setter

- (void)setWaveColor:(UIColor *)waveColor{
    _waveColor = waveColor;
    self.firstLayer.fillColor = waveColor.CGColor;
}

- (void)setWaveColorSecond:(UIColor *)waveColorSecond{
    _waveColorSecond = waveColorSecond;
    self.secondLayer.fillColor = waveColorSecond.CGColor;
}

- (void)setWaveColorThird:(UIColor *)waveColorThird{
    _waveColorThird = waveColorThird;
    self.thirdLayer.fillColor = waveColorThird.CGColor;
}

- (void)setWaveCycle:(CGFloat)waveCycle{
    _waveCycle = waveCycle;
}

- (void)setWaveCycleSecond:(CGFloat)waveCycleSecond{
    _waveCycleSecond = waveCycleSecond;
}

- (void)setWaveCycleThird:(CGFloat)waveCycleThird{
    _waveCycleThird = waveCycleThird;
}

- (void)setWaveAmplitude:(CGFloat)waveAmplitude{
    _waveAmplitude = waveAmplitude;
}

- (void)setWaveAmplitudeSecond:(CGFloat)waveAmplitudeSecond{
    _waveAmplitudeSecond = waveAmplitudeSecond;
}

- (void)setWaveAmplitudeThird:(CGFloat)waveAmplitudeThird{
    _waveAmplitudeThird = waveAmplitudeThird;
}

- (void)setWaveSpeed:(CGFloat)waveSpeed{
    _waveSpeed = waveSpeed;
    offsetX += _waveSpeed;
}

#pragma mark - dealloc
- (void)dealloc{
    if (self.timer != nil) {
        self.timer.paused = true;
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
