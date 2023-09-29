import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/routes/app_routes.dart';
import 'modules/casting/home/screens/cast_home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  Locale _appLocale = const Locale('en'); // Default to English

  void setLocale(Locale newLocale) {
    setState(() {
      _appLocale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        // splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: _appLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            title: 'Talent App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // home: const IntroScreen(),
            home: const CastHomeScreen(),
            //  home: CastProfileScreen(),
            // home: const CreateAuditionPlaceTimeScreen(),
            //  home: const CreateAuditionScreen(),
            //   home:  BottomBarScreen(selectIndex: 0,),
            onGenerateRoute: AppRoute.generateRoute,
            // builder: (context, widget) {
            //   return MediaQuery(
            //       data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            //       child: widget!);
            // },
          );
        });
  }
}
