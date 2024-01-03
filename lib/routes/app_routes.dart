import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/modules/casting/auth/forgotPassword/provider/ForgotPassVerifyOtpProvider.dart';
import 'package:talent_app/modules/casting/auth/forgotPassword/provider/create_new_pass_screen_provider.dart';
import 'package:talent_app/modules/casting/auth/forgotPassword/provider/forgot_pass_find_account_provider.dart';
import 'package:talent_app/modules/casting/auth/forgotPassword/screens/create_new_pass_screen.dart';
import 'package:talent_app/modules/casting/auth/forgotPassword/screens/forgot_pass_find_account_screen.dart';
import 'package:talent_app/modules/casting/auth/forgotPassword/screens/forgot_pass_verify_otp_screen.dart';
import 'package:talent_app/modules/casting/auth/login/provider/cast_login_provider.dart';
import 'package:talent_app/modules/casting/auth/login/screen/cast_login_screen.dart';
import 'package:talent_app/modules/casting/auth/signup/provider/cast_verify_phone_provider.dart';
import 'package:talent_app/modules/casting/auth/signup/screens/cast_signup_screen.dart';
import 'package:talent_app/modules/casting/auth/signup/provider/signup_screen_provider.dart';
import 'package:talent_app/modules/casting/auth/signup/screens/cast_verify_phone_screen.dart';
import 'package:talent_app/modules/casting/bottomBar/provider/bottom_bar_provider.dart';
import 'package:talent_app/modules/casting/bottomBar/screen/cast_bottom_bar_screen.dart';
import 'package:talent_app/modules/casting/chat/screens/chat_screen.dart';
import 'package:talent_app/modules/casting/createAudition/providers/create_audition_place_time_provider.dart';
import 'package:talent_app/modules/casting/createAudition/providers/create_audition_provider.dart';
import 'package:talent_app/modules/casting/createAudition/screens/create_audition_place_time_screen.dart';
import 'package:talent_app/modules/casting/createAudition/screens/create_audition_screen.dart';
import 'package:talent_app/modules/casting/createCard/cast_create_card_screen.dart';
import 'package:talent_app/modules/casting/createCard/provider/cast_create_card_provider.dart';
import 'package:talent_app/modules/casting/editAudition/provider/edit_audition_place_time_provider.dart';
import 'package:talent_app/modules/casting/editAudition/provider/edit_audition_screen_provider.dart';
import 'package:talent_app/modules/casting/editAudition/screens/edit_audition_place_time_screen.dart';
import 'package:talent_app/modules/casting/editAudition/screens/edit_audition_screen.dart';
import 'package:talent_app/modules/casting/helloCasting/hello_casting_screen.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/providers/manage_audition_created_screen_provider.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/providers/see_telent_user_profile_screen_provider.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/screens/manage_audition_created_screen.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/screens/see_telent_user_profile_screen.dart';
import 'package:talent_app/modules/casting/manageAudition/managefinishedAudition/manage_finished_audition_screen.dart';
import 'package:talent_app/modules/casting/manageAudition/managefinishedAudition/providers/manage_finished_audition_screen_provider.dart';
import 'package:talent_app/modules/casting/menu/providers/web_content_provider.dart';
import 'package:talent_app/modules/casting/menu/screens/menu_screen.dart';
import 'package:talent_app/modules/casting/menu/screens/menu_static_screen.dart';
import 'package:talent_app/modules/casting/setting/screens/setting_screen.dart';
import 'package:talent_app/modules/intro/intro_screen.dart';
import 'package:talent_app/modules/talent/auditionDetails/screens/audition_detail_screen.dart';
import 'package:talent_app/modules/talent/bottomBar/screen/talent_bottom_bar_screen.dart';
import 'package:talent_app/modules/talent/createCard/provider/add_info_provider.dart';
import 'package:talent_app/modules/talent/createCard/screens/add_info_screen.dart';
import 'package:talent_app/modules/talent/createCard/screens/add_your_audio_screen.dart';
import 'package:talent_app/modules/talent/createCard/screens/add_your_photo_screen.dart';
import 'package:talent_app/modules/talent/createCard/screens/add_your_video_screen.dart';
import 'package:talent_app/modules/talent/createCard/screens/talent_create_card_screen.dart';
import 'package:talent_app/modules/talent/createCard/screens/talent_create_card_step_two_screen.dart';
import 'package:talent_app/modules/talent/helloTalent/hello_talent_screen.dart';
import 'package:talent_app/modules/talent/menu/screens/denied_audition_screen.dart';
import 'package:talent_app/modules/talent/menu/screens/talent_menu_screen.dart';
import 'package:talent_app/modules/talent/profile/screens/edit_audio_screen.dart';
import 'package:talent_app/modules/talent/profile/screens/edit_body_screen.dart';
import 'package:talent_app/modules/talent/profile/screens/edit_genre_screen.dart';
import 'package:talent_app/modules/talent/profile/screens/edit_photo_gallery_screen.dart';
import 'package:talent_app/modules/talent/profile/screens/edit_tell_us_about_screen.dart';
import 'package:talent_app/modules/talent/profile/screens/edit_video_gallery_screen.dart';
import 'package:talent_app/modules/talent/subscribe/screens/subscribe_screen.dart';
import 'package:talent_app/modules/talent/widgets/talent_setting_screen.dart';
import 'package:talent_app/routes/route_name.dart';

