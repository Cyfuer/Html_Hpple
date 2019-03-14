//
//  CanvasNode.m
//  Html_Hpple
//
//  Created by iflashbuy_dev on 2016/12/2.
//  Copyright © 2016年 com.wangan. All rights reserved.
//

#import "CanvasNode.h"

xmlXPathContextPtr context(NSString *content) {
    // string
    if ([content isEqual:[NSNull null]] || content == nil || ![content isKindOfClass:[NSString class]] || content.length == 0) {
        NSLog(@"CanvasHTML: parse fail. content of html is none.");
        return nil;
    }
    
    // data
    NSData *data=[content dataUsingEncoding:NSUTF8StringEncoding];
    
    // xml document
    xmlDoc *doc = htmlReadMemory([data bytes], (int)[data length], "", NULL, HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);
    if (doc == NULL) {
        NSLog(@"CanvasHTML: parse fail. html is illegal.");
        return nil;
    }
    
    // xmlXPathContext
    xmlXPathContextPtr ctx = xmlXPathNewContext(doc);
    if (ctx == NULL) {
        NSLog(@"CanvasHTML: parse fail. create XPath context fail.");
        xmlXPathFreeContext(ctx);
        return nil;
    }
    
    return ctx;
}

xmlXPathContextPtr contextByUrl(NSString *url) {
    // string
    NSString *str=[NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];
    
    return context(str);
}


xmlXPathContextPtr contextByCode(NSString *code) {
    return context(code);
}


xmlNodePtr rootNode(xmlXPathContextPtr ctx) {
    // xmlXPathObject
    xmlXPathObject *obj = xmlXPathEval(BAD_CAST "/*", ctx);
    if(obj == NULL) {
        NSLog(@"CanvasHTML: parse fail. evaluate XPath fail.");
        xmlXPathFreeObject(obj);
        return nil;
    }
    
    // xmlNodeSet
    xmlNodeSetPtr nodes = obj->nodesetval;
    if (!nodes || nodes->nodeNr == 0) {
        NSLog(@"CanvasHTML: parse fail. Nodes is nil.");
        xmlXPathFreeObject(obj);
        return nil;
    }
    
    
    return obj->nodesetval->nodeTab[0];
}

NSString *nodeString(xmlNodePtr xmlNode) {
    const xmlChar *cnt = xmlNodeGetContent(xmlNode);
    if (cnt && cnt != (xmlChar *)-1) {
        NSString *string = [NSString stringWithCString:(const char *)cnt encoding:NSUTF8StringEncoding];
        xmlFree((xmlChar*)cnt);
        return string;
    } else {
        xmlFree((xmlChar*)cnt);
        return @"";
    }
}
NSString *nodeName(xmlNodePtr xmlNode) {
    if (xmlNode->name) {
        NSString *name =
        [NSString stringWithCString:(const char *)xmlNode->name encoding:NSUTF8StringEncoding];
        return name;
    } else {
        return @"";
    }
}
NSDictionary *nodeAttrs(xmlNodePtr xmlNode) {
    xmlAttrPtr attribute = xmlNode->properties;
    if (attribute) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        while (attribute) {
            
            // key
            NSString *key;
            if (attribute->name) {
                key =
                [NSString stringWithCString:(const char *)attribute->name encoding:NSUTF8StringEncoding];
            }
            
            // value
            NSString *value;
            if (attribute->children)
            {
                xmlNodePtr valueNode = attribute->children;// ???
                NSString *valueNodeName =
                [NSString stringWithCString:(const char *)valueNode->name encoding:NSUTF8StringEncoding];
                if ([valueNodeName isEqualToString:@"text"]) {
                    value =
                    [NSString stringWithCString:(const char *)valueNode->content encoding:NSUTF8StringEncoding];
                }
            }
            
            if (key && value) {
                [dict setObject:value forKey:key];
            }
            
            attribute = attribute->next;
        }
        
        return (NSDictionary *)dict;
    } else {
        return nil;
    }
}

NSArray *attrValues(xmlNodeSetPtr xmlNodeSet, NSString *log) {
    if (!xmlNodeSet)
    {
        NSLog(@"CanvasHTML: parse fail. %@.",log);
        return nil;
    }
    
    
    NSMutableArray *values = [NSMutableArray array];
    for (NSInteger i = 0; i < xmlNodeSet->nodeNr; i++) {
        xmlNodePtr node = xmlNodeSet->nodeTab[i];
        NSString *value;
        if (node->children)
        {
            xmlNodePtr valueNode = node->children;// ???
            NSString *valueNodeName =
            [NSString stringWithCString:(const char *)valueNode->name encoding:NSUTF8StringEncoding];
            if ([valueNodeName isEqualToString:@"text"]) {
                value =
                [NSString stringWithCString:(const char *)valueNode->content encoding:NSUTF8StringEncoding];
            }
        }
        
        if (value && value.length) {
            [values addObject:value];
        }
    }
    
    return values;
}

xmlNodeSetPtr nodes(xmlNodePtr node,xmlXPathContextPtr ctx, NSString *query, NSString *log) {
    xmlXPathObjectPtr xmlXPathObj = xmlXPathNodeEval(node, BAD_CAST [query cStringUsingEncoding:NSUTF8StringEncoding], ctx);
    if(xmlXPathObj == NULL) {
        NSLog(@"CanvasHTML: parse fail. %@.",log);
        xmlXPathFreeObject(xmlXPathObj);
        return nil;
    }
    
    xmlNodeSetPtr nodes = xmlXPathObj->nodesetval;
    if (!nodes || nodes->nodeNr == 0) {
        NSLog(@"CanvasHTML: parse fail. %@.",log);
        xmlXPathFreeObject(xmlXPathObj);
        return nil;
    }
    
    return nodes;
}

xmlNodePtr node(xmlNodePtr node,xmlXPathContextPtr ctx, NSString *query, NSString *log) {
    xmlXPathObjectPtr xmlXPathObj = xmlXPathNodeEval(node, BAD_CAST [query cStringUsingEncoding:NSUTF8StringEncoding], ctx);
    if(xmlXPathObj == NULL) {
        NSLog(@"CanvasHTML: parse fail. %@.",log);
        xmlXPathFreeObject(xmlXPathObj);
        return nil;
    }
    
    xmlNodeSetPtr nodes = xmlXPathObj->nodesetval;
    if (!nodes || nodes->nodeNr == 0) {
        NSLog(@"CanvasHTML: parse fail. %@.",log);
        xmlXPathFreeObject(xmlXPathObj);
        return nil;
    }
    
    return nodes->nodeTab[0];
}
