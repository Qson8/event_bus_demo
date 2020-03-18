### EventBus事件总线

原生开发中，时常遇到通知或广播机制，应对需要跨页面的事件通知。作为移动端跨平台框架的Flutter而已，也有同样的解决方案-EventBus，event_bus提供事件总线功能来实现一些状态的更新，核心是基于Dart Streams（流）；事件总线通常实现了订阅者模式，订阅者模式包含发布者和订阅者两种角色，可以通过事件总线来触发事件和监听事件，下面来通过更改主题颜色的案例认识下event_bus。

#### 1 集成插件

在pubspec.yaml文件中添加event_bus，当前版本1.1.1
```dart
event_bus: ^1.1.0
```
在使用的地方import 
```dart
import 'package:asset_pickers/asset_pickers.dart';
```

####2 创建EventBus
通常每个应用程序只有一个事件总线，但可以设置多个事件总线以对一组特定事件进行分组。新建event_bus.dart类，在类中创建EventBus实例，并使其能够在其他类中被使用，并定义了ThemeEvent通知修改主题样式的事件
```dart
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

enum ThemeModel {
  light, // 浅色
  dark, // 深色
}

class ThemeEvent {
  ThemeModel model = ThemeModel.light;

  ThemeEvent(this.model);
}
```

#### 3 注册订阅者
下面我们在main.dart中，注册订阅者，收到修改模式的通知后，处理样式更改逻辑，多个页面同样处理。
```dart
@override
  void initState() {
    super.initState();
    _themeModelscription = eventBus.on<ThemeEvent>().listen((event) {
      setState(() {
        color = event.model == ThemeModel.light
            ? Color(0xfff5f5f5)
            : Color(0xff000000);
      });
    });
  }
```

#### 4 触发订阅通知
在需要触发的地方，调用下面方法，即可通知到已订阅该类型通知指出相应逻辑。
```dart
eventBus.fire(ThemeEvent(model));
```

#### 5 解除订阅
所涉及的订阅者在生命周期结束前，需要解除订阅，防止内存泄漏。
```dart
void dispose() {
    super.dispose();
    //取消订阅
    _themeModelscription.cancel();
  }
```

案例效果图

![效果图](http://img.520lee.com/Fn-ENM-Qlb92xcqeBo1lZqDOfYko)

1.案例github地址：https://github.com/Qson8/event_bus_demo

2.event_bus插件地址：https://pub.dev/packages/event_bus

了解学习更多关于Flutter技术，欢迎公众号： Hi Flutter，个人微信：qiukangsheng
