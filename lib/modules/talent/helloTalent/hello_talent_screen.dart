import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';

class HelloTalentScreen extends StatefulWidget {
  const HelloTalentScreen({super.key});

  @override
  State<HelloTalentScreen> createState() => _HelloTalentScreenState();
}

class _HelloTalentScreenState extends State<HelloTalentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(ImageUtility.helloTalentBgImage,
            fit: BoxFit.fill,),
          ),
          Container(
            // alignment: Alignment.topCenter,
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //
            //       image: AssetImage(ImageUtility.helloCastBgImage),
            //      // fit: BoxFit.fill
            //      // fit: BoxFit.fill
            //   ),
            // ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageUtility.helloCastCardImage),
                        fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          // height: 12.h,
                          height: 14.5.h,
                        ),
                        Row(
                          children: [
                            const BackButton(
                              color: Colors.white,
                            ),
                            Text(
                             // context.loc.buttonIAmTalent,
                              "I’m a Casting",
                              style: StyleUtility.kantumruyProSMedium18TextStyle
                                  .copyWith(
                                fontSize: TextSizeUtility.textSize18.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          // height: 5.h,
                          height: 18.h,
                        ),
                        Text(
                        //  context.loc.helloCast,
                          "Hello Talent",
                          textAlign: TextAlign.center,
                          style: StyleUtility.extraLargeTextStyle.copyWith(
                              fontSize: TextSizeUtility.textSize40.sp),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                         // context.loc.helloCastDesc,
                          "Come and join us and get good opportunities for work in the field of acting, singing, modeling and more… Let the work find you!",
                          textAlign: TextAlign.center,
                          style:
                              StyleUtility.quicksandRegular15TextStyle.copyWith(
                            fontSize: TextSizeUtility.textSize15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                        CustomButton(
                          buttonText: context.loc.buttonNewHere,
                          buttonType: ButtonType.blue,
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.castSignupScreen,
                                arguments: {"userType": UserType.talent});
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomOutlineButton(
                          buttonText: context.loc.buttonLogin,
                          buttonColor: ColorUtility.color29244C,
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, RouteName.castLoginScreen);
                          },
                        ),
                        SizedBox(
                          // height: 57.h,
                          height: 40.h,
                        ),
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
