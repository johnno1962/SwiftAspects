//
//  SwiftAspects-Bridging-Header.h
//  SwiftAspects
//
//  Created by John Holdsworth on 21/06/2014.
//  Copyright (c) 2014 John Holdsworth. All rights reserved.
//

#import "Xtrace.h"

static inline id blockConvert( void (^aBlock)( id, SEL, int, int, int) ) {
    return aBlock;
}

static inline id blockConvertOpt( int (^aBlock)( id, SEL, int, int, int, int) ) {
    return aBlock;
}

#import <UIKit/UIkit.h>

static inline id blockConvertRect( CGRect (^aBlock)( id, SEL, CGRect, int, int, int) ) {
    return aBlock;
}

static inline id blockConvertPoint( CGPoint (^aBlock)( id, SEL, CGPoint, int, int, int) ) {
    return aBlock;
}
