//
//  QuickAnimationEaseManager.m
//  QuickAnimation
//
//  Copyright © 2017年 SpadeChen. All rights reserved.
//

#import "QuickAnimationEaseManager.h"
#import <math.h>

static const float _PiOver2 = M_PI_2;
static const float _TwoPi = M_PI * 2;
static const float defaultEaseOvershootOrAmplitude = 1.70158f;
static const float defaultEasePeriod = 0;





@interface QuickAnimationEaseManager()


@end

@implementation QuickAnimationEaseManager


+ (float)evalute:(QuickAnimationEaseType)easeType time:(float)time duration:(float)duration{
    return [QuickAnimationEaseManager evalute:easeType time:time duration:duration overshootOrAmplitude:defaultEaseOvershootOrAmplitude period:defaultEasePeriod];
}

+ (float)evalute:(QuickAnimationEaseType)easeType time:(float)time duration:(float)duration overshootOrAmplitude:(float)overshootOrAmplitude period:(float)period{

    switch (easeType) {
        case QuickAnimationEaseLinear:
            return time / duration;
        case QuickAnimationEaseInSine:
            return -(float)cosf(time / duration * _PiOver2) + 1;
        case QuickAnimationEaseOutSine:
            return (float)sinf(time / duration * _PiOver2);
        case QuickAnimationEaseInOutSine:
            return -0.5f * ((float)cosf(M_PI * time / duration) - 1);
        case QuickAnimationEaseInQuad:
            time /= duration;
            return time * time;
        case QuickAnimationEaseOutQuad:
            time /= duration;
            return -time * (time - 2);
        case QuickAnimationEaseInOutQuad:
            time /= duration * 0.5f;
            if (time < 1) return 0.5f * time * time;
            time--;
            return -0.5f * (time * (time - 2) - 1);
        case QuickAnimationEaseInCubic:
            time /= duration;
            return time * time * time;
        case QuickAnimationEaseOutCubic:
            time = time / duration - 1;
            return (time * time * time + 1);
        case QuickAnimationEaseInOutCubic:
            time /= duration * 0.5f;
            if (time < 1) return 0.5f * time * time * time;
            time -= 2;
            return 0.5f * (time * time * time + 2);
        case QuickAnimationEaseInQuart:
            time /= duration;
            return time * time * time * time;
        case QuickAnimationEaseOutQuart:
            time = time / duration - 1;
            return -(time * time * time * time - 1);
        case QuickAnimationEaseInOutQuart:
            time /= duration * 0.5f;
            if (time < 1) return 0.5f * time * time * time * time;
            time -= 2;
            return -0.5f * (time * time * time * time - 2);
        case QuickAnimationEaseInQuint:
            time /= duration;
            return time * time * time * time * time;
        case QuickAnimationEaseOutQuint:
            time = time / duration - 1;
            return (time * time * time * time * time + 1);
        case QuickAnimationEaseInOutQuint:
            time /= duration * 0.5f;
            if (time < 1) return 0.5f * time * time * time * time * time;
            time -= 2;
            return 0.5f * (time * time * time * time * time + 2);
        case QuickAnimationEaseInExpo:
            return (time == 0) ? 0 : (float)powf(2, 10 * (time / duration - 1));
        case QuickAnimationEaseOutExpo:
            if (time == duration) return 1;
            return (-(float)powf(2, -10 * time / duration) + 1);
        case QuickAnimationEaseInOutExpo:
            if (time == 0) return 0;
            if (time == duration) return 1;
            if ((time /= duration * 0.5f) < 1) return 0.5f * (float)powf(2, 10 * (time - 1));
            return 0.5f * (-(float)powf(2, -10 * --time) + 2);
        case QuickAnimationEaseInCirc:
            time /= duration;
            return -((float)sqrtf(1 - time * time) - 1);
        case QuickAnimationEaseOutCirc:
            time = time / duration - 1;
            return (float)sqrtf(1 - time * time);
        case QuickAnimationEaseInOutCirc:
            if ((time /= duration * 0.5f) < 1) return -0.5f * ((float)sqrtf(1 - time * time) - 1);
            time -= 2;
            return 0.5f * ((float)sqrtf(1 - time * time) + 1);
        case QuickAnimationEaseInElastic:
        {
            float s0;
            if (time == 0) return 0;
            if ((time /= duration) == 1) return 1;
            if (period == 0) period = duration * 0.3f;
            if (overshootOrAmplitude < 1) {
                overshootOrAmplitude = 1;
                s0 = period / 4;
            } else s0 = period / _TwoPi * (float)asinf(1 / overshootOrAmplitude);
            time -= 1;
            return -(overshootOrAmplitude * (float)powf(2, 10 * time) * (float)sinf((time * duration - s0) * _TwoPi / period));
        }
        case QuickAnimationEaseOutElastic:
        {
            float s1;
            if (time == 0) return 0;
            if ((time /= duration) == 1) return 1;
            if (period == 0) period = duration * 0.3f;
            if (overshootOrAmplitude < 1) {
                overshootOrAmplitude = 1;
                s1 = period / 4;
            } else s1 = period / _TwoPi * (float)asinf(1 / overshootOrAmplitude);
            return (overshootOrAmplitude * (float)powf(2, -10 * time) * (float)sinf((time * duration - s1) * _TwoPi / period) + 1);
        }
        case QuickAnimationEaseInOutElastic:
        {
            float s;
            if (time == 0) return 0;
            if ((time /= duration * 0.5f) == 2) return 1;
            if (period == 0) period = duration * (0.3f * 1.5f);
            if (overshootOrAmplitude < 1) {
                overshootOrAmplitude = 1;
                s = period / 4;
            } else s = period / _TwoPi * (float)asinf(1 / overshootOrAmplitude);
            time -= 1;
            if (time < 1) return -0.5f * (overshootOrAmplitude * (float)powf(2, 10 * time) * (float)sinf((time * duration - s) * _TwoPi / period));
            return overshootOrAmplitude * (float)powf(2, -10 * time) * (float)sinf((time * duration - s) * _TwoPi / period) * 0.5f + 1;
        }
        case QuickAnimationEaseInBack:
            time /= duration;
            return time * time * ((overshootOrAmplitude + 1) * time - overshootOrAmplitude);
            
        case QuickAnimationEaseOutBack:
            time = time / duration - 1;
            return (time * time * ((overshootOrAmplitude + 1) * time + overshootOrAmplitude) + 1);
            
        case QuickAnimationEaseInOutBack:
            overshootOrAmplitude *= (1.525f);
            if ((time /= duration * 0.5f) < 1) return 0.5f * (time * time * ((overshootOrAmplitude + 1) * time - overshootOrAmplitude));
            time -= 2;
            return 0.5f * (time * time * ((overshootOrAmplitude + 1) * time + overshootOrAmplitude) + 2);
            
        case QuickAnimationEaseInBounce:
            return [QuickAnimationEaseManager bounceEaseIn:time duration:duration];
            
        case QuickAnimationEaseOutBounce:
            return [QuickAnimationEaseManager bounceEaseOut:time duration:duration];
            
        case QuickAnimationEaseInOutBounce:
            return [QuickAnimationEaseManager bounceEaseInOut:time duration:duration];

        case QuickAnimationEaseFlash:
            return [QuickAnimationEaseManager flashEase:time duration:duration overshootOrAmplitude:overshootOrAmplitude period:period];
            
        case QuickAnimationEaseInFlash:
            return [QuickAnimationEaseManager flashEaseIn:time duration:duration overshootOrAmplitude:overshootOrAmplitude period:period];
            
        case QuickAnimationEaseOutFlash:
            return [QuickAnimationEaseManager flashEaseOut:time duration:duration overshootOrAmplitude:overshootOrAmplitude period:period];
            
        case QuickAnimationEaseInOutFlash:
            return [QuickAnimationEaseManager flashEaseInOut:time duration:duration overshootOrAmplitude:overshootOrAmplitude period:period];
            
            // Default
        default:
            // OutQuad
            time /= duration;
            return -time * (time - 2);
    }
    
}


