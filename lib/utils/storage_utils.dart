/*
 *
 *  Webkul Software.
 * @package Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

import 'package:get_storage/get_storage.dart';
import 'package:progresspallet/constants/app_constants.dart';
import 'package:progresspallet/constants/app_pref_constants.dart';

final appStoragePref = AppStoragePref();

class AppStoragePref {
  var configurationStorage = GetStorage(
      "configurationStorage"); //-----Use only for user app configuration data

  init() async {
    await GetStorage.init("configurationStorage");

    return true;
  }

  String getLangCode() {
    return configurationStorage.read(Preferences.langCode) ??
        AppConstants.defaultLangCode;
  }

  setLangCode(String code) {
    configurationStorage.write(Preferences.langCode, code);
  }

  bool showWalkThrough() {
    return configurationStorage.read(Preferences.showWalkthrough) ?? true;
  }

  setShowWalkThrough(bool? value) {
    configurationStorage.write(Preferences.showWalkthrough, value);
  }

  bool isDarkMode() {
    return configurationStorage.read(Preferences.isDarkTheme) ?? false;
  }

  setIsDarkMode(bool? value) {
    configurationStorage.write(Preferences.isDarkTheme, value);
  }
}
