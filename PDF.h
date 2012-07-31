//
//  PDF.h
//  Receipts
//
//  Created by Maor Kern on 6/18/12.
//  Copyright (c) 2012 maor.kern@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface PDF : NSObject{
}
@property(nonatomic, readwrite) CGSize size;
@property(nonatomic, readwrite) CGRect headerRect;

@property(nonatomic, strong) NSString *header;

@property(nonatomic, strong) NSMutableArray *imageArray;
@property(nonatomic, strong) NSMutableArray *imageRectArray;

@property(nonatomic, strong) NSMutableArray *textArray;
@property(nonatomic, strong) NSMutableArray *textRectArray;

@property(nonatomic, strong)  NSMutableData *data;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

-(void)initContent;
-(void)addImageWithRect:(UIImage*)image:(CGRect)rect;
-(void)addTextWithRect:(NSString*)text:(CGRect)rect;

- (void) drawHeader;
- (void) drawImage;
- (NSMutableData*) generatePdfWithFilePath: (NSString *)thefilePath;
@end
