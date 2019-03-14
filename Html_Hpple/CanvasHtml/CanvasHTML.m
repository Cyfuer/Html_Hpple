//
//  CanvasHTML.m
//  Html_Hpple
//
//  Created by Cyfuer on 2016/11/30.
//  Copyright © 2016年 Cyfuer. All rights reserved.
//

#import "CanvasHTML.h"

#import "CanvasNode.h"


@interface CanvasHTML () {
    xmlXPathContextPtr ctx;
    xmlNodePtr n;
}

@end

@implementation CanvasHTML


#pragma mark - Intialize
- (id)initWithURL:(NSString *)url {
    // init fun for root node
    self = [super init];
    if (self) {
        _url = url;
        
        ctx = contextByUrl(url);
        n = rootNode(ctx);
        
        if (!ctx || !n) {
            return nil;
        }
    }
    return self;
}

- (id)initWithCode:(NSString *)code {
    // init fun for root node
    self = [super init];
    if (self) {
        _url = nil;
        
        ctx = contextByCode(code);
        n = rootNode(ctx);
        
        if (!ctx || !n) {
            return nil;
        }
    }
    return self;
}

- (instancetype)initWithCtx:(xmlXPathContextPtr)context node:(xmlNodePtr)node {
    // init fun for descendant node
    self = [super init];
    if (self) {
        ctx = context;
        n = node;
        
        if (!ctx || !n) {
            return nil;
        }
        
    }
    return self;
}

- (NSArray <CanvasHTML *>*)canvasWithQuery:(NSString *)query log:(NSString *)log {
    xmlNodeSetPtr xmlNodeSet = nodes(n, ctx, query, log);
    if (xmlNodeSet) {
        NSMutableArray *canvas = [NSMutableArray array];
        for (NSInteger i = 0; i < xmlNodeSet->nodeNr; i++) {
            CanvasHTML *canva = [[CanvasHTML alloc] initWithCtx:ctx node:xmlNodeSet->nodeTab[i]];
            [canvas addObject:canva];
        }
        return (NSArray *)canvas;
    } else {
        return nil;
    }
}

- (CanvasHTML *)canvaWithQuery:(NSString *)query log:(NSString *)log {
    xmlNodePtr xmlNode = node(n, ctx, query, log);
    if (xmlNode) {
        CanvasHTML *canva = [[CanvasHTML alloc] initWithCtx:ctx node:xmlNode];
        return canva;
    } else {
        return nil;
    }
}

- (NSArray <NSString *>*)valuesWithQuery:(NSString *)query log:(NSString *)log {
    xmlNodeSetPtr xmlNodeSet = nodes(n, ctx, query, log);
    if (xmlNodeSet) {
        return attrValues(xmlNodeSet, log);
    } else {
        return nil;
    }
}

BOOL isEmptyString(NSString *string) {
    if ([string isKindOfClass:[NSString class]] || [string isKindOfClass:[NSNull class]]) {
        return (string == nil) || [string isEqual:[NSNull null]] || (string.length == 0) ;
    }
    else {
        return YES;
    }
}

- (NSString *)getQueryStringByAttrs:(NSDictionary *)dict {
    if (dict && dict.count) {
        NSMutableString *string = [NSMutableString string];
        for (NSString *key in [dict allKeys]) {
            id value = dict[key];
            if (!value || ![value isKindOfClass:[NSString class]]) {
                continue;
            }
            
            NSString *v = (NSString *)value;
            if (v.length) {
                [string appendFormat:@"[@%@='%@']",key,v];
            } else {
                [string appendFormat:@"[@%@]",key];
            }
        }
        return (NSString *)string;
    }
    return @"";
}

NSString *logNameForFindCanvas(NSString *name) {
    return isEmptyString(name) ? @"*" : name;
}

NSString *logAttrsForFindCanvas(NSDictionary *attrs) {
    return attrs && attrs.count ? transformAttrToString(attrs) : @"";
}

NSString *transformAttrToString(NSDictionary *attrs) {
    NSMutableString *strM = [NSMutableString string];
    
    for (id obj in [attrs allKeys]) {
        [strM appendFormat:@" %@ = '%@'", obj, attrs[obj]];
    }
    
    return strM;
}

@end


@implementation CanvasHTML (Property)

- (NSString *)string {
    return nodeString(n);
}

- (NSString *)name {
    return nodeName(n);
}

