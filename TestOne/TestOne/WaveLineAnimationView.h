//
//  WaveLineAnimationView.h
//  Test
//
//  Created by Qiang Lee on 2019/8/25.
//  Copyright © 2019 JMFT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaveLineAnimationView : UIView

@property (nonatomic, assign) CGFloat waveAmplitude; // 里面一条波纹振幅
@property (nonatomic, assign) CGFloat waveAmplitudeSecond; // 中间一条波纹振幅
@property (nonatomic, assign) CGFloat waveAmplitudeThird; // 外面一条纹振幅

@property (nonatomic, assign) CGFloat waveCycle; // 里面一条波纹周期
@property (nonatomic, assign) CGFloat waveCycleSecond; // 中间一条波纹周期
@property (nonatomic, assign) CGFloat waveCycleThird; // 外面一条波纹周期

@property (nonatomic, strong) UIColor *waveColor; // 里面一条颜色
@property (nonatomic, strong) UIColor *waveColorSecond; // 中间波浪颜色
@property (nonatomic, strong) UIColor *waveColorThird; // 外面一条波浪颜色

@property (nonatomic, assign) CGFloat waveSpeed;      // 波纹速度

@end

NS_ASSUME_NONNULL_END
