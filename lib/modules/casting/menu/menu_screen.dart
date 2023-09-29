import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
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
          style: StyleUtility.kantumruyProSMedium5457BETextStyle
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
              onTap: () {},
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.menuAboutUs,
              image: ImageUtility.aboutUsIcon,
              onTap: () {},
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.menuCreateAnAudition,
              image: ImageUtility.createAuditionIcon,
              onTap: () {},
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.menuNotifications,
              image: ImageUtility.notificationSettingIconIcon,
              onTap: () {},
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.menuChat,
              image: ImageUtility.chatIcon,
              onTap: () {},
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.menuTermAndConditions,
              image: ImageUtility.tCIcon,
              onTap: () {},
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.menuSupport,
              image: ImageUtility.supportIcon,
              onTap: () {},
            ),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: ColorUtility.colorEDEDEF),
            SettingTileWidget(
              title: context.loc.menuPolicy,
              image: ImageUtility.policyIcon,
              onTap: () {},
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
