//
//  SocializeViewController.m
//  Socialize
//
//  Created by Isaac Mosquera on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SocializeViewController.h"
#import <Socialize/Socialize.h>
#import "SZPathBar.h"

@implementation SocializeViewController
@synthesize webView = webView_;

int loaded = 0;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadRequestForOrientation:(UIDeviceOrientation)orientation {
    NSString *path;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        if (UIDeviceOrientationIsPortrait(orientation)) {
            path = @"html_ipad/index";
        } else {
            path = @"html_ipad/index_landscape";
        }
    } else {
        if (UIDeviceOrientationIsPortrait(orientation)) {
            path = @"html/index";
        } else {
            path = @"html/index_landscape";
        }
    }
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:path ofType:@"html"] isDirectory:NO];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.webView = [[UIWebView alloc]init];
    self.webView.delegate = self;
    self.webView.frame = [[UIScreen mainScreen] bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    self.view.backgroundColor = [UIColor blueColor];
    
    [self loadRequestForOrientation:UIInterfaceOrientationPortrait];
    
    [self.view addSubview:self.webView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {    
    loaded++;
    if ( loaded >=2 ) {
        SZEntity *entity = [SZEntity entityWithKey:@"http://ww.google.com" name:@"new name"];
       
        if(self.sszBar == nil)
        {
            self.sszBar = [[[SZPathBar alloc] initWithButtonsMask: SZCommentsButtonMask|SZShareButtonMask|SZLikeButtonMask
                                                 parentController: self
                                                           entity: entity]autorelease];
            
            self.sszBar.menu.startPoint = CGPointMake(self.view.bounds.size.width - 50, self.view.bounds.size.height - 80);
            
            [self.view addSubview:self.sszBar.menu];
        }
    }
    return YES; 
}
- (void)viewDidUnload   
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    loaded--;
    [self loadRequestForOrientation:toInterfaceOrientation];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{    
    if(self.sszBar.menu.expanding)
        self.sszBar.menu.expanding = NO;
    self.sszBar.menu.startPoint = CGPointMake(self.view.bounds.size.width - 50, self.view.bounds.size.height - 70);
}

-(void) dealloc
{
    self.sszBar = nil;
    self.webView = nil;
    
    [super dealloc];
}
@end
