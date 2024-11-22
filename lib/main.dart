import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:progresspallet/constants/app_constants.dart';
import 'package:progresspallet/constants/app_sizes.dart';
import 'package:progresspallet/core/logs.dart';
import 'package:progresspallet/dependency_injection/injection_container.dart'
    as di;
import 'package:progresspallet/routing/router.dart';
import 'package:progresspallet/theme/theme_constants.dart';
import 'package:progresspallet/theme/theme_manager.dart';
import 'package:progresspallet/utils/localization/app_localizations.dart';
import 'package:progresspallet/utils/storage_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    di.init(),
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = getGoRouter();

  final themeManager = ThemeManager();
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var locale = _fetchLocale();
      setState(() {
        _locale = locale;
        AppLocalizations.of(context)?.load(_locale ??
            Locale.fromSubtags(languageCode: appStoragePref.getLangCode()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: StreamBuilder<ThemeResponseModel>(
        stream: themeManager.stateStreamController.stream,
        initialData: ThemeResponseModel(false),
        builder: (context, AsyncSnapshot<ThemeResponseModel> snap) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Listener(
              onPointerUp: (e) {
                printMessage("TAP");
              },
              child: MaterialApp.router(
                title: AppConstants.appName,
                debugShowCheckedModeBanner: false,
                theme: isDarkMode() ? darkTheme : lightTheme,
                locale: _locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  if (supportedLocales.contains(_locale)) {
                    return _locale;
                  } else {
                    return supportedLocales.first;
                  }
                },
                routerDelegate: _router.routerDelegate,
                routeInformationParser: _router.routeInformationParser,
                routeInformationProvider: _router.routeInformationProvider,
                themeMode: ThemeMode.light,
                scaffoldMessengerKey:
                    di.sl<GlobalKey<ScaffoldMessengerState>>(),
                builder: (context, widget) {
                  AppSizes.setMediaQueryData(MediaQuery.of(context)
                    ..copyWith(textScaler: const TextScaler.linear(1.0)));
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: widget ?? Container(),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  //check isDarkMode
  bool isDarkMode() {
    return appStoragePref.isDarkMode();
  }

  //refresh locale
  refresh(Locale newLocale) => setState(() {
        _locale = newLocale;
      });

  Locale _fetchLocale() {
    final String savedLocale = appStoragePref.getLangCode();
    var locale = const Locale('en', 'US');
    if (savedLocale == 'en') {
      locale = const Locale('en', 'US');
    } else if (savedLocale == 'ar') {
      locale = const Locale('ar', 'AE');
    }
    return locale;
  }
}