+ (float)bounceEaseOut:(float)time duration:(float)duration{
    time /= duration;
    if (time < (1 / 2.75f)) {
        return (7.5625f * time * time);
    }
    if (time < (2 / 2.75f)) {
        time -= (1.5f / 2.75f);
        return (7.5625f * time * time + 0.75f);
    }
    if (time < (2.5f / 2.75f)) {
        time -= (2.25f / 2.75f);
        return (7.5625f * time * time + 0.9375f);
    }
    time -= (2.625f / 2.75f);
    return (7.5625f * time * time + 0.984375f);
}

+ (float)bounceEaseIn:(float)time duration:(float)duration{
    
    return 1 - [self bounceEaseOut:duration - time duration:duration];
}

+ (float)bounceEaseInOut:(float)time duration:(float)duration{
    if (time < duration*0.5f)
    {
        return [self bounceEaseIn:time*2 duration:duration]*0.5f;
    }
    return [self bounceEaseOut:time*2 - duration duration:duration]*0.5f + 0.5f;
}

+ (float)flashEase:(float)time duration:(float)duration overshootOrAmplitude:(float)overshootOrAmplitude period:(float)period{
    int stepIndex = (int)(ceilf((time / duration) * overshootOrAmplitude));
    float stepDuration = duration / overshootOrAmplitude;
    time -= stepDuration * (stepIndex - 1);
    float dir = (stepIndex % 2 != 0) ? 1 : -1;
    if (dir < 0) time -= stepDuration;
    float res = (time * dir) / stepDuration;
    
    return [QuickAnimationEaseManager weightedEaseOvershootOrAmplitude:overshootOrAmplitude period:period stepIndex:stepIndex stepDuration:stepDuration dir:dir res:res];
}