import '../modules/talent/createCard/provider/talent_create_card_step_two_provider.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.helloCastingScreen:
        return MaterialPageRoute(
            builder: (context) => const HelloCastingScreen());

      case RouteName.castSignupScreen:
        var arg = settings.arguments as Map;

        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (_) => SignUpScreenProvider(),
                child: CastSignupScreen(
                  userType: arg["userType"],
                )));

      case RouteName.castVerifyPhoneScreen:
        var arg = settings.arguments as Map;

        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => CastVerifyPhoneProvider(),
                  child: CastVerifyPhoneScreen(
                    userType: arg["userType"],
                    email: arg["email"],
                    phone: arg["phone"],
                    countyCode: arg["countyCode"],
                    userName: arg["userName"],
                    password: arg["password"],
                    confirmPassword: arg["confirmPassword"],
                  ),
                ));

      case RouteName.castLoginScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => CastLoginProvider(),
                  child: CastLoginScreen(userType: arg["userType"]),
                ));

      case RouteName.castCreateCardScreen:
        //   var arg = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => CastCreateCardProvider(),
                  child: const CastCreateCardScreen(),
                ));

      case RouteName.forgotPassFindAccountScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => ForgotPassFindAccountProvider(),
                  child: ForgotPassFindAccountScreen(
                    userType: arg["userType"],
                  ),
                ));

      case RouteName.forgotPassVerifyOtpScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => ForgotPassVerifyOtpProvider(),
                  child: ForgotPassVerifyOtpScreen(
                    email: arg["email"],
                    userType: arg["userType"],
                  ),
                ));

      case RouteName.createNewPassScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => CreateNewPassScreenProvider(),
                  child: CreateNewPassScreen(
                    userType: arg["userType"],
                    email: arg["email"],
                    otp: arg["otp"],
                  ),
                ));

      case RouteName.castBottomBarScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => BottomBarProvider(),
                  child: CastBottomBarScreen(
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
          //  builder: (context) => const CreateAuditionScreen(),
          builder: (context) => ChangeNotifierProvider(
            create: (context) => CreateAuditionProvider(),
            child: const CreateAuditionScreen(),
          ),
        );
      case RouteName.createAuditionPlaceTimeScreen:
        var arg = settings.arguments as Map;

        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => CreateAuditionPlaceTimeProvider(),
            child: CreateAuditionPlaceTimeScreen(
              description: arg["description"],
              workExperience: arg["workExperience"],
              professionalTraining: arg["professionalTraining"],
              candidateRepresentation: arg["candidateRepresentation"],
              ageRangeMin: arg["ageRangeMin"],
              ageRangeMax: arg["ageRangeMax"],
              weightRangeMin: arg["weightRangeMin"],
              weightRangeMax: arg["weightRangeMax"],
              heightRangeMin: arg["heightRangeMin"],
              heightRangeMax: arg["heightRangeMax"],
              careerTag: arg["careerTag"],
              auditionTalentAllData: arg["auditionTalentAllData"],
            ),
          ),
        );

      case RouteName.editAuditionScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => EditAuditionScreenProvider(),
                child: EditAuditionScreen(
                  auditionId: arg["auditionId"],
                )));

      case RouteName.editAuditionPlaceTimeScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => EditAuditionPlaceTimeScreenProvider(),
                  child: EditAuditionPlaceTimeScreen(
                    editAuditionScreen1DataModel:
                        arg["editAuditionScreen1DataModel"],
                  ),
                ));

      case RouteName.manageFinishedAuditionScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => ManageFinishedAuditionScreenProvider(),
                  child: ManageFinishedAuditionScreen(
                    auditionId: arg["auditionId"],
                  ),
                ));

      case RouteName.manageAuditionCreatedScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => ManageAuditionCreatedScreenProvider(),
                  child: ManageAuditionCreatedScreen(
                    auditionId: arg["auditionId"],
                  ),
                ));

      case RouteName.seeUserProfileScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => SeeTelentUserProfileScreenProvider(),
              child: SeeUserProfileScreen(
                telentUserId: arg["telentUserId"],
              )),
        );

      case RouteName.menuStaticScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) =>
                //     MenuStaticScreen(
                //   headerText: arg["headerText"],
                // ),
                ChangeNotifierProvider(
                  create: (context) => WebContentProvider(),
                  child: MenuStaticScreen(
                    headerText: arg["headerText"],
                    pageName: arg["pageName"],
                  ),
                ));

      case RouteName.chatScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => ChatScreen(
            userType: arg["userType"],
          ),
        );

      // Talent Screens

      case RouteName.helloTalentScreen:
        return MaterialPageRoute(
          builder: (context) => const HelloTalentScreen(),
        );

      case RouteName.subscribeScreen:
        return MaterialPageRoute(
          builder: (context) => const SubscribeScreen(),
        );

      case RouteName.talentCreateCardScreen:
        return MaterialPageRoute(
          builder: (context) => const TalentCreateCardScreen(),
        );

      case RouteName.talentCreateCardStepTwoScreen:
        //"talentCreateCardModel":talentCreateCardModel

        var arg = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => TalentCreateCardStepTwoProvider(),
              child: TalentCreateCardStepTwoScreen(
                talentCreateCardModel: arg["talentCreateCardModel"],
              )),
        );

      case RouteName.addYourPhotoScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => AddYourPhotoScreen(
              talentCreateCardModel: arg["talentCreateCardModel"]),
        );

      case RouteName.addYourVideoScreen:
        return MaterialPageRoute(
          builder: (context) => const AddYourVideoScreen(),
        );

      case RouteName.addYourAudioScreen:
        return MaterialPageRoute(
          builder: (context) => const AddYourAudioScreen(),
        );

      case RouteName.addInfoScreen:
        var arg = settings.arguments as Map;

        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => AddInfoProvider(),
                  child: AddInfoScreen(
                    talentCreateCardModel: arg["talentCreateCardModel"],
                    selectedImages: arg["selectedImages"],
                  ),
                ));

      case RouteName.talentBottomBarScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => BottomBarProvider(),
                  child: TalentBottomBarScreen(
                    selectIndex: arg["selectIndex"],
                  ),
                ));

      case RouteName.talentSettingScreen:
        return MaterialPageRoute(
          builder: (context) => const TalentSettingScreen(),
        );

      case RouteName.talentMenuScreen:
        return MaterialPageRoute(
          builder: (context) => const TalentMenuScreen(),
        );

      case RouteName.editTellUsAboutScreen:
        return MaterialPageRoute(
          builder: (context) => const EditTellUsAboutScreen(),
        );

      case RouteName.editPhotoGalleryScreen:
        return MaterialPageRoute(
          builder: (context) => const EditPhotoGalleryScreen(),
        );

      case RouteName.editVideoGalleryScreen:
        return MaterialPageRoute(
          builder: (context) => const EditVideoGalleryScreen(),
        );
      case RouteName.editAudioScreen:
        return MaterialPageRoute(
          builder: (context) => const EditAudioScreen(),
        );
      case RouteName.editGenreScreen:
        return MaterialPageRoute(
          builder: (context) => const EditGenreScreen(),
        );

      case RouteName.editBodyScreen:
        return MaterialPageRoute(
          builder: (context) => const EditBodyScreen(),
        );

      case RouteName.deniedAuditionScreen:
        return MaterialPageRoute(
          builder: (context) => const DeniedAuditionScreen(),
        );

      case RouteName.auditionDetailScreen:
        var arg = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => AuditionDetailScreen(
            auditionDetailType: arg["auditionDetailType"],
          ),
        );

      default:
        return MaterialPageRoute(builder: (context) => const IntroScreen());
    }
  }
}