- (NSDictionary *)attrs {
    return nodeAttrs(n);
}

- (NSArray <NSString *>*)findValuesWithKey:(NSString *)key {
    if (isEmptyString(key)) {
        return nil;
    } else {
        NSString *query = [NSString stringWithFormat:@".//@%@",key];
        NSString *log = [NSString stringWithFormat:@"no attribute named %@",key];
        return [self valuesWithQuery:query log:log];
    }
}

- (NSArray <NSString *>*)findValuesInParentWithKey:(NSString *)key {
    if (isEmptyString(key)) {
        return nil;
    } else {
        NSString *query = [NSString stringWithFormat:@"../../*/@%@",key];
        NSString *log = [NSString stringWithFormat:@"no attribute named %@ in parent",key];
        return [self valuesWithQuery:query log:log];
    }
}
- (NSArray <NSString *>*)findValuesInSiblingWithKey:(NSString *)key {
    if (isEmptyString(key)) {
        return nil;
    } else {
        NSString *query = [NSString stringWithFormat:@"../*/@%@",key];
        NSString *log = [NSString stringWithFormat:@"no attribute named %@ in sibling",key];
        return [self valuesWithQuery:query log:log];
    }
}
- (NSArray <NSString *>*)findValuesInChildrenWithKey:(NSString *)key {
    if (isEmptyString(key)) {
        return nil;
    } else {
        NSString *query = [NSString stringWithFormat:@"./*/@%@",key];
        NSString *log = [NSString stringWithFormat:@"no attribute named %@ in children",key];
        return [self valuesWithQuery:query log:log];
    }
}

- (NSArray <NSString *>*)findValuesWithKey:(NSString *)key tagName:(NSString *)name tagAttrs:(NSDictionary *)dict {
    if (isEmptyString(key)) {
        return nil;
    } else {
        NSString *query = [NSString stringWithFormat:@"//%@%@/@%@",(isEmptyString(name) ? @"*" : name), [self getQueryStringByAttrs:dict], key];
        NSString *log = [NSString stringWithFormat:@"no attribute named %@ in <%@ %@>", key, logNameForFindCanvas(name), logAttrsForFindCanvas(dict)];
        return [self valuesWithQuery:query log:log];
    }
}


@end


@implementation CanvasHTML (Ralationship)

- (CanvasHTML *)parent {
    return [self canvaWithQuery:@".." log:@"no parent"];
}

- (NSArray <CanvasHTML *>*)parents {
    return [self canvasWithQuery:@"../../*" log:@"no parents"];
}

- (CanvasHTML *)firstChildren {
    return [self canvaWithQuery:@"child::*[1]" log:@"no children"];
}

- (CanvasHTML *)lastChildren {
    return [self canvaWithQuery:@"child::*[last()]" log:@"no children"];
}

- (NSArray <CanvasHTML *>*)childrens {
    return [self canvasWithQuery:@"child::*" log:@"no childrens"];
}

- (CanvasHTML *)prevSibling {
    return [self canvaWithQuery:@"preceding-sibling::*[last()]" log:@"no preceding sibling"];
}

- (CanvasHTML *)nextSibling {
    return [self canvaWithQuery:@"following-sibling::*[1]" log:@"no following sibling"];
}

- (NSArray <CanvasHTML *>*)prevSiblings {
    return [self canvasWithQuery:@"preceding-sibling::*" log:@"no preceding siblings"];
}

- (NSArray <CanvasHTML *>*)nextSiblings {
    return [self canvasWithQuery:@"following-sibling::*" log:@"no following siblings"];
}

- (NSArray <CanvasHTML *>*)siblings {
    return [self canvasWithQuery:@"../*" log:@"no siblings"];
}

- (NSArray <CanvasHTML *>*)ancestors {
    return [self canvasWithQuery:@"ancestor::*" log:@"no ancestor"];
}

- (NSArray <CanvasHTML *>*)descendants {
    return [self canvasWithQuery:@"descendant::*" log:@"no descendant"];
}

@end


@implementation CanvasHTML (Tag)

- (NSArray <CanvasHTML *>*)as {
    return [self findChildrenCanvasWithName:@"a" attrs:nil];
}

- (NSArray <CanvasHTML *>*)bs {
    return [self findChildrenCanvasWithName:@"b" attrs:nil];
}

