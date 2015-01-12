//
//  MainViewController.h
//  V3SignatureView
//
//  Created by BBITSDev on 31/07/14.
//  Copyright (c) 2014 com.v3Signature. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "V3SignatureView.h"

@interface MainViewController : UIViewController
{
    IBOutlet UIButton *btnErazer;
    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnReset;
    IBOutlet UIView *vwColor;
    IBOutletCollection(UIButton) NSArray *btnColor;
    UILabel *lblBorder;

    
    
}
@property (nonatomic, retain) IBOutlet V3SignatureView *v3SignView;

- (IBAction)btnSave:(id)sender;
- (IBAction)btnResetPressed:(id)sender;
- (IBAction)btnErazerPressed:(id)sender;
- (IBAction)btnColorPressed:(id)sender;
@end
