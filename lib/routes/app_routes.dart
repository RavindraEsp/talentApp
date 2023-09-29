import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/modules/casting/auth/login/provider/cast_login_provider.dart';
import 'package:talent_app/modules/casting/auth/login/screen/cast_login_screen.dart';
import 'package:talent_app/modules/casting/auth/signup/provider/cast_verify_phone_provider.dart';
import 'package:talent_app/modules/casting/auth/signup/screens/cast_signup_screen.dart';
import 'package:talent_app/modules/casting/auth/signup/provider/signup_screen_provider.dart';
import 'package:talent_app/modules/casting/auth/signup/screens/cast_verify_phone_screen.dart';
import 'package:talent_app/modules/casting/bottomBar/provider/bottom_bar_provider.dart';
import 'package:talent_app/modules/casting/bottomBar/screen/bottom_bar_screen.dart';
import 'package:talent_app/modules/casting/createAudition/screens/create_audition_place_time_screen.dart';
import 'package:talent_app/modules/casting/createAudition/screens/create_audition_screen.dart';
import 'package:talent_app/modules/casting/helloCasting/hello_casting_screen.dart';
import 'package:talent_app/modules/casting/menu/menu_screen.dart';
import 'package:talent_app/modules/casting/setting/screens/setting_screen.dart';
import 'package:talent_app/modules/intro/intro_screen.dart';
import 'package:talent_app/routes/route_name.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.helloCastingScreen:
        return MaterialPageRoute(
            builder: (context) => const HelloCastingScreen());

      case RouteName.castSignupScreen:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (_) => SignUpScreenProvider(),
                child: const CastSignupScreen()));

      case RouteName.castVerifyPhoneScreen:
        var arg = settings.arguments as Map;

        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => CastVerifyPhoneProvider(),
                  child: CastVerifyPhoneScreen(
                    email: arg["email"],
                    phone: arg["phone"],
                    userName: arg["userName"],
                    password: arg["password"],
                    confirmPassword: arg["confirmPassword"],
                  ),
                ));

      case RouteName.castLoginScreen:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => CastLoginProvider(),
                  child: const CastLoginScreen(),
                ));

      case RouteName.bottomBarScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => BottomBarProvider(),
                  child: BottomBarScreen(
                    selectIndex: arg["selectIndex"],
                  ),
                ));

      case RouteName.settingScreen:
        return MaterialPageRoute(
          builder: (context) => const SettingScreen(),
        );

      case RouteName.menuScreen:
        return MaterialPageRoute(
          builder: (context) => const MenuScreen(),
        );

      case RouteName.createAuditionScreen:
        return MaterialPageRoute(
          builder: (context) => const CreateAuditionScreen(),
        );
      case RouteName.createAuditionPlaceTimeScreen:
        return MaterialPageRoute(
          builder: (context) => const CreateAuditionPlaceTimeScreen(),
        );
      default:
        return MaterialPageRoute(builder: (context) => const IntroScreen());
    }
  }
}
