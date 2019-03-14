//
//  HoneViewController.m
//  Html_Hpple
//
//  Created by wangan on 13-4-12.
//  Copyright (c) 2013年 com.wangan. All rights reserved.
//

#import "HomeViewController.h"
#import "TFHpple.h"
#import "ExpatiationViewController.h"


#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>

#import "CanvasHTML.h"


@interface HomeViewController () <UIWebViewDelegate>

@end

@implementation HomeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title=@"我要跳槽";
    }
    return self;
}

- (void)test3 {
    const char inp[] =
    "<html>"
    "<head><title>Test</title></head>"
    "<body id = 'ida'>"
    "<div id = 'id1' class = 'class1'>"
    "<a id = 'aid' class = 'aclass' href = 'ahref'>这是第一条语句</a>"
    "<a class = 'aclass'>这是第二条语句</a>"
    "<a>这是第三条语句</a>"
    "<a>这是第四条语句</a>"
    "<p id = 'aid' class = 'aclass' href = 'ahref'>这是第五条语句</p>"
    "</div>"
    
    "<div id = 'id2' class = 'class2'>"
    "<div class = 'b'>"
    "<div>"
    "<p>html解析模块</p>"
    "</div>"
    "</div>"
    "<div class = 'a'>"
    "<p>html解析模块</p>"
    "</div>"
    "</div>"
    
    "<div id = 'id3' class = 'class3'>"
    "<a>这是第五条语句</a>"
    "</div>"
    "<div class = 'class3'>"
    "<a>这是第六条语句</a>"
    "</div>"
    
    "</body>"
    "</html>";
    
    
     xmlDoc *doc = xmlParseMemory(inp, sizeof(inp)-1);
     xmlXPathContext *ctx = xmlXPathNewContext(doc);
     xmlXPathObject *a = xmlXPathEval(BAD_CAST "html", ctx);
     xmlXPathObject *b = xmlXPathEval(BAD_CAST "/html", ctx);
     xmlXPathObject *c = xmlXPathEval(BAD_CAST "/html/head", ctx);
     xmlXPathObject *d = xmlXPathEval(BAD_CAST "//a", ctx);
     xmlXPathObject *e = xmlXPathEval(BAD_CAST "/html//a", ctx);
     xmlXPathObject *f0 = xmlXPathEval(BAD_CAST "/html/body/div/@class", ctx);
     xmlXPathObject *f = xmlXPathEval(BAD_CAST "//@class", ctx);
     xmlXPathObject *z2 = xmlXPathEval(BAD_CAST "div/p", ctx);// 根路径无法使用相对路径
     xmlXPathObject *r0 = xmlXPathEval(BAD_CAST ".", ctx);// 根路径无法使用相对路径
     xmlXPathObject *r1 = xmlXPathEval(BAD_CAST "/.", ctx);// 根路径无法使用相对路径
     
     // 查找ctx中第一个节点
     xmlXPathObject *r2 = xmlXPathEval(BAD_CAST "/*", ctx);
     xmlXPathObject *r3 = xmlXPathEval(BAD_CAST "//*", ctx);
     xmlXPathObject *r4 = xmlXPathEval(BAD_CAST "/*", ctx);
     xmlXPathObject *r5 = xmlXPathEval(BAD_CAST "*", ctx);
     xmlXPathObject *r6 = xmlXPathEvalExpression(BAD_CAST "*", ctx);
     
     xmlXPathObject *g = xmlXPathEval(BAD_CAST "/html/body/div[1]", ctx);
     
     xmlNode *new_root = *g->nodesetval->nodeTab;
     printf("New root: %s\n", BAD_CAST new_root->name);
     
     xmlXPathObject *q = xmlXPathNodeEval(new_root, BAD_CAST "./a[1]", ctx);
     xmlXPathObject *r = xmlXPathNodeEval(new_root, BAD_CAST ".", ctx);
     xmlXPathObject *s = xmlXPathNodeEval(new_root, BAD_CAST "..", ctx);
     xmlXPathObject *t = xmlXPathNodeEval(new_root, BAD_CAST "child::div", ctx);
     xmlXPathObject *u = xmlXPathNodeEval(new_root, BAD_CAST "attribute::id", ctx);
     xmlXPathObject *v = xmlXPathNodeEval(new_root, BAD_CAST "child::*", ctx);
     xmlXPathObject *v0 = xmlXPathNodeEval(new_root, BAD_CAST "child::*[last()]", ctx);
     xmlXPathObject *w = xmlXPathNodeEval(new_root, BAD_CAST "attribute::*", ctx);
     xmlXPathObject *x = xmlXPathNodeEval(new_root, BAD_CAST "child::node()", ctx);
     xmlXPathObject *y = xmlXPathNodeEval(new_root, BAD_CAST "ancestor::body", ctx);
     xmlXPathObject *z = xmlXPathNodeEval(new_root, BAD_CAST "div//div", ctx);// 相对路径是偏向于末节点的，比如有三个嵌套的div，当使用“”
     xmlXPathObject *z1 = xmlXPathNodeEval(new_root, BAD_CAST ".//div", ctx);
     xmlXPathObject *z0 = xmlXPathNodeEval(new_root, BAD_CAST "div/div", ctx);
     
     // 选取特定属性的特定标签，  除‘//@x’是查找全局的x属性以外，其他
    // "//@x":查找范围是节点及节点的所有子孙节点
    // "/@x":查找范围是当前节点
    // "//@x"或"/@x"前面的语句是查找的节点对象，不是路径。譬如‘../../@x’，'/@x'前面是‘../..’，是一个无效的节点，所以没有结果，改成‘./../*/@x’就有了
     xmlXPathObject *aa = xmlXPathNodeEval(new_root, BAD_CAST "./a[@class='aclass']", ctx);
     xmlXPathObject *aa0 = xmlXPathNodeEval(new_root, BAD_CAST "./a[@id='aid'][@class ='aclass']", ctx);
     xmlXPathObject *aa1 = xmlXPathNodeEval(new_root, BAD_CAST "//@id", ctx);
     
     xmlXPathObject *aa2 = xmlXPathNodeEval(new_root, BAD_CAST "./@id", ctx);
    xmlXPathObject *aa8 = xmlXPathNodeEval(new_root, BAD_CAST ".//@id", ctx);
     xmlXPathObject *aa3 = xmlXPathNodeEval(new_root, BAD_CAST "../@id", ctx);
     xmlXPathObject *aa4 = xmlXPathNodeEval(new_root, BAD_CAST "child::*//@id", ctx);
    xmlXPathObject *aa5 = xmlXPathNodeEval(new_root, BAD_CAST "child::*/@id", ctx);
    xmlXPathObject *aa6 = xmlXPathNodeEval(new_root, BAD_CAST "./*//@id", ctx);
    xmlXPathObject *aa7 = xmlXPathNodeEval(new_root, BAD_CAST "./*/@id", ctx);
     // 父标签
     xmlNodePtr qroot = *q->nodesetval->nodeTab;
     xmlXPathObject *bb = xmlXPathNodeEval(qroot, BAD_CAST "../../*", ctx);
     
     for (int i = 0; i<q->nodesetval->nodeNr; ++i) {
     const xmlChar *cnt = xmlNodeGetContent(q->nodesetval->nodeTab[i]);
     printf("%s ", BAD_CAST cnt);
     xmlFree((xmlChar*)cnt);
     }
     puts("");
     
     xmlXPathFreeObject(a);
     xmlXPathFreeObject(b);
     xmlXPathFreeObject(c);
     xmlXPathFreeObject(d);
     xmlXPathFreeObject(e);
     xmlXPathFreeObject(f);
     xmlXPathFreeObject(g);
     xmlXPathFreeObject(q);
     xmlXPathFreeObject(s);
     xmlXPathFreeObject(r);
     xmlXPathFreeObject(t);
     xmlXPathFreeObject(u);
     xmlXPathFreeObject(v);
     xmlXPathFreeObject(w);
     xmlXPathFreeObject(x);
     xmlXPathFreeObject(y);
     xmlXPathFreeContext(ctx);
     xmlFreeDoc(doc);
}

