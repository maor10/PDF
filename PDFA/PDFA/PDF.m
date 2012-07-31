//
//  PDF.m
//  Receipts
//
//  Created by Maor Kern on 6/18/12.
//  Copyright (c) 2012 maor.kern@gmail.com. All rights reserved.
//

#import "PDF.h"

@implementation PDF
@synthesize size, imageArray, header, imageRectArray, textArray, textRectArray, data, headerRect;
-(void)initContent{
    imageArray = [[NSMutableArray alloc]init];
    imageRectArray = [[NSMutableArray alloc]init];
    
    textArray = [[NSMutableArray alloc]init];
    textRectArray = [[NSMutableArray alloc]init];
    
    data = [NSMutableData data];
    headerRect = CGRectMake(332, 30, 137, 30);
  //  data = [NSMutableData data];

}
- (void) drawHeader
{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext,  0.0, 0.0, 0.0, 1.0);
    
    NSString *textToDraw = header;
    
    UIFont *font = [UIFont systemFontOfSize:24.0];
    /*
    CGSize stringSize = [textToDraw sizeWithFont:font constrainedToSize:CGSizeMake(size.width - 2*kBorderInset-2*kMarginInset, size.height - 2*kBorderInset - 2*kMarginInset) lineBreakMode:UILineBreakModeWordWrap];
    
    
    CGRect renderingRect = CGRectMake(kBorderInset + kMarginInset, kBorderInset + kMarginInset, size.width - 2*kBorderInset - 2*kMarginInset, stringSize.height);
    */
    CGRect renderingRect = headerRect;
    [textToDraw drawInRect:renderingRect withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
}
-(void)drawImage{
    for (int i = 0; i < [imageArray count]; i++) {
        [[imageArray objectAtIndex:i] drawInRect:[[imageRectArray objectAtIndex:i]CGRectValue]];

    }
}
- (void) drawText
{
    for (int i = 0; i < [textArray count]; i++) {
        
    
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 0.0, 0.0, 0.0, 1.0);
    
    NSString *textToDraw = [textArray objectAtIndex:i];
    
    UIFont *font = [UIFont systemFontOfSize:14.0];
    
        NSLog(@"Text to draw: %@", textToDraw);
        CGRect renderingRect = [[textRectArray objectAtIndex:i]CGRectValue];
        NSLog(@"x of rect is %f",  renderingRect.origin.x);
   
    
        [textToDraw drawInRect:renderingRect
                  withFont:font
             lineBreakMode:UILineBreakModeWordWrap
                 alignment:UITextAlignmentLeft];
    }
    
}
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}
-(void)addImageWithRect:(UIImage *)image :(CGRect)rect{
    UIImage *newImage = [PDF imageWithImage:image scaledToSize:CGSizeMake(rect.size.width, rect.size.height)];
        
    
    [imageArray addObject:newImage];
    [imageRectArray addObject:[NSValue valueWithCGRect:rect]];
    //imageForPdf = [UIImage imageNamed:@"button.png"];
    /*UIGraphicsBeginImageContext(size);

    [imageForPdf drawAtPoint:CGPointMake(0,0)];
    //Watch for errors on next line;; never tried before
   // [image drawAtPoint:CGPointMake(0,0)];
	[image drawInRect:rect];
    
    imageForPdf = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
     */
}
-(void)addTextWithRect:(NSString *)text :(CGRect)rect{
    [textArray addObject:text];
    [textRectArray addObject:[NSValue valueWithCGRect:rect]];
}
- (NSMutableData*) generatePdfWithFilePath: (NSString *)thefilePath
{
    
    UIGraphicsBeginPDFContextToFile(thefilePath, CGRectZero, nil);
   
   
    BOOL done = NO;
    do 
    {
        //Start a new page.
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, size.width, size.height), nil);
        
        //Draw Header
        [self drawHeader];
        //Draw Text
        [self drawText];
        //Draw an image
        [self drawImage];
        
        done = YES;
    } 
    while (!done);
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
    
    
    //For data    
    UIGraphicsBeginPDFContextToData(data, CGRectZero, nil);
    
    
    BOOL done1 = NO;
    do 
    {
        //Start a new page.
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, size.width, size.height), nil);
        
        //Draw Header
        [self drawHeader];
        //Draw Text
        [self drawText];
        //Draw an image
        [self drawImage];
        
        done1 = YES;
    } 
    while (!done1);
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
    return data;
}

@end
