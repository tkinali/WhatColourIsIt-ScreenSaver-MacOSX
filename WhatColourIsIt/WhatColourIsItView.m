//
//  WhatColourIsItView.m
//  WhatColourIsIt
//
//  Created by Tuncay Kınalı on 17/12/14.
//  Copyright (c) 2014 Tuncay Kınalı. All rights reserved.
//

#import "WhatColourIsItView.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation WhatColourIsItView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (CGFloat)widthOfString:(NSString *)string withFont:(NSFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

- (CGFloat)heightOfString:(NSString *)string withFont:(NSFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].height;
}

- (void)animateOneFrame
{
    NSSize size;
    NSRect rect, saat, renkKodu;
    NSBezierPath *path;
    NSColor *color;
    
    // Ekran boyutunu al
    size = [self bounds].size;
    
    // Saatin fontunu ayarla
    NSFont* saatFontu = [NSFont fontWithName:@"Helvetica" size:size.width/11];
    
    // Renk kodunun fontunu ayarla
    NSFont* renkKoduFontu = [NSFont fontWithName:@"Helvetica" size:size.height/30];
    
    // Arkaplani ayarla
    rect.size = NSMakeSize(size.width, size.height);
    rect.origin.x = 0;
    rect.origin.y = 0;
    
    // Saat fontunun genislik ve yuksekligini hesapla
    CGFloat sfWidth = [self widthOfString:@"88 : 88 : 88" withFont:saatFontu];
    CGFloat sfHeight = [self heightOfString:@"88 : 88 : 88" withFont:saatFontu];
    
    // Renk kodu fontunun genislik ve yuksekligini hesapla
    CGFloat rkfWidth = [self widthOfString:@"#888888" withFont:renkKoduFontu];
    CGFloat rkfHeight = [self heightOfString:@"#888888" withFont:renkKoduFontu];
    
    // Saatin yazdirilacagi konumu belirle
    saat.size = NSMakeSize(sfWidth, sfHeight);
    saat.origin.x = (size.width/2)-(sfWidth/2);
    saat.origin.y = (size.height/2)-(sfHeight/2);
    
    // Renk kodunun yazdirilacagi konumu belirle
    renkKodu.size = NSMakeSize(rkfWidth, rkfHeight);
    renkKodu.origin.x = (size.width/2)-(rkfWidth/2);
    renkKodu.origin.y = (size.height/6);
    
    // Arkaplani ciz
    path = [NSBezierPath bezierPathWithRect:rect];
    
    // Saati al
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:now];
    
    // Saat, dakika ve saniyeyi belirle ve ayri ayri tut
    NSString *hour = [NSString stringWithFormat:@"%li", (long)[components hour]];
    NSString *minute = [NSString stringWithFormat:@"%li", (long)[components minute]];
    NSString *seconds = [NSString stringWithFormat:@"%li", (long)[components second]];
    
    // Saat, dakika ve saniyeyi HEX'e cevir
    unsigned hHour = 0;
    unsigned hMinute = 0;
    unsigned hSeconds = 0;
    
    NSScanner *scannerH = [NSScanner scannerWithString:hour];
    NSScanner *scannerM = [NSScanner scannerWithString:minute];
    NSScanner *scannerS = [NSScanner scannerWithString:seconds];
    
    [scannerH scanHexInt:&hHour];
    [scannerM scanHexInt:&hMinute];
    [scannerS scanHexInt:&hSeconds];
    
    // HEX rakamlari float"a cevir
    float fHour = [[NSNumber numberWithInt: hHour] floatValue];
    float fMinute = [[NSNumber numberWithInt: hMinute] floatValue];
    float fSeconds = [[NSNumber numberWithInt: hSeconds] floatValue];
    
    // Arkaplan rengini ayarla
    color = [NSColor colorWithCalibratedRed:fHour/255.0 green:fMinute/255.0 blue:fSeconds/255.0 alpha:1.0];
    [color set];
    
    // Arkaplani boya
    [path fill];
    
    // Saat stringini olustur
    NSString* strSaat = [NSString stringWithFormat:@"%@ : %@ : %@", (hHour < 10 ? [NSString stringWithFormat:@"0%@", hour] : hour), (hMinute < 10 ? [NSString stringWithFormat:@"0%@", minute] : minute), (hSeconds < 10 ? [NSString stringWithFormat:@"0%@", seconds] : seconds)];
    
    // Saati yazdir
    [strSaat drawInRect:saat withAttributes:@{NSFontAttributeName:saatFontu, NSForegroundColorAttributeName : [NSColor whiteColor]}];
    
    // Renk kodunun stringini olustur
    NSString* strRenkKodu = [NSString stringWithFormat:@"#%@%@%@", (hHour < 10 ? [NSString stringWithFormat:@"0%@", hour] : hour), (hMinute < 10 ? [NSString stringWithFormat:@"0%@", minute] : minute), (hSeconds < 10 ? [NSString stringWithFormat:@"0%@", seconds] : seconds)];
    
    // Renk kodunu yazdir
    [strRenkKodu drawInRect:renkKodu withAttributes:@{NSFontAttributeName:renkKoduFontu, NSForegroundColorAttributeName : [NSColor whiteColor]}];
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
