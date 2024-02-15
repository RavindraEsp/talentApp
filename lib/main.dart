
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/modules/casting/bottomBar/screen/cast_bottom_bar_screen.dart';
import 'package:talent_app/modules/casting/createCard/cast_create_card_screen.dart';
import 'package:talent_app/modules/splash/splash_screen.dart';
import 'package:talent_app/modules/talent/bottomBar/screen/talent_bottom_bar_screen.dart';
import 'package:talent_app/modules/talent/createCard/screens/talent_create_card_screen.dart';
import 'package:talent_app/modules/talent/education/screens/education_list_screen.dart';
import 'package:talent_app/modules/talent/subscribe/screens/subscribe_screen.dart';
import 'package:talent_app/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:talent_app/utilities/shared_preference.dart';
import 'package:talent_app/widgets/audio_player/audio_player_screen.dart';
import 'package:talent_app/widgets/video_player/video_player_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

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

  @override
  void initState() {
    super.initState();
    prefCall();
  }

  Locale _appLocale = const Locale('en'); // Default to English

  void setLocale(Locale newLocale) {
    setState(() {
      _appLocale = newLocale;
    });
  }

  prefCall() async {
    await Preference().instance();

  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        // splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: mainNavigatorKey,
            debugShowCheckedModeBanner: false,
            locale: _appLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            title: 'Talent App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),

            home: const SplashScreen(),

          //  home: const EducationListScreen(),



            //final
          //  home:  AudioPlayerScreen(),

            //final
          //  home:  VideoPlayerScreen(file: 'image-1705662962037.mp4',),


          //  home:CastBottomBarScreen(selectIndex: 0),
          //  home:TalentBottomBarScreen(selectIndex: 0),
           // home:SubscribeScreen(),
           // home:const TalentCreateCardScreen(),



           // home: const EditVideoGalleryScreen(),

         //   home: TalentBottomBarScreen(selectIndex: 0,),
          //  home: const AuditionDetailScreen(),

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