+ (float)flashEaseIn:(float)time duration:(float)duration overshootOrAmplitude:(float)overshootOrAmplitude period:(float)period{
    
    int stepIndex = (int)(ceilf((time / duration) * overshootOrAmplitude));
    float stepDuration = duration / overshootOrAmplitude;
    time -= stepDuration * (stepIndex - 1);
    float dir = (stepIndex % 2 != 0) ? 1 : -1;
    if (dir < 0) time -= stepDuration;
    time = time * dir;
    time /= stepDuration;
    float res = time * time;
    return [QuickAnimationEaseManager weightedEaseOvershootOrAmplitude:overshootOrAmplitude period:period stepIndex:stepIndex stepDuration:stepDuration dir:dir res:res];
}

+ (float)flashEaseOut:(float)time duration:(float)duration overshootOrAmplitude:(float)overshootOrAmplitude period:(float)period{
    int stepIndex = (int)(ceilf((time / duration) * overshootOrAmplitude));
    float stepDuration = duration / overshootOrAmplitude;
    time -= stepDuration * (stepIndex - 1);
    float dir = (stepIndex % 2 != 0) ? 1 : -1;
    if (dir < 0) time -= stepDuration;
    time = time * dir;
    time /= stepDuration;
    float res = -time * (time - 2);
    return [QuickAnimationEaseManager weightedEaseOvershootOrAmplitude:overshootOrAmplitude period:period stepIndex:stepIndex stepDuration:stepDuration dir:dir res:res];

}

+ (float)flashEaseInOut:(float)time duration:(float)duration overshootOrAmplitude:(float)overshootOrAmplitude period:(float)period{
    
    int stepIndex = (int)(ceilf((time / duration) * overshootOrAmplitude));
    float stepDuration = duration / overshootOrAmplitude;
    time -= stepDuration * (stepIndex - 1);
    float dir = (stepIndex % 2 != 0) ? 1 : -1;
    if (dir < 0) time -= stepDuration;
    time = time * dir;
    time /= stepDuration * 0.5f;
    float res = time < 1
    ? 0.5f * time * time
    : -0.5f * ((time-1) * (time - 1 - 2) - 1);
    return [QuickAnimationEaseManager weightedEaseOvershootOrAmplitude:overshootOrAmplitude period:period stepIndex:stepIndex stepDuration:stepDuration dir:dir res:res];
}

+ (float)weightedEaseOvershootOrAmplitude:(float)overshootOrAmplitude period:(float)period stepIndex:(int)stepIndex stepDuration:(float)stepDuration dir:(float)dir res:(float)res{
    float easedRes = 0;
    float finalDecimals = 0;
    // Use previous stepIndex in case of odd ones, so that back ease is not clamped
    if (dir > 0 && (int)overshootOrAmplitude % 2 == 0) stepIndex++;
    else if (dir < 0 && (int)overshootOrAmplitude % 2 != 0) stepIndex++;
    
    if (period > 0) {
        float finalTruncated = (float)truncf(overshootOrAmplitude);
        finalDecimals = overshootOrAmplitude - finalTruncated;
        if (fmodf(finalTruncated,2.0f)> 0) finalDecimals = 1 - finalDecimals;
        finalDecimals = (finalDecimals * stepIndex) / overshootOrAmplitude;
        easedRes = (res * (overshootOrAmplitude - stepIndex)) / overshootOrAmplitude;
    } else if (period < 0) {
        period = -period;
        easedRes = (res * stepIndex) / overshootOrAmplitude;
    }
    float diff = easedRes - res;
    res += (diff * period) + finalDecimals;
    if (res > 1) res = 1;
    return res;
}

@end