- (void)test2 {
    const char inp[] =
    "<html>"
        "<head><title>Test</title></head>"
        "<body>"
            "<div id = 'id1' class = 'class1'>"
                "<a id = 'aid' class = 'aclass' href = 'ahref'>这是第一条语句</a>"
                "<a class = 'aclass'>这是第二条语句</a>"
                "<a id = 'abid' class = 'aclass' href = 'ahref'>这是第三条语句</a>"
                "<a>这是第四条语句</a>"
                "<p id = 'aaid' class = 'aclass' href = 'ahref'>这是第五条语句</p>"
            "</div>"
    
            "<div id = 'id2' class = 'class2'>"
                "<div class = 'class3'>"
                    "<div>"
                        "<p>html解析模块</p>"
                    "</div>"
                "</div>"
                "<div class = 'a'>"
                    "<p>html解析模块</p>"
                "</div>"
            "</div>"
    
            "<div id = 'id3' class = 'class3'>"
                "<a>这是第五条语句</a>"
            "</div>"
            "<div class = 'class3'>"
                "<a>这是第六条语句</a>"
            "</div>"
    
        "</body>"
    "</html>";
    /** Ralationship **/
    // html
    NSString *code = [[NSString alloc] initWithUTF8String:inp];
    CanvasHTML *html = [[CanvasHTML alloc] initWithCode:code];
    NSLog(@"%@%@", html.string,html.name);
    
    // head
    CanvasHTML *head = html.firstChildren;
    CanvasHTML *title3 = html.firstChildren;
    CanvasHTML *title0 = html.lastChildren;
    CanvasHTML *title1 = html.firstChildren;
    CanvasHTML *title2 = html.childrens[0];
    
    CanvasHTML *html0 = head.parent;
    CanvasHTML *html1 = head.parents[0];
    
    // body
    CanvasHTML *body = html.lastChildren;
    
    // div
    CanvasHTML *div = body.firstChildren;
    CanvasHTML *diva = div.nextSibling;
    CanvasHTML *divb = diva.prevSibling;
    
    // a
    CanvasHTML *a = div.childrens[0];
    NSArray *aNextArr = a.nextSiblings;
    
    CanvasHTML *lastA = div.lastChildren;
    NSArray *aPreArr = lastA.prevSiblings;
    
    
    NSArray *descendants = a.descendants;
    
    
    // ancestors
    NSArray *ancestors0 = body.ancestors;
    NSArray *ancestors1 = a.ancestors;
    
    // descendants
    NSArray *descendants0 = body.descendants;
    NSArray *descendants1 = a.descendants;
    
    /** Property **/
    NSString *t = title3.string;
    NSString *title = title0.string;
    NSString *name = title0.name;
    NSDictionary *attrs = div.attrs;
    NSString *str0 = a.string;
    NSArray *values0 = [div findValuesWithKey:@"id"];
    NSArray *values1 = [html findValuesWithKey:@"id"];
    NSArray *values2 = [a findValuesInParentWithKey:@"id"];
    NSArray *values3 = [a findValuesInSiblingWithKey:@"id"];
    NSArray *values4 = [div findValuesInChildrenWithKey:@"id"];
    NSArray *values5 = [html findValuesWithKey:@"id" tagName:@"a" tagAttrs:@{@"href":@"ahref"}];
    
    /** Tag **/
    NSArray *tags = div.as;
    NSArray *tags0 = body.divs;
    NSArray *canvas0 = [html findCanvasWithName:@"div" attrs:@{@"id":@"id1"}];
    NSArray *canvas1 = [a findParentCanvasWithName:@"div" attrs:@{@"class":@"class3"}];//???
    NSArray *canvas2 = [a findSiblingCanvasWithName:@"p" attrs:nil];
    NSArray *canvas3 = [div findChildrenCanvasWithName:@"a" attrs:nil];
    NSArray *canvas4 = [div findChildrenCanvasWithName:nil attrs:@{@"class":@"aclass"}];
    
    
//    CanvasHTML *canvaa = [[CanvasHTML alloc] initWithURL:@"http://deerchao.net/tutorials/regex/regex.htm"];
    /*
    xmlDoc *doc = xmlParseMemory(inp, sizeof(inp)-1);
    xmlXPathContext *ctx = xmlXPathNewContext(doc);
    xmlXPathObject *a = xmlXPathEval(BAD_CAST "html", ctx);
    xmlXPathObject *b = xmlXPathEval(BAD_CAST "/html", ctx);
    xmlXPathObject *c = xmlXPathEval(BAD_CAST "/html/head", ctx);
    xmlXPathObject *d = xmlXPathEval(BAD_CAST "//a", ctx);
    xmlXPathObject *e = xmlXPathEval(BAD_CAST "/html//a", ctx);
    xmlXPathObject *f0 = xmlXPathEval(BAD_CAST "/html/body/div/@class", ctx);
    xmlXPathObject *f = xmlXPathEval(BAD_CAST "//@class", ctx);
    xmlXPathObject *z2 = xmlXPathEval(BAD_CAST "div/p", ctx);// 根路径无法使用相对路径
    xmlXPathObject *r0 = xmlXPathEval(BAD_CAST ".", ctx);// 根路径无法使用相对路径
    xmlXPathObject *r1 = xmlXPathEval(BAD_CAST "/.", ctx);// 根路径无法使用相对路径
    
    // 查找ctx中第一个节点
    xmlXPathObject *r2 = xmlXPathEval(BAD_CAST "/*", ctx);
    xmlXPathObject *r3 = xmlXPathEval(BAD_CAST "//*", ctx);
    xmlXPathObject *r4 = xmlXPathEval(BAD_CAST "/*", ctx);
    xmlXPathObject *r5 = xmlXPathEval(BAD_CAST "*", ctx);
    xmlXPathObject *r6 = xmlXPathEvalExpression(BAD_CAST "*", ctx);
    
    xmlXPathObject *g = xmlXPathEval(BAD_CAST "/html/body/div[1]", ctx);
    
    xmlNode *new_root = *g->nodesetval->nodeTab;
    printf("New root: %s\n", BAD_CAST new_root->name);
    
    xmlXPathObject *q = xmlXPathNodeEval(new_root, BAD_CAST "./a[1]", ctx);
    xmlXPathObject *r = xmlXPathNodeEval(new_root, BAD_CAST ".", ctx);
    xmlXPathObject *s = xmlXPathNodeEval(new_root, BAD_CAST "..", ctx);
    xmlXPathObject *t = xmlXPathNodeEval(new_root, BAD_CAST "child::div", ctx);
    xmlXPathObject *u = xmlXPathNodeEval(new_root, BAD_CAST "attribute::id", ctx);
    xmlXPathObject *v = xmlXPathNodeEval(new_root, BAD_CAST "child::*", ctx);
    xmlXPathObject *v0 = xmlXPathNodeEval(new_root, BAD_CAST "child::*[last()]", ctx);
    xmlXPathObject *w = xmlXPathNodeEval(new_root, BAD_CAST "attribute::*", ctx);
    xmlXPathObject *x = xmlXPathNodeEval(new_root, BAD_CAST "child::node()", ctx);
    xmlXPathObject *y = xmlXPathNodeEval(new_root, BAD_CAST "ancestor::body", ctx);
    xmlXPathObject *z = xmlXPathNodeEval(new_root, BAD_CAST "div//div", ctx);// 相对路径是偏向于末节点的，比如有三个嵌套的div，当使用“”
    xmlXPathObject *z1 = xmlXPathNodeEval(new_root, BAD_CAST ".//div", ctx);
    xmlXPathObject *z0 = xmlXPathNodeEval(new_root, BAD_CAST "div/div", ctx);
    
    // 选取特定属性的特定标签，只能从ctx找，不能独立从子节点的子孙节点找
    xmlXPathObject *aa = xmlXPathNodeEval(new_root, BAD_CAST "./a[@class='aclass']", ctx);
    xmlXPathObject *aa0 = xmlXPathNodeEval(new_root, BAD_CAST "./a[@id='aid'][@class ='aclass']", ctx);
    xmlXPathObject *aa1 = xmlXPathNodeEval(new_root, BAD_CAST "//@id", ctx);
    xmlXPathSetContextNode(new_root, ctx);
    xmlXPathObject *aa2 = xmlXPathNodeEval(new_root, BAD_CAST "/@id", ctx);
    xmlXPathObject *aa3 = xmlXPathNodeEval(new_root, BAD_CAST "../@id", ctx);
    // 父标签
    xmlNodePtr qroot = *q->nodesetval->nodeTab;
    xmlXPathObject *bb = xmlXPathNodeEval(qroot, BAD_CAST "../../*", ctx);
    
    for (int i = 0; i<q->nodesetval->nodeNr; ++i) {
        const xmlChar *cnt = xmlNodeGetContent(q->nodesetval->nodeTab[i]);
        printf("%s ", BAD_CAST cnt);
        xmlFree((xmlChar*)cnt);
    }
    puts("");
    
    xmlXPathFreeObject(a);
    xmlXPathFreeObject(b);
    xmlXPathFreeObject(c);
    xmlXPathFreeObject(d);
    xmlXPathFreeObject(e);
    xmlXPathFreeObject(f);
    xmlXPathFreeObject(g);
    xmlXPathFreeObject(q);
    xmlXPathFreeObject(s);
    xmlXPathFreeObject(r);
    xmlXPathFreeObject(t);
    xmlXPathFreeObject(u);
    xmlXPathFreeObject(v);
    xmlXPathFreeObject(w);
    xmlXPathFreeObject(x);
    xmlXPathFreeObject(y);
    xmlXPathFreeContext(ctx);
    xmlFreeDoc(doc);*/
}