- (NSArray <CanvasHTML *>*)ps {
    return [self findChildrenCanvasWithName:@"p" attrs:nil];
}

- (NSArray <CanvasHTML *>*)ems {
    return [self findChildrenCanvasWithName:@"em" attrs:nil];
}

- (NSArray <CanvasHTML *>*)imgs {
    return [self findChildrenCanvasWithName:@"img" attrs:nil];
}

- (NSArray <CanvasHTML *>*)divs {
    return [self findChildrenCanvasWithName:@"div" attrs:nil];
}

- (NSArray <CanvasHTML *>*)bigs {
    return [self findChildrenCanvasWithName:@"big" attrs:nil];
}

- (NSArray <CanvasHTML *>*)spans {
    return [self findChildrenCanvasWithName:@"span" attrs:nil];
}

- (NSArray <CanvasHTML *>*)smalls {
    return [self findChildrenCanvasWithName:@"small" attrs:nil];
}

- (NSArray <CanvasHTML *>*)canvas {
    return [self findChildrenCanvasWithName:@"canvas" attrs:nil];
}

- (NSArray <CanvasHTML *>*)strongs {
    return [self findChildrenCanvasWithName:@"strong" attrs:nil];
}

- (NSArray <CanvasHTML *>*)buttons {
    return [self findChildrenCanvasWithName:@"button" attrs:nil];
}

- (NSArray <CanvasHTML *>*)articles {
    return [self findChildrenCanvasWithName:@"article" attrs:nil];
}

- (NSArray <CanvasHTML *>*)h1s {
    return [self findChildrenCanvasWithName:@"h1" attrs:nil];
}

- (NSArray <CanvasHTML *>*)h2s {
    return [self findChildrenCanvasWithName:@"h2" attrs:nil];
}

- (NSArray <CanvasHTML *>*)h3s {
    return [self findChildrenCanvasWithName:@"h3" attrs:nil];
}

- (NSArray <CanvasHTML *>*)h4s {
    return [self findChildrenCanvasWithName:@"h4" attrs:nil];
}

- (NSArray <CanvasHTML *>*)h5s {
    return [self findChildrenCanvasWithName:@"h5" attrs:nil];
}

- (NSArray <CanvasHTML *>*)h6s {
    return [self findChildrenCanvasWithName:@"h6" attrs:nil];
}

- (NSArray <CanvasHTML *>*)findCanvasWithName:(NSString *)name attrs:(NSDictionary *)attrs {
    
    NSString *query = [NSString stringWithFormat:@".//%@%@",isEmptyString(name) ? @"*" : name,[self getQueryStringByAttrs:attrs]];
    NSString *log = [NSString stringWithFormat:@"not find <%@ %@>",logNameForFindCanvas(name),logAttrsForFindCanvas(attrs)];
    return [self canvasWithQuery:query log:log];
}

- (NSArray <CanvasHTML *>*)findParentCanvasWithName:(NSString *)name attrs:(NSDictionary *)attrs {
    NSString *query = [NSString stringWithFormat:@"../../%@%@",isEmptyString(name) ? @"*" : name,[self getQueryStringByAttrs:attrs]];
    NSString *log = [NSString stringWithFormat:@"not find <%@ %@> in parent",logNameForFindCanvas(name),logAttrsForFindCanvas(attrs)];
    return [self canvasWithQuery:query log:log];
}

- (NSArray <CanvasHTML *>*)findSiblingCanvasWithName:(NSString *)name attrs:(NSDictionary *)attrs {
    NSString *query = [NSString stringWithFormat:@"../%@%@",isEmptyString(name) ? @"*" : name,[self getQueryStringByAttrs:attrs]];
    NSString *log = [NSString stringWithFormat:@"not find <%@ %@> in sibling",logNameForFindCanvas(name),logAttrsForFindCanvas(attrs)];
    return [self canvasWithQuery:query log:log];
}

- (NSArray <CanvasHTML *>*)findChildrenCanvasWithName:(NSString *)name attrs:(NSDictionary *)attrs {
    NSString *query = [NSString stringWithFormat:@"./%@%@",isEmptyString(name) ? @"*" : name,[self getQueryStringByAttrs:attrs]];
    NSString *log = [NSString stringWithFormat:@"not find <%@ %@> in children",logNameForFindCanvas(name),logAttrsForFindCanvas(attrs)];
    return [self canvasWithQuery:query log:log];
}


@end

