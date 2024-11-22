import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:progresspallet/constants/app_constants.dart';
import 'package:progresspallet/constants/app_strings.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._()
      : _remoteConfig = FirebaseRemoteConfig.instance;

  static FirebaseRemoteConfigService? _instance;
  factory FirebaseRemoteConfigService() =>
      _instance ??= FirebaseRemoteConfigService._();

  final FirebaseRemoteConfig _remoteConfig;

  String getString(String key) => _remoteConfig.getString(key);
  int getInt(String key) => _remoteConfig.getInt(key);
  bool getBool(String key) => _remoteConfig.getBool(key);

  Future<void> initialize() async {
    await _setConfigSettings();
    await fetchAndActivate();
  }

  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 1),
        ),
      );

  Future<void> fetchAndActivate() async {
    // var status = sl<NetworkConnectionCubit>().connectionStatus;
    // if (status != Connection.disconnected) {
    await _remoteConfig.fetchAndActivate().then(
      (value) async {
        Map<String, RemoteConfigValue> configs = _remoteConfig.getAll();
        updateDefaults(configs);
      },
    );
    // } else {
    //   Future.delayed(
    //     const Duration(seconds: 5),
    //     () async {
    //       try {
    //         await fetchAndActivate();
    //       } catch (e) {
    //         printMessage("fetchAndActivate");
    //       }
    //     },
    //   );
    //  }
  }

  // Future<void> _setDefaults() async => _remoteConfig.setDefaults(
  //       const {
  //         AppConstants.welcomeMessageKey:
  //             'Hey there, this message is coming from local defaults.',
  //         AppConstants.isFacebookEnabledKey: false,
  //         AppConstants.showOtpKey: false
  //       },
  //     );

  void updateDefaults(Map<String, RemoteConfigValue> configs) {
    for (var element in configs.entries) {
      if (element.key == AppConstants.bearerTokenKey) {
        AppStrings.bearerToken = element.value.asString();
      }
      if (element.key == AppConstants.defaultUser) {
        AppStrings.defaultUser = element.value.asString();
      }
    }
  }
}