- (void)test {
    const char inp[] =
    "<root>\n"
    " <sub>\n"
    "  <e>0</e>\n"
    "  <Foo>\n"
    "    <e>1</e><e>2</e><e class = 'abcd'>3</e>\n"
    "    <FooSub><e id = 'b' class = 'abcd ada'>3a</e></FooSub>\n"
    "  </Foo>\n"
    "  <Bar>\n"
    "    <e>4</e><e>5</e><e  class = 'abcd'>6</e>\n"
    "  </Bar>\n"
    " </sub>\n"
    " <e>7</e>\n"
    "</root>\n";
    
    
    xmlDoc *doc = xmlParseMemory(inp, sizeof(inp)-1);
    xmlXPathContext *ctx = xmlXPathNewContext(doc);
    xmlXPathObject *p = xmlXPathEval(BAD_CAST "//Foo[1]", ctx);
    xmlXPathObject *a = xmlXPathEval(BAD_CAST "/root/sub[1]", ctx);
    
    xmlXPathObject *b = xmlXPathEval(BAD_CAST "/root//e", ctx);
    xmlXPathObject *c = xmlXPathEval(BAD_CAST "/foo//e", ctx);
    
    xmlXPathObject *d = xmlXPathEval(BAD_CAST "/root/*", ctx);
    
    xmlXPathObject *e = xmlXPathEval(BAD_CAST "//e[@class]", ctx);
    xmlXPathObject *f = xmlXPathEval(BAD_CAST "//e[@class = \"abcd\"]", ctx);
    
    
    xmlNode *new_root = *p->nodesetval->nodeTab;
    printf("New root: %s\n", BAD_CAST new_root->name);
    xmlXPathObject *q = xmlXPathNodeEval(new_root, BAD_CAST "//e", ctx);
    
    for (int i = 0; i<q->nodesetval->nodeNr; ++i) {
        const xmlChar *cnt = xmlNodeGetContent(q->nodesetval->nodeTab[i]);
        printf("%s ", BAD_CAST cnt);
        xmlFree((xmlChar*)cnt);
    }
    puts("");
    
    xmlXPathFreeObject(q);
    xmlXPathFreeObject(p);
    xmlXPathFreeContext(ctx);
    xmlFreeDoc(doc);
}

