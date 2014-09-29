//
//  HNCommentsCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-9-29.
//
//

#import <UIKit/UIKit.h>
@class HNCommentsCell;
@protocol HNCommentsDelegate <NSObject>

- (void)CommentsNewDid:(HNCommentsCell*)commentsCell;
- (void)CommentsDeleteDid:(HNCommentsCell*)commentsCell;
- (void)CommentsHideDid:(HNCommentsCell*)commentsCell;

@end

@interface HNCommentsCell : UIView
@property (nonatomic, retain) id <HNCommentsDelegate> delegate;
- (id)initWithFrame:(CGRect)frame;
@end
