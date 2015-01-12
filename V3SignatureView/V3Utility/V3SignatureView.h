//
//  V3SignatureView.h
//  V3SignatureView
//
//  Created by Vivek Vithlani on 31/07/14.
//  Copyright (c) 2014 com.v3Signature. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface V3SignatureView : UIImageView
@property (assign) CGPoint previousPoint;
@property (nonatomic,retain) NSMutableArray *arrPoints;
@property (assign, readwrite) BOOL erazerMode;
@property (nonatomic, retain) UIColor *strockColor;
@property (assign) float strockWidth;
@property (assign) float erazerStrockWidth;

@end
