import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class TalentMenuScreen extends StatefulWidget {
  const TalentMenuScreen({super.key});

  @override
  State<TalentMenuScreen> createState() => _TalentMenuScreenState();
}

class _TalentMenuScreenState extends State<TalentMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        backgroundColor: ColorUtility.colorWhite,
        centerTitle: true,
        elevation: 0,
        title: Text(
          context.loc.headerMenu,
          style: StyleUtility.kantumruyProMedium5457BETextStyle
              .copyWith(fontSize: TextSizeUtility.textSize20.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            SettingTileWidget(
              title: context.loc.menuHome,
              image: ImageUtility.homeIcon,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteName.talentBottomBarScreen,
                    arguments: {"selectIndex": 0},
                    (route) => false);
              },
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.menuAboutUs,
              image: ImageUtility.aboutUsIcon,
              onTap: () {
                Navigator.pushNamed(context, RouteName.menuStaticScreen,
                    arguments: {"headerText": context.loc.menuAboutUs,
                      "pageName": PageName.aboutUs,});
              },
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.menuDeniedAudition,
              image: ImageUtility.createAuditionIcon,
              onTap: () {

                Navigator.pushNamed(context, RouteName.deniedAuditionScreen);
              },
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),

            SettingTileWidget(
               title: context.loc.menuApprovedAuditions,
              image: ImageUtility.approvedAuditionIcon,
              onTap: () {

                Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteName.talentBottomBarScreen,
                    arguments: {"selectIndex": 0},
                        (route) => false);

                // Navigator.pushNamed(
                //     context,
                //     RouteName
                //         .auditionDetailScreen,
                //     arguments: {
                //       "auditionDetailType":
                //       AuditionDetailType
                //           .approved
                //     });
              },
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),



            SettingTileWidget(
              title: context.loc.menuNotifications,
              image: ImageUtility.notificationSettingIconIcon,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteName.talentBottomBarScreen,
                    arguments: {"selectIndex": 1},
                    (route) => false);
              },
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.menuChat,
              image: ImageUtility.chatIcon,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteName.talentBottomBarScreen,
                    arguments: {"selectIndex": 2},
                    (route) => false);
              },
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.menuTermAndConditions,
              image: ImageUtility.tCIcon,
              onTap: () {
                Navigator.pushNamed(context, RouteName.menuStaticScreen,
                    arguments: {
                      "headerText": context.loc.menuTermAndConditions,
                      "pageName": PageName.termCondition,
                    });
              },
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.menuSupport,
              image: ImageUtility.supportIcon,
              onTap: () {

              },
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.menuPolicy,
              image: ImageUtility.policyIcon,
              onTap: () {
                Navigator.pushNamed(context, RouteName.menuStaticScreen,
                    arguments: {"headerText": context.loc.menuPolicy,
                      "pageName": PageName.policy,});
              },
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SizedBox(
              height: 35.h,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingTileWidget extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const SettingTileWidget({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:
            EdgeInsets.only(left: 25.w, right: 25.w, top: 14.h, bottom: 14.h),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 26.w,
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              title,
              style: StyleUtility.quicksandMediumBlackTextStyle
                  .copyWith(fontSize: TextSizeUtility.textSize18),
            )
          ],
        ),
      ),
    );
  }
}
