//
//  CanvasNode.h
//  Html_Hpple
//
//  Created by iflashbuy_dev on 2016/12/2.
//  Copyright © 2016年 com.wangan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>

xmlXPathContextPtr contextByUrl(NSString *url);
xmlXPathContextPtr contextByCode(NSString *url);
xmlNodePtr rootNode(xmlXPathContextPtr ctx);

NSString *nodeString(xmlNodePtr xmlNode);
NSString *nodeName(xmlNodePtr xmlNode);
NSDictionary *nodeAttrs(xmlNodePtr xmlNode);
NSArray *attrValues(xmlNodeSetPtr xmlNodeSet, NSString *log);

xmlNodePtr node(xmlNodePtr node,xmlXPathContextPtr ctx, NSString *query, NSString *log);
xmlNodeSetPtr nodes(xmlNodePtr node,xmlXPathContextPtr ctx, NSString *query, NSString *log);

