import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class MenuStaticScreen extends StatefulWidget {
  final String headerText;

  const MenuStaticScreen({super.key, required this.headerText});

  @override
  State<MenuStaticScreen> createState() => _MenuStaticScreenState();
}

class _MenuStaticScreenState extends State<MenuStaticScreen> {
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
          widget.headerText,
          style: StyleUtility.kantumruyProMedium5457BETextStyle
              .copyWith(fontSize: TextSizeUtility.textSize20.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: Column(
            children: [
              Text(
                "Welcome to StellarCast Casting Agency, where visions come to life on screen and stage.",
                style: StyleUtility.quicksandBlackWhiteTextStyle
                    .copyWith(fontSize: TextSizeUtility.textSize22.sp),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Text(
                  "With an unwavering commitment to excellence, we specialize in discovering and connecting exceptional talent with the entertainment industry’s most exciting projects. Our extensive network and keen eye for spotting raw potential ensure that every casting choice we make is a step towards crafting unforgettable performances. Backed by years of experience and a passion for storytelling, StellarCast Casting Agency collaborates closely with directors, producers, and creatives to source the perfect cast members who breathe life into characters and narratives.",
                  style: StyleUtility.quicksandRegularBlackTextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize14.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
