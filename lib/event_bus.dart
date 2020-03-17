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