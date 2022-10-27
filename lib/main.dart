import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:settings/drinkWaterReminder/DrinkWaterReminderScreen.dart';
import 'package:settings/routes/app_pages.dart';
import 'package:settings/tracking-drinkwater/models/app_prefs.dart';

import 'package:settings/utils/Color.dart';
import 'package:settings/utils/Debug.dart';
import 'package:settings/utils/Preference.dart';

import 'localization/locale_constant.dart';
import 'localization/localizations_delegate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
//     BehaviorSubject<ReceivedNotification>();

// final BehaviorSubject<String?> selectNotificationSubject =
//     BehaviorSubject<String?>();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference().instance();
  // await initPlugin();
  // await DataBaseHelper().initialize();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    // iOS: initializationSettingsIOS,
  );

  await AppPrefs.instance.initListener();
  tz.initializeTimeZones();
  var detroit = tz.getLocation('Asia/Bangkok');
  tz.setLocalLocation(detroit);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final navigatorKey = new GlobalKey<NavigatorState>();
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  bool isFirstTimeUser = true;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    _locale = getLocale();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // _initGoogleMobileAds();
    isFirstTime();
    super.initState();
  }

  isFirstTime() async {
    isFirstTimeUser =
        Preference.shared.getBool(Preference.IS_USER_FIRSTTIME) ?? true;
    Debug.printLog(isFirstTimeUser.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: MyApp.navigatorKey,
      // builder: (context, child) {
      //   return MediaQuery(
      //     child: child!,
      //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      //   );
      // },
      theme: ThemeData(
        splashColor: Colur.transparent,
        highlightColor: Colur.transparent,
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: [
        Locale('en', ''),
        Locale('zh', ''),
        Locale('es', ''),
        Locale('de', ''),
        Locale('pt', ''),
        Locale('ar', ''),
        Locale('fr', ''),
        Locale('ja', ''),
        Locale('ru', ''),
        Locale('ur', ''),
        Locale('hi', ''),
        Locale('vi', ''),
        Locale('id', ''),
        Locale('bn', ''),
        Locale('ta', ''),
        Locale('te', ''),
        Locale('tr', ''),
        Locale('ko', ''),
        Locale('pa', ''),
        Locale('it', ''),
      ],
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colur.white, brightness: Brightness.light),
        appBarTheme: AppBarTheme(
          backgroundColor: Colur.transparent,
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // home: DrinkWaterReminderScreen(),
    );
  }
}