- (void)test1 {
    
    NSString *str=[NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://baike.baidu.com/link?url=d86ymhjaa1pzT4mHJLx7ha9jTgi89IfnJeFQLp1xBzLhrtD9GtbeXiIKseag18G3vNJk_fz_xN2y6wfCZYbuEq"] encoding:NSUTF8StringEncoding error:nil];
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
    
    xmlDoc *doc = htmlReadMemory([data bytes], (int)[data length], "", NULL, HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);
    xmlXPathContext *ctx = xmlXPathNewContext(doc);
    /*xmlXPathObject *p = xmlXPathEval(BAD_CAST "Foo[1]", ctx);
    xmlXPathObject *a = xmlXPathEval(BAD_CAST "/root/sub[1]", ctx);
    
    xmlXPathObject *b = xmlXPathEval(BAD_CAST "/roote", ctx);
    xmlXPathObject *c = xmlXPathEval(BAD_CAST "/fooe", ctx);
    
    xmlXPathObject *d = xmlXPathEval(BAD_CAST "/root/*", ctx);
    
    xmlXPathObject *e = xmlXPathEval(BAD_CAST "e[@class]", ctx);*/
    xmlXPathObject *f = xmlXPathEval(BAD_CAST "//div[@class='s_form_wrapper soutu-env-mac soutu-env-newindex']", ctx);
    
    xmlNode *new_root = *f->nodesetval->nodeTab;
    printf("New root: %s\n", BAD_CAST new_root->name);
    xmlXPathObject *q = xmlXPathNodeEval(new_root, BAD_CAST "e", ctx);
    
    for (int i = 0; i<q->nodesetval->nodeNr; ++i) {
        const xmlChar *cnt = xmlNodeGetContent(q->nodesetval->nodeTab[i]);
        printf("%s ", BAD_CAST cnt);
        xmlFree((xmlChar*)cnt);
    }
    puts("");
    
    xmlXPathFreeObject(q);
    xmlXPathFreeObject(f);
    xmlXPathFreeContext(ctx);
    xmlFreeDoc(doc);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self initData];
    /*[self AnalyticalCont:@"http://www.lomowo.com/posts/47632"];
    [self AnalyticalImage:@"http://www.lomowo.com/posts/47632"];
    [self AnalyticalTitle:@"http://www.lomowo.com/posts/47632"];*/

    
    _array=[[NSArray alloc]init];
    _array=@[@"http://www.lomowo.com/posts/47689",
             @"http://www.lomowo.com/posts/47632",
             @"http://www.lomowo.com/posts/47605",
             @"http://www.lomowo.com/posts/47682",
             @"http://www.lomowo.com/posts/47688",
             @"http://www.lomowo.com/posts/47732",
             @"http://www.lomowo.com/posts/64"
            /*@ @"http://www.lomowo.com/posts/333",
             @"http://www.lomowo.com/posts/318",
             "http://www.lomowo.com/posts/17541",
             @"http://www.lomowo.com/posts/17699",
             @"http://www.lomowo.com/posts/40377",
             @"http://www.lomowo.com/posts/17735",
             @"http://www.lomowo.com/posts/17710",
             @"http://www.lomowo.com/posts/17690",
             @"http://www.lomowo.com/posts/17688"
             "",
             @"",
             @"",
             @"",
             @"",
             @"",
             @"",
             @""*/];
    
    /*[self test];
    [self test1];*/
    [self test2];
    [self test3];
    
}

