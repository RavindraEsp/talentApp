

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Image.asset(ImageUtility.introBg2Image,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageUtility.introCardImage),
                        fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 90.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.loc.letsStart,
                          textAlign: TextAlign.center,
                          style: StyleUtility.extraLargeTextStyle.copyWith(fontSize: TextSizeUtility.textSize40.sp),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          context.loc.introDesc,
                          textAlign: TextAlign.center,
                          style: StyleUtility.quicksandRegular15TextStyle.copyWith(
                            fontSize: TextSizeUtility.textSize15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        CustomButton(
                          buttonText: context.loc.buttonIAmTalent,
                          icon: ImageUtility.talentIcon,
                          onTap: () {




                            Navigator.pushNamed(
                                context, RouteName.helloTalentScreen);




                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomButton(
                          buttonText: context.loc.buttonIAmCasting,
                          icon: ImageUtility.castingIcon,
                          buttonType: ButtonType.yellow,
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.helloCastingScreen);
                          },
                        ),
                        // SizedBox(
                        //   height: 65.h,
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
