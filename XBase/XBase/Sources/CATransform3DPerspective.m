//
//  CATransform3DPerspective.c
//  BabyDress
//
//  Created by 臧金晓 on 15/1/3.
//  Copyright (c) 2015年 7ul.ipa. All rights reserved.
//

#include "CATransform3DPerspective.h"

CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}