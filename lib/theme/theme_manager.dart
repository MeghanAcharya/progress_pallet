import 'dart:async';

import 'package:flutter/material.dart';

enum ThemeAction { changeThemeTap }

class ThemeManager {
  bool isSwitch = true;
  final ThemeMode _themeMode = ThemeMode.dark;

  get themeMode => _themeMode;

  final stateStreamController =
      StreamController<ThemeResponseModel>.broadcast();

  final eventStreamController = StreamController<ThemeFetchEvent>();

  ThemeManager() {
    eventStreamController.stream.listen((event) {
      if (event is GetTriggerEvent) {
        isSwitch = event.switchTap;
        stateStreamController.sink.add(ThemeResponseModel(isSwitch));
        AppThemeSingle.instance.themeMode =
            isSwitch ? ThemeMode.dark : ThemeMode.light;
      }
    });
  }
}

abstract class ThemeFetchEvent {
  ThemeFetchEvent();
}

class ThemeTriger extends ThemeFetchEvent {
  ThemeAction themeAction;

  ThemeTriger(this.themeAction);
}

class GetTriggerEvent extends ThemeFetchEvent {
  bool switchTap;

  GetTriggerEvent(this.switchTap);
}

class ThemeResponseModel {
  bool switchs;

  ThemeResponseModel(this.switchs);
}

class AppThemeSingle {
  static AppThemeSingle? _instance;
  ThemeMode? themeMode;
  AppThemeSingle._();
  static AppThemeSingle get instance => _instance ??= AppThemeSingle._();
}
