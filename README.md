# Html_Hpple
网页解析工具，iOS版的beautifulsoup

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
