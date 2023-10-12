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

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
      body: Stack(
        children: [
          Container(
            height: 80.h,
            width: double.infinity,
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: ColorUtility.talentHeaderGradientColor)),
          ),
          SafeArea(
              child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageUtility.talentSignupBgImage),
                        fit: BoxFit.fill),
                  ),
                  child: Column(children: [
                    Container(
                      //  margin: EdgeInsets.only(left: 24.w, top: 12.h),
                      margin: EdgeInsets.only(left: 24.w, top: 22.h),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        centerTitle: true,
                        title: Text(
                          context.loc.headerSubscribe,
                          style: StyleUtility.headerTextStyle.copyWith(
                              fontSize: TextSizeUtility.textSize18.sp),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 18.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 25.h),
                              Text(
                                context.loc.welcome,
                                style: StyleUtility
                                    .kantumruyProSemiBold5457BETextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize26.sp),
                              ),
                              SizedBox(
                                height: 13.5.h,
                              ),
                              Text(
                                context.loc.subscribeDescriptionAtTheMoment,
                                style: StyleUtility
                                    .quicksandRegularBlackTextStyle
                                    .copyWith(
                                  fontSize: TextSizeUtility.textSize15.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                          color: ColorUtility.colorD6D6D8)),
                                  child: Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.topRight,
                                        child: Image.asset(
                                          ImageUtility.freeTrailImage,
                                          width: 88.w,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.w,
                                            right: 15.w,
                                            top: 14.sp,
                                            bottom: 16.sp),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              context.loc.weekly,
                                              style: StyleUtility
                                                  .kantumruyProSemiBold5457BETextStyle
                                                  .copyWith(
                                                      fontSize: TextSizeUtility
                                                          .textSize22.sp),
                                            ),
                                            SizedBox(
                                              height: 14.h,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                text: context
                                                    .loc.afterATrialPeriodYou,
                                                style: StyleUtility
                                                    .quicksandRegular9F9E9ETextStyle
                                                    .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize15.sp,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        " ${context.loc.fiveWeek}",
                                                    style: StyleUtility
                                                        .quicksandBold5457BETextStyle
                                                        .copyWith(
                                                      fontSize: TextSizeUtility
                                                          .textSize15.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            CustomButton(
                                              buttonText: context.loc
                                                  .buttonStartSevenDaysFreeTrial,
                                              buttonType: ButtonType.blue,
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    RouteName.castSignupScreen,
                                                    arguments: {
                                                      "userType":
                                                          UserType.talent
                                                    });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 25.h,
                              ),
                              Text(
                                context.loc.subscribeOnDemandWillChargeText,
                                style: StyleUtility
                                    .quicksandRegular9F9E9ETextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize10.sp),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 41.h,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  context.loc.byRegisteringYouConfirmThe,
                                  style: StyleUtility
                                      .quicksandRegular9F9E9ETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize12.sp),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    context.loc.policy,
                                    style: StyleUtility
                                        .quicksandRegular5457BETextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize12.sp),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    height: 17.sp,
                                    width: 1,
                                    color: ColorUtility.color6F6F6F,
                                  ),
                                  Text(
                                    context.loc.termsOfUse,
                                    style: StyleUtility
                                        .quicksandRegular5457BETextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize12.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 55.h,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                    text: context.loc.needHelp,
                                    style: StyleUtility
                                        .quicksandRegular8B8B8BTextStyle
                                        .copyWith(
                                      fontSize: TextSizeUtility.textSize12.sp,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: " ${context.loc.contactUs}",
                                        style: StyleUtility
                                            .quicksandRegular5457BETextStyle
                                            .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]))),
        ],
      ),
    );
  }
}