//- (void)test {
//    NSString *imageStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.baidu.com"] encoding:NSUTF8StringEncoding error:nil];
//    
//    NSData *htmlData=[imageStr dataUsingEncoding:NSUTF8StringEncoding];
//    
//    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
//    NSArray *elements  = [xpathParser searchWithXPathQuery:@"//a[@href]"];
////    NSArray *a  = [xpathParser searchWithXPathQuery:@"//a"];
////    NSArray *b  = [xpathParser searchWithXPathQuery:@"//@type"];
////    NSArray *c  = [xpathParser searchWithXPathQuery:@"//div[@id='s_is_index_css']"];
////    NSArray *d  = [xpathParser searchWithXPathQuery:@"div//div"];
//    
//}

#pragma 初始数据
-(void)initData{
    
    
}


#pragma  title
-(NSArray *)AnalyticalTitle:(NSString *)urlString{
    
    //self.titleArray=[[NSMutableArray alloc]initWithCoder:0];
    
    NSString *title=[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding/*CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)*/error:nil];
    
    //NSLog(@"title%@",title);
    
    NSRange range=[title rangeOfString:@"<title>"];
    
    NSMutableString *needTidyString=[NSMutableString stringWithString:[title substringFromIndex:range.location+range.length]];
    
    //NSLog(@"%@",needTidyString);
    
    NSRange rang2=[needTidyString rangeOfString:@"- 微秀"];
    
    NSMutableString *html2=[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];
    //NSLog(@"%@",html2);
    
    _titleArray=[[NSMutableArray alloc]init];
    
    [_titleArray addObject:html2];

    return _titleArray;
    
    
}

