//
//  CanvasHTML.h
//  Html_Hpple
//
//  Created by Cyfuer on 2016/11/30.
//  Copyright © 2016年 Cyfuer. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CanvasHTML : NSObject

// the url of the html,such as "http://www.cyfuer.com"(记得以后改成自己的站点)
@property (strong, nonatomic, readonly) NSString *url;

/**
 the initializer for root

 @param url the url of html,available to both http and https
 @return CanvasHTML object with root tag
 */
- (id)initWithURL:(NSString *)url;
/*
 *  initialize by source code of xml or html
 */
- (id)initWithCode:(NSString *)code;

@end


@interface CanvasHTML (Property)

// the text contained by current tag,such as "<a>text</a>",return "text"
@property (strong, nonatomic, readonly) NSString *string;

// the name of current tag,such as current tag is <a>,it return "a"
@property (strong, nonatomic, readonly) NSString *name;

// the attributes of current tag,such as {"id":"cyfuer","class":"study"}
@property (strong, nonatomic, readonly) NSDictionary *attrs;

- (NSArray <NSString *>*)findValuesWithKey:(NSString *)key;
- (NSArray <NSString *>*)findValuesInParentWithKey:(NSString *)key;
- (NSArray <NSString *>*)findValuesInSiblingWithKey:(NSString *)key;
- (NSArray <NSString *>*)findValuesInChildrenWithKey:(NSString *)key;
- (NSArray <NSString *>*)findValuesWithKey:(NSString *)key tagName:(NSString *)name tagAttrs:(NSDictionary *)dict;

@end


@interface CanvasHTML (Ralationship)

// the parent tag of current tag
@property (strong, nonatomic, readonly) CanvasHTML *parent;
// the array contain the parent tag of current tag and the parent tag's sibling
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *parents;

// the first one in children of current tag
@property (strong, nonatomic, readonly) CanvasHTML *firstChildren;
// the last one in children of current tag
@property (strong, nonatomic, readonly) CanvasHTML *lastChildren;
// all of current tag's children
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *childrens;

// previous sibling of current tag
@property (strong, nonatomic, readonly) CanvasHTML *prevSibling;
// next sibling of current tag
@property (strong, nonatomic, readonly) CanvasHTML *nextSibling;
// all siblings front of current tag
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *prevSiblings;
// all siblings behind current tag
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *nextSiblings;
// all siblings of current tag, care about that it contain itself
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *siblings;

// the ancestors of current tag
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *ancestors;
// the descendants of current tag
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *descendants;

@end


@interface CanvasHTML (Tag)

// all of following tags are find from current tag's childrens
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *as; // a
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *bs; // b
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *ps; // p
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *ems; // em
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *imgs; // img
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *divs; // div
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *bigs; // big
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *spans; // span
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *smalls; // small
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *canvas; // canvas
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *strongs; // strong
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *buttons; // button
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *articles; // article
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *h1s; // h1
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *h2s; // h2
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *h3s; // h3
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *h4s; // h4
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *h5s; // h5
@property (strong, nonatomic, readonly) NSArray <CanvasHTML *> *h6s; // h6

/**
 find canvas in context
 
 @param name canvas‘s name,if no name,it will find out all kinds of canvas
 @param attrs canvas’s name,if you want to find tag by a sepcify attribute with any value,just set the value by @"",but when attribute have mutiple value,you should set all of value as value of the attribute.
 @return array of found canvasHtml
 */
- (NSArray <CanvasHTML *>*)findCanvasWithName:(NSString *)name attrs:(NSDictionary *)attrs;

/**
 find canvas in parents
 */
- (NSArray <CanvasHTML *>*)findParentCanvasWithName:(NSString *)name attrs:(NSDictionary *)attrs;

/**
 find canvas in siblings
 */
- (NSArray <CanvasHTML *>*)findSiblingCanvasWithName:(NSString *)name attrs:(NSDictionary *)attrs;

/**
 find canvas in childrens
 */
- (NSArray <CanvasHTML *>*)findChildrenCanvasWithName:(NSString *)name attrs:(NSDictionary *)attrs;

@end

