//
//  XPRLMState.h
//  pandaMentor
//
//  Created by Tulipa on 14/10/13.
//  Copyright (c) 2014年  reserved.
//

#ifndef pandaMentor_XPRLMState_h
#define pandaMentor_XPRLMState_h

typedef NS_OPTIONS(NSUInteger, XPRLMState)
{
	XPRLMStateNormal = 1 << 0,
	
	XPRLMStateWillTriggerPullToRefresh = 1 << 1,
	XPRLMStateRefreshing = 1 << 2,
	
	XPRLMStateWillTriggerLoadMore = 1 << 3,
	XPRLMStateLoadingMore = 1 << 4,
	XPRLMStateNoMore = 1 << 5,
	
	XPRLMStateError = 1 << 6
};

#endif
