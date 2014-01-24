//
//  SCMainViewController.m
//  SCStackViewController
//
//  Created by Stefan Ceriu on 17/08/2013.
//  Copyright (c) 2013 Stefan Ceriu. All rights reserved.
//

#import "SCMainViewController.h"

@interface SCMainViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation SCMainViewController

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return SCStackLayouterTypeCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    static NSDictionary *typeToString;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        typeToString = (@{
                        @(SCStackLayouterTypePlain)              : @"Plain",
                        @(SCStackLayouterTypeSliding)            : @"Sliding",
                        @(SCStackLayouterTypeParallax)           : @"Parallax",
                        @(SCStackLayouterTypeGoogleMaps)         : @"Google Maps",
                        @(SCStackLayouterTypeMerryGoRound)       : @"Merry Go Round",
                        @(SCStackLayouterTypeReversed)           : @"Reversed",
                        @(SCStacklayouterTypePlainResizing)      : @"Resizing"
                        });
    });
    
    [cell.textLabel setText:typeToString[@(indexPath.row)]];
    [cell.textLabel setFont:[UIFont fontWithName:@"Menlo" size:18.0f]];
    [cell setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.20f]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(mainViewController:didSelectLayouterType:)]) {
        [self.delegate mainViewController:self didSelectLayouterType:indexPath.row];
    }
}

@end
