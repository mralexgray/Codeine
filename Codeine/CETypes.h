/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#ifndef __CE_TYPES_H__
#define __CE_TYPES_H__

typedef enum
{
    CEOptimizationLevelNone             = 0x00,
    CEOptimizationLevelFast             = 0x01,
    CEOptimizationLevelFaster           = 0x02,
    CEOptimizationLevelFastest          = 0x03,
    CEOptimizationLevelFastestSmallest  = 0x04
}
CEOptimizationLevel;

#endif
