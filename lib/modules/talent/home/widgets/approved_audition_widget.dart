import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/confirm_alert_dialog.dart';
import 'package:talent_app/widgets/alertDialog/success_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';

class ApprovedAuditionWidget extends StatelessWidget {
  const ApprovedAuditionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 20.h, top: 15.h),
        itemCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(
                  context,
                  RouteName
                      .auditionDetailScreen,
                  arguments: {
                    "auditionDetailType":
                    AuditionDetailType
                        .approved
                  });
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 18.h),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5), //color of shadow
                  //     spreadRadius: 0, //spread radius
                  //     blurRadius: 7, // blur radius
                  //     //   offset: Offset(0, 2), // changes position of shadow
                  //     offset: Offset(0, 0), // changes position of shadow
                  //   ),
                  //   //you can set more BoxShadow() here
                  // ],
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 15,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorUtility.color4FCC48,
                                ColorUtility.color31B42C,
                                ColorUtility.color1B9D16
                              ]),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            bottomLeft: Radius.circular(10.r),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ImageUtility.calenderVerifiedIcon,
                                        width: 14.w,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "Audition Date 18/8/2023",
                                        style: StyleUtility
                                            .quicksandRegular8B8B8BTextStyle
                                            .copyWith(
                                                fontSize: TextSizeUtility
                                                    .textSize13.sp),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ImageUtility.clockIcon,
                                        width: 14.w,
                                        color: ColorUtility.color4FCC48,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "09:00",
                                        style: StyleUtility
                                            .quicksandRegular8B8B8BTextStyle
                                            .copyWith(
                                                fontSize: TextSizeUtility
                                                    .textSize13.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                "Actors are needed for a variety of roles Extras and more",
                                style: StyleUtility.quicksandRegularBlackTextStyle
                                    .copyWith(
                                  fontSize: TextSizeUtility.textSize16.sp,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 18.h,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  showWithdrawDialog(context: context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    context.loc.withdraw,
                                    style: StyleUtility
                                        .kantumruyProRegular5457BETextStyle
                                        .copyWith(
                                            decoration: TextDecoration.underline),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 17.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<dynamic> showWithdrawDialog({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return ConfirmAlertDialog(
            userType: UserType.talent,
            onYesTap: () {
              showWithdrawAuditionSuccessDialog(context: context);
            },
            title: context.loc.dialogAreYouSureYouWantToWithdrawYourApplication,
          );
        }).then((value) {});
  }

  Future<dynamic> showWithdrawAuditionSuccessDialog({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return SuccessAlertDialog(
            title: context.loc.dialogWithdrawSuccessTitle,
            description: context.loc.dialogWithdrawSuccessDescription,
            onCrossTap: () {},
          );
        }).then((value) {});
  }
}
