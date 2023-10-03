import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/bottomBar/provider/bottom_bar_provider.dart';
import 'package:talent_app/modules/casting/home/screens/cast_home_screen.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';

class BottomBarScreen extends StatefulWidget {
  int selectIndex;

  BottomBarScreen({super.key, required this.selectIndex});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final List<Widget> _children = [
    const CastHomeScreen(),
    const Center(child: Text("Notification Screen")),
    const Center(child: Text("Chat Screen")),
    const Center(child: Text("Profile Screen"))
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomBarProvider(),
      child: Consumer<BottomBarProvider>(builder: (context, provider, child) {
        return Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              index: widget.selectIndex,
              animationDuration: const Duration(milliseconds: 100),
              iconPadding: 0,
              backgroundColor: Colors.black.withOpacity(0.02),
              buttonBackgroundColor: Colors.transparent,
              animationCurve: Curves.easeIn,
              items: [
                CurvedNavigationBarItem(
                  labelStyle: StyleUtility.bottomBarLabelTextStyle,
                  child: widget.selectIndex == 0
                      ? Image.asset(
                          ImageUtility.homeNavSelectIcon,
                          width: 47,
                        )
                      : Image.asset(
                          ImageUtility.homeNavIcon,
                          width: 27,
                        ),
                  label: widget.selectIndex == 0 ? context.loc.tabHome : "",
                ),

                CurvedNavigationBarItem(
                  labelStyle: StyleUtility.bottomBarLabelTextStyle,
                  child: widget.selectIndex == 1
                      ? Image.asset(
                          ImageUtility.notificationNavSelectIcon,
                          width: 47,
                        )
                      : Image.asset(
                          ImageUtility.notificationNavIcon,
                          width: 23,
                        ),
                  label: widget.selectIndex == 1
                      ? context.loc.tabNotification
                      : "",
                ),

                CurvedNavigationBarItem(
                  labelStyle: StyleUtility.bottomBarLabelTextStyle,
                  child: widget.selectIndex == 2
                      ? Image.asset(
                          ImageUtility.messageNavSelectIcon,
                          width: 47,
                        )
                      : Image.asset(
                          ImageUtility.messageNavIcon,
                          width: 27,
                        ),
                  label: widget.selectIndex == 2 ? context.loc.tabChat : "",
                ),

                CurvedNavigationBarItem(
                  labelStyle: StyleUtility.bottomBarLabelTextStyle,
                  child: widget.selectIndex == 3
                      ? Image.asset(
                          ImageUtility.profileNavSelectIcon,
                          width: 47,
                        )
                      : Image.asset(
                          ImageUtility.profileNavIcon,
                          width: 22,
                        ),
                  label: widget.selectIndex == 3 ? context.loc.tabProfile : "",
                ),

                // CurvedNavigationBarItem(
                //   child: Icon(Icons.newspaper),
                //   label: 'Feed',
                // ),
              ],
              onTap: (index) {
                widget.selectIndex = index;
                provider.updateUi();
              },
            ),
            body: _children[widget.selectIndex]);
      }),
    );
  }
}
