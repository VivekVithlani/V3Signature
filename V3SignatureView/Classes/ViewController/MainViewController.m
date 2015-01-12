//
//  MainViewController.m
//  V3SignatureView
//
//  Created by BBITSDev on 31/07/14.
//  Copyright (c) 2014 com.v3Signature. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize v3SignView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Signature";
    }
    return self;
}
#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray.png"]];

    float btnCorner;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        btnCorner = 30;
        [v3SignView setStrockWidth:5];
        [v3SignView setErazerStrockWidth:20];
    }
    else
    {
        btnCorner = 10;
    }

    for (UIButton* btn in btnColor) {
        btn.layer.cornerRadius = btnCorner;
        if (btn.tag == 1) {
            [self btnColorPressed:btn];
        }
    }
}

#pragma mark - Button Pressed
/*------------------------------------------------------------------
 Procedure/Function Name: btnSave
 Purpose: Save Image in Album
 ------------------------------------------------------------------*/
- (IBAction)btnSave:(id)sender {
    v3SignView.backgroundColor = [UIColor clearColor];
    NSData* data =  UIImagePNGRepresentation(v3SignView.image);
    UIImage* pngImage = [UIImage imageWithData:data];
    UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil);
    v3SignView.backgroundColor = [UIColor whiteColor];
}

/*------------------------------------------------------------------
 Procedure/Function Name: btnResetPressed
 Purpose: Reset V3SignatureView (Clear SignatureView)
 ------------------------------------------------------------------*/
- (IBAction)btnResetPressed:(id)sender {
    [v3SignView setImage:nil];
}

/*------------------------------------------------------------------
 Procedure/Function Name: btnErazerPressed
 Purpose: Eraze on V3SignatureView
 ------------------------------------------------------------------*/
- (IBAction)btnErazerPressed:(id)sender {
    for (UIButton* btn in btnColor) {
        btn.layer.borderWidth = 0;
    }
    [v3SignView setErazerMode:true];
}

/*------------------------------------------------------------------
 Procedure/Function Name: btnColorPressed
 Purpose: Change Draw Line Color
 ------------------------------------------------------------------*/
- (IBAction)btnColorPressed:(UIButton *)sender {
    [v3SignView setErazerMode:false];
    [v3SignView setStrockColor:sender.backgroundColor];
    
    for (UIButton* btn in btnColor) {
        btn.layer.borderWidth = 0;
        [lblBorder removeFromSuperview];
        lblBorder = nil;
    }
    sender.layer.borderColor = [[UIColor whiteColor] CGColor];

    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        lblBorder = [[UILabel alloc] initWithFrame:CGRectMake(sender.frame.origin.x-3, sender.frame.origin.y-3, sender.frame.size.width+6, sender.frame.size.height+6)];

        sender.layer.borderWidth = 3;
        lblBorder.layer.borderWidth = 4;
        lblBorder.layer.cornerRadius = 30;
    }
    else
    {
        lblBorder = [[UILabel alloc] initWithFrame:CGRectMake(sender.frame.origin.x-2, sender.frame.origin.y-2, sender.frame.size.width+4, sender.frame.size.height+4)];
        sender.layer.borderWidth = 1;
        lblBorder.layer.borderWidth = 2	;
        lblBorder.layer.cornerRadius = 12;
    }

    lblBorder.layer.borderColor = [[UIColor redColor] CGColor];
    lblBorder.backgroundColor = [UIColor clearColor];
    [vwColor addSubview:lblBorder];
//    [lblBorder sendSubviewToBack:sender];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
