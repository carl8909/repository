# iOS开发规范  #


## 摘要

* [1 前言](#1-前言)
* [2 命名规范](#2-命名规范)
* [3 编码规范](#3-编码规范)

---------------------------------------

### 1 前言 ###

**为了有利于项目维护、增强代码可读性、提升 Code Review 效率以及规范团队iOS开发，故提出以下iOS开发规范**

---------------------------------------



### 2 命名规范 ###

**根据Cocoa编码规范里的描述，命名应该遵循以下基本原则：Clarity、Consistency、No Self Reference，即清晰性、一致性、不要自我指涉。**


#### 2.1 通用命名规范 ####
通用命名规则适用于类名、变量、常量、属性、参数、方法、函数等。(重名除外)

>1. 【统一要求】
>>1.   尽量做到不需要注释也能了解其作用，若做不到，就加注释，使用全称，不使用缩写。
>
>2. 【类名】
>>1.   大驼峰式命名：每个单词的首字母都采用大写字母。
>> 
| 命名                         | 说明                                     |
| :-------------------------- | ---------------------------------------- |
| `KFHomePageViewController `       |  |
>> 
>3. 【私有变量】私有变量放在 .m 文件中声明，以 _ 开头，第一个单词首字母小写，后面的单词的首字母全部大写。
>>   
| 命名                         | 说明                                     |
| :-------------------------- | ---------------------------------------- |
| `NSString *_somePrivateVariabl `       |  |
>> 
>4. 【全局变量】
>>1.   小驼峰式命名：第一个单词以小写字母开始，后面的单词的首字母全部大写。
>>2.   属性的关键字推荐按照 原子性，读写，内存管理的顺序排列。
>>3.   Block、NSString属性应该使用copy关键字
>>4.   禁止使用synthesize关键词 
>> 
| 命名                         | 说明                                     |
| :-------------------------- | ---------------------------------------- |
| `@property (nonatomic, readwrite, strong) UIView *headerView; //注释 `       |  |
>> 
5. 【宏、常量】
>>1.  预处理定义的常量全部大写，单词间用 _ 分隔
>>2.  宏定义中如果包含表达式或变量，表达式或变量必须用小括号括起来。
>>3.  对于局限于某编译单元(实现文件)的常量，以字符k开头，例如kAnimationDuration，且需要以static const修饰
>>
| 命名                         | 说明                                     |
| :-------------------------- | ---------------------------------------- |
| `#define ANIMATION_DURATION    0.3`       | 宏定义的常量 |
| `static const NSTimeInterval kAnimationDuration = 0.3; `                 | 局部类型常量 |
| `extern NSString *const EOCViewClassStringConstant;`      | 外部可见类型常量 |

>6. 【枚举】
>>1.  Enum类型的命名与类的命名规则一致
>>2.  Enum中枚举内容的命名需要以该Enum类型名称开头。
>>3.  NS_ENUM定义通用枚举，NS_OPTIONS定义位移枚举  
>>
```objc
通用枚举
typedef NS_ENUM(NSInteger, UIViewAnimationTransition) { 
    UIViewAnimationTransitionNone, 
    UIViewAnimationTransitionFlipFromLeft, 
    UIViewAnimationTransitionFlipFromRight, 
    UIViewAnimationTransitionCurlUp, 
    UIViewAnimationTransitionCurlDown, 
}; 
```
```objc
位移枚举
typedef NS_OPTIONS(NSUInteger, NYTAdCategory) {
    NYTAdCategoryAutos      = 1 << 0,
    NYTAdCategoryJobs       = 1 << 1,
    NYTAdCategoryRealState  = 1 << 2,
    NYTAdCategoryTechnology = 1 << 3
}; 
```
>>
>7. 【方法】
>>1.  小驼峰式命名
>>2.  不要使用and来连接属性参数。
>>3.  方法实现时，如果参数过长，则令每个参数占用一行，以冒号对齐。
>>4.  一般方法不使用前缀命名，私有方法可以使用统一的前缀来分组和辨识。
>>5.  表示对象行为的方法、执行性的方法应该以动词开头。
>>6.  返回性的方法应该以返回的内容开头，但之前不要加get，除非是间接返回一个或多个值。  
>>
| 命名                         | 说明                                     |
| :-------------------------- | ---------------------------------------- |
| `- (int)runModalForDirectory:(NSString *)path file:(NSString *)name`       | 推荐 |
| `- (int)runModalForDirectory:(NSString *)path andFile:(NSString *)name`                 | 不推荐 |
>>
| 命名                         | 说明                                     |
| :-------------------------- | ---------------------------------------- |
| `- (NSSize) cellSize;`       | 推荐 |
| `- (NSSize) getCellSize;`                 | 不推荐 |
>>
| 命名                         | 说明                                     |
| :-------------------------- | ---------------------------------------- |
| `- (instancetype)arrayWithArray:(NSArray *)array`       | 返回性的方法  |
>>


#### 2.2 图片命名规范
>1.  以模块命名，单词间用 _ 分隔,根据模块层级，存放不同文件夹



#### 2.3 Category命名规范
>1. 【必须】category中不要声明属性和成员变量。
>2. 【必须】避免category中的方法覆盖系统方法。可以使用前缀来区分系统方法和category方法。但前缀不要仅仅使用下划线”_“。
>3. 【建议】如果一个类比较复杂，建议使用category的方式组织代码。具体可以参考UIView


#### 2.4 Notification命名规范
>1. 【建议】苹果爸爸说：如果一个类声明了delegate属性，通常情况下，这个类的delegate对象可以通过实现的delegate方法收到大部分通知消息。那么，这些通知的名称应该反映出对应的delegate方法。比如，application对象发送的NSApplicationDidBecomeActiveNotification通知和对应的applicationDidBecomeActive:消息。其实，这也算是命名的一致性要求。
>2. 【必须】notification的命名使用全局的NSString字符串进行标识。命名方式如下：
[Name of associated class] + [Did | Will] + [UniquePartOfName] + Notification 例如：

```objc
NSApplicationDidBecomeActiveNotification
NSWindowDidMiniaturizeNotification
NSTextViewDidChangeSelectionNotification
NSColorPanelColorDidChangeNotification
```

>3. 【必须】object通常是指发出notification的对象，如果在发送notification的同时要传递一些额外的信息，请使用userInfo，而不是object。
>4. 【必须】如果某个通知是为了告知外界某个事件"即将"发生或者"已经"发生，则请在通知名称中使用“will”或者“did”这样的助动词。例如：

```objc
UIKeyboardWillChangeFrameNotification;
UIKeyboardDidChangeFrameNotification;
```


#### 2.5 Exception命名规范
上面已经有一节介绍过通知的命名规范。异常和通知的命名遵循相似的规则，但又各有不同。
【必须】和Notification的命名规范一样，异常也是用全局的NSString字符串进行标识。命名方式如下：
[Prefix] + [UniquePartOfName] + Exception 
相当于异常由前缀、名称中能够标识异常唯一性的那部分、Exception。如下：

```objc
NSColorListIOException
NSColorListNotEditableException
NSDraggingException
NSFontUnavailableException
NSIllegalSelectorException
```

---------------------------------------

### 3 编码规范 ###

#### 3.1 Self 循环引用
我们在写 block 回调的时候, 特别是对于实例方法中调用, 很容易导致其循环引用。
我们在项目中需要引入一组强弱引用的宏定义. @weakify(self) 、@strongify(self)
我们在遇到需要修饰 Self 的时候直接使用这组宏来进行修饰即可。。

例如:
```
[JSDStartInfo getStartInfoSuccess:^{
   @weakify(self)
   [JSDCheckVersion checkWithPass:^{
       @strongify(self);
       [self reloadView];
   }];
}];
```

#### 3.2 Init方法规范
>1. 【必须】所有secondary 初始化方法都应该调用designated 初始化方法。
>2. 【必须】所有子类的designated初始化方法都要调用父类的designated初始化方法。使这种调用关系沿着类的继承体系形成一条链。
>3. 【必须】如果子类的designated初始化方法与超类的designated初始化方法不同，则子类应该覆写超类的designated初始化方法。（因为开发者很有可能直接调用超类的某个designated方法来初始化一个子类对象，这样也是合情合理的，但使用超类的方法初始化子类，可能会导致子类在初始化时缺失一些必要信息）。
>4. 【必须】如果超类的某个初始化方法不适用于子类，则子类应该覆写这个超类的方法，并在其中抛出异常。
>5. 【必须】禁止子类的designated初始化方法调用父类的secondary初始化方法。否则容易陷入方法调用死循环。如下：

```objc
// 超类
@interface ParentObject : NSObject

@end

 @implementation ParentObject

    //designated initializer    
    - (instancetype)initWithURL:(NSString*)url title:(NSString*)title {
        if (self = [super init]) {
            _url = [url copy];
            _title = [title copy];
        }
        return self;
    }
    //secondary initializer
    - (instancetype)initWithURL:(NSString*)url {
        return [self initWithURL:url title:nil];
    }

    @end

// 子类
@interface ChildObject : ParentObject

@end

    @implementation ChildObject
    //designated initializer
    - (instancetype)initWithURL:(NSString*)url title:(NSString*)title {
        //在designated intializer中调用 secondary initializer，错误的
        if (self = [super initWithURL:url]) {

        }
        return self;
    }
    @end

 @implementation ViewController
    - (void)viewDidLoad {
        [super viewDidLoad];
        // 这里会死循环
        ChildObject* child = [[ChildObject alloc] initWithURL:@"url" title:@"title"];
    }
    @end
```

>6. 【必须】另外禁止在init方法中使用self.xxx的方式访问属性。如果存在继承的情况下，很有可能导致崩溃。


#### 3.3 dealloc规范
>1. 【必须】不要忘记在dealloc方法中移除通知和KVO。
>2. 【建议】dealloc 方法应该放在实现文件的最上面，并且刚好在 @synthesize 和 @dynamic 语句的后面。在任何类中，init 都应该直接放在 dealloc 方法的下面。
>3. 【必须】在dealloc方法中，禁止将self作为参数传递出去，如果self被retain住，到下个runloop周期再释放，则会造成多次释放crash。如下：

```objc
-(void)dealloc{
    [self unsafeMethod:self];
    // 因为当前已经在self这个指针所指向的对象的销毁阶段，销毁self所指向的对象已经在所难免。如果在unsafeMethod:中把self放到了autorelease poll中，那么self会被retain住，计划下个runloop周期在进行销毁。但是dealloc运行结束后，self所指向的对象的内存空间就直接被回收了，但是self这个指针还没有销毁(即没有被置为nil)，导致self变成了一个名副其实的野指针。
    // 到了下一个runloop周期，因为self所指向的对象已经被销毁，会因为非法访问而造成crash问题。
}
```

>4. 【必须】和init方法一样，禁止在dealloc方法中使用self.xxx的方式访问属性。如果存在继承的情况下，很有可能导致崩溃

#### 3.4 Block规范
>1. 【必须】调用block时需要对block判空。
>2. 【必须】注意block潜在的引用循环。

#### 3.5 Notification规范
前面在命名规范一章中已经介绍了通知的命名规范，这里解释的是通知的使用规范。
通知作为观察者模式的一个落地产物，在开发中能够实现一对多的通信。所有可以使用delegate和block实现的通信和传值，都可以使用通知实现。正因通知如此灵活，我们更应该弄清楚通知适合使用的场景，避免把通知和delegate以及block等进行混淆。
通知是一把双刃剑，让你欢喜让你忧。开发中，当你走投无路将要崩溃时，可以考虑使用通知；而当你频繁使用通知时，同样会让你崩溃到走投无路。所以，在每个应用中，我们应该时刻留意并控制通知的数量，避免通知满天飞的现象。
>1. 【必须】基于以上的陈述，当我们使用通知时，必须要思考，有没有更好的办法来代替这个通知。禁止遇到问题就想到通知，把通知作为备选项而非首选项。
>2. 【必须】post通知时，object通常是指发出notification的对象，如果在发送notification的同时要传递一些额外的信息，请使用userInfo，而不是object。
>3. 【必须】NSNotificationCenter在iOS8及更老的系统有一个多线程bug，selector执行到一半可能会因为self的销毁而引起crash，解决的方案是在selector中使用weak_strong_dance。如下：

```objc
- (void)onMultiThreadNotificationTrigged:(NSNotification *)notify {
    __weak typeof(self) wself = self; __strong typeof(self) sself = wself; 
    if (!sself) { return; }
    [self doSomething]; 
}
```

>4. 【必须】在多线程应用中，Notification在哪个线程中post，就在哪个线程中被转发，而不一定是在注册观察者的那个线程中。如果post消息不在主线程，而接受消息的回调里做了UI操作，需要让其在主线程执行。

> 说明：每个进程都会创建一个NotificationCenter，这个center通过NSNotificationCenter defaultCenter获取，当然也可以自己创建一个center。

NoticiationCenter是以同步（非异步，当前线程，会等待，会阻塞）的方式发送请求。即，当post通知时，center会一直等待所有的observer都收到并且处理了通知才会返回到poster。如果需要异步发送通知，请使用notificationQueue，在一个多线程的应用中，通知会发送到所有的线程中。

#### 3.6 UI规范
>1. 【必须】如果想要获取window，不要使用view.window获取。请使用[[UIApplication sharedApplication] keyWindow]。
>2. 【必须】在使用到 UIScrollView，UITableView，UICollectionView 的 Class 中，需要在 dealloc 方法里手动的把对应的 delegate, dataSouce 置为 nil。
>3. 【必须】UITableView使用self-sizing实现不等高cell时，请在- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;中给cell设置数据。不要在- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;方法中给cell设置数据。
>4. 【建议】当访问一个 CGRect 的 x， y， width， height 时，应该使用CGGeometry 函数代替直接访问结构体成员。
因此，推荐的写法是这样的：

```objc
CGRect frame = self.view.frame;

CGFloat x = CGRectGetMinX(frame);
CGFloat y = CGRectGetMinY(frame);
CGFloat width = CGRectGetWidth(frame);
CGFloat height = CGRectGetHeight(frame);
反对这样的写法：
CGRect frame = self.view.frame;

CGFloat x = frame.origin.x;
CGFloat y = frame.origin.y;
CGFloat width = frame.size.width;
CGFloat height = frame.size.height;‘
```

#### 3.7 IO规范
>1. 【建议】尽量少用NSUserDefaults。说明：[[NSUserDefaults standardUserDefaults] synchronize] 会block住当前线程，知道所有的内容都写进磁盘，如果内容过多，重复调用的话会严重影响性能。
>2. 【建议】一些经常被使用的文件建议做好缓存。避免重复的IO操作。建议只有在合适的时候再进行持久化操作。


#### 3.8 对象判等规范
isEqual:方法允许我们传入任意类型的对象作为参数，如果参数类型和receiver(方法调用者)类型不一致，会返回NO。而isEqualToString:和isEqualToArray:这两个方法会假设参数类型和receiver类型一致，也就是说，这两个方法不会对参数进行类型检查。因此这两个方法性能更好但不安全。如果我们是从外部数据源(比如info.plist或preferences)获取的数据，那么推荐使用isEqual:，因为这样更安全。如果我们知道参数的确切类型，那么可以使用类似于isEqualToString:这样的方法，因为性能更好。

#### 3.9 懒加载规范
懒加载适合的场景：
一个对象的创建依赖于其他对象。
一个对象在整个app过程中，可能被使用，也可能不被使用。
一个对象的创建需要经过大量的计算或者比较消耗性能。除以上三条之外，请不要使用懒加载。
>1. 【建议】懒加载本质上就是延迟初始化某个对象，所以，懒加载仅仅是初始化一个对象，然后对这个对象的属性赋值。懒加载中不应该有其他的不必要的逻辑性的代码，如果有，请把那些逻辑性代码放到合适的地方。
>2. 【必须】不要滥用懒加载，只对那些真正需要懒加载的对象采用懒加载。
>3. 【必须】如果一个对象在懒加载后，某些场景下又被设置为nil。我们很难保证这个懒加载不被再次触发。


#### 3.10 工程规范
>1. 【必须】为了避免文件杂乱，物理文件应该保持和 Xcode 项目文件同步。Xcode 创建的任何组（group）都必须在文件系统有相应的映射。为了更清晰，代码不仅应该按照类型进行分组，也可以根据业务功能进行分组。
>2. 【建议】合理组织工程的内的文件夹，工程中一般包括但不限于以下几个文件夹category(分类)、util/helper(工具类)、resource(资源)、const(常量)、third(第三方)。
>3. 【建议】尽可能一直打开 target Build Settings 中 "Treat Warnings as Errors" 以及一些额外的警告。如果你需要忽略指定的警告,使用 Clang 的编译特性。