#pragma image
-(NSMutableArray *)AnalyticalImage:(NSString *)htmlString;{

    NSString *imageStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    
    NSRange rang1=[imageStr rangeOfString:@"<div class=\"content\">"];
    NSMutableString *imageStr2=[[NSMutableString alloc]initWithString:[imageStr substringFromIndex:rang1.location+rang1.length]];
    
    NSRange rang2=[imageStr2 rangeOfString:@"<div class=\"clear\">"];
    NSMutableString *imageStr3=[[NSMutableString alloc]initWithString:[imageStr2 substringToIndex:rang2.location]];
    
    //NSLog(@"%@",imageStr3);
    
    NSData *dataTitle=[imageStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//img"];
    
    
    _imageArray=[[NSMutableArray alloc]init];
    
    
    for (TFHppleElement *element in elements) {
        
        NSDictionary *elementContent =[element attributes];
        
       // NSLog(@"%@",[elementContent objectForKey:@"src"]);
        
        [_imageArray addObject:[elementContent objectForKey:@"src"]];
    }
    
    return _imageArray;
    
}

#pragma cont
-(NSMutableArray *)AnalyticalCont:(NSString *)htmlString{
    
    NSString *imageStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    
    NSRange rang1=[imageStr rangeOfString:@"<p>"];
    NSMutableString *imageStr2=[[NSMutableString alloc]initWithString:[imageStr substringFromIndex:rang1.location]];
    
    NSRange rang2=[imageStr2 rangeOfString:@"<div class=\"clear\"></div>"];
    NSMutableString *imageStr3=[[NSMutableString alloc]initWithString:[imageStr2 substringToIndex:rang2.location]];
    
    //NSLog(@"%@",imageStr3);
    
    NSData *htmlData=[imageStr3 dataUsingEncoding:/*CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)*/NSUTF8StringEncoding];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    NSArray *elements  = [xpathParser searchWithXPathQuery:@"//p"];
    
    //NSLog(@"%@",elements);
    
    _contArray=[[NSMutableArray alloc]init];
    
    for (TFHppleElement *element in elements) {
            
           if ([element content]!=nil) {
                
               // NSLog(@"%@",[element content]);
               
               [_contArray addObject:[element content]];
                
           }
        
    }
    
    return _contArray;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return[_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (_imageArray ==nil) {
        
        
        [self AnalyticalImage:[_array objectAtIndex:indexPath.row]];
        [self AnalyticalTitle:[_array objectAtIndex:indexPath.row]];
        
    }else{
        
        [_imageArray removeAllObjects];
        [_titleArray removeAllObjects];
        
        [self AnalyticalImage:[_array objectAtIndex:indexPath.row]];
        [self AnalyticalTitle:[_array objectAtIndex:indexPath.row]];
    }

    
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5.0f, 5.0f, 100.0f, 45.0f)];
    
        
        imageView.image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_imageArray objectAtIndex:0]]]];
        
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(130.0f, 5.0f, 180.0f, 40.0f)];
        lab.numberOfLines=0;
        lab.text=[_titleArray objectAtIndex:0];
        [lab setTextColor:[UIColor purpleColor]];
        
        
        [cell.contentView addSubview:imageView];
        [cell.contentView addSubview:lab];
      
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return 60;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ExpatiationViewController  *detailViewController = [[ExpatiationViewController alloc] init];
    
    
    [self.navigationController pushViewController:detailViewController animated:YES];

     
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *lHtml1 = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
}

@end
