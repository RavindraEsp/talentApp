import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/bottomBar/provider/bottom_bar_provider.dart';
import 'package:talent_app/modules/casting/chat/provider/chat_user_list_screen_provider.dart';
import 'package:talent_app/modules/casting/chat/screens/chat_user_list_screen.dart';
import 'package:talent_app/modules/casting/home/screens/cast_home_screen.dart';
import 'package:talent_app/modules/casting/notification/notification_provider.dart';
import 'package:talent_app/modules/casting/notification/notification_screen.dart';
import 'package:talent_app/modules/casting/profile/cast_profile_screen.dart';
import 'package:talent_app/modules/talent/education/providers/education_list_screen_provider.dart';
import 'package:talent_app/modules/talent/education/screens/education_list_screen.dart';
import 'package:talent_app/modules/talent/home/providers/talent_home_screen_provider.dart';
import 'package:talent_app/modules/talent/home/screen/talent_home_screen.dart';
import 'package:talent_app/modules/talent/profile/providers/talent_profile_screen_provider.dart';
import 'package:talent_app/modules/talent/profile/screens/talent_profile_screen.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';

class TalentBottomBarScreen extends StatefulWidget {
  int selectIndex;
 final int selectHomeIndex;

  TalentBottomBarScreen({super.key, required this.selectIndex, required this.selectHomeIndex});

  @override
  State createState() => _TalentBottomBarScreenState(selectIndex,selectHomeIndex);
}

//class _BottomBarScreenState extends State<BottomBarScreen> {
class _TalentBottomBarScreenState extends State {
  late final List<Widget> _children;

  late int selectIndex;
  final int selectHomeIndex;

  _TalentBottomBarScreenState(this.selectIndex,this.selectHomeIndex);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _children = [


      ChangeNotifierProvider(
        create: (context) => TalentHomeScreenProvider(),
        child:  TalentHomeScreen(
          selectHomeTab: selectHomeIndex,
        ),
      ),

      ChangeNotifierProvider(
        create: (context) => NotificationProvider(),
        child: const NotificationScreen(
          userType: UserType.talent,
        ),
      ),

      ChangeNotifierProvider(
        create: (context) => ChatUserListScreenProvider(),
        child: const   ChatUserListScreen(userType: UserType.talent),
      ),

      ChangeNotifierProvider(
        create: (context) => EducationListScreenProvider(),
        child: const EducationListScreen(),
      ),

      ChangeNotifierProvider(
        create: (context) => TalentProfileScreenProvider(),
        child: const TalentProfileScreen(),
      ),


    ];

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomBarProvider(),
      child: Consumer<BottomBarProvider>(builder: (context, provider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: CurvedNavigationBar(
            index: selectIndex,
            animationDuration: const Duration(milliseconds: 100),
            iconPadding: 0,
            backgroundColor: Colors.black.withOpacity(0.02),
            buttonBackgroundColor: Colors.transparent,
            animationCurve: Curves.easeIn,
            items: [
              CurvedNavigationBarItem(
                labelStyle: StyleUtility.bottomBarLabelTextStyle,
                child: selectIndex == 0
                    ? Image.asset(
                        ImageUtility.homeNavSelectIcon,
                        width: 47,
                      )
                    : Image.asset(
                        ImageUtility.homeNavIcon,
                        width: 27,
                      ),
                label: selectIndex == 0 ? context.loc.tabHome : "",
              ),
              CurvedNavigationBarItem(
                labelStyle: StyleUtility.bottomBarLabelTextStyle,
                child: selectIndex == 1
                    ? Image.asset(
                        ImageUtility.notificationNavSelectIcon,
                        width: 47,
                      )
                    : Image.asset(
                        ImageUtility.notificationNavIcon,
                        width: 23,
                      ),
                label: selectIndex == 1 ? context.loc.tabNotification : "",
              ),
              CurvedNavigationBarItem(
                labelStyle: StyleUtility.bottomBarLabelTextStyle,
                child: selectIndex == 2
                    ? Image.asset(
                        ImageUtility.messageNavSelectIcon,
                        width: 47,
                      )
                    : Image.asset(
                        ImageUtility.messageNavIcon,
                        width: 27,
                      ),
                label: selectIndex == 2 ? context.loc.tabChat : "",
              ),
              CurvedNavigationBarItem(
                labelStyle: StyleUtility.bottomBarLabelTextStyle,
                child: selectIndex == 3
                    ? Image.asset(
                  ImageUtility.educationNavSelectIcon,
                  width: 47,
                )
                    : Image.asset(
                  ImageUtility.educationNavIcon,
                  width: 44,
                ),
                label: selectIndex == 3 ? context.loc.tabEducation : "",
              ),

              CurvedNavigationBarItem(
                labelStyle: StyleUtility.bottomBarLabelTextStyle,
                child: selectIndex == 4
                    ? Image.asset(
                        ImageUtility.profileNavSelectIcon,
                        width: 47,
                      )
                    : Image.asset(
                        ImageUtility.profileNavIcon,
                        width: 22,
                      ),
                label: selectIndex == 4 ? context.loc.tabProfile : "",
              ),
            ],
            onTap: (index) {
              selectIndex = index;
              provider.updateUi();
            },
          ),
          body: _children[selectIndex],
        );
      }),
    );
  }
}
