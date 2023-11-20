import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';

class ConfirmAlertDialog extends StatelessWidget {
  final VoidCallback onYesTap;
  final String? title;
  final String? buttonText;
  final UserType? userType;

  const ConfirmAlertDialog({
    super.key,
    required this.onYesTap,
    this.title,
    this.buttonText, this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.topCenter,
      insetPadding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: 12.w, right: 12.w, top: 14.w, bottom: 18.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  ImageUtility.crossIcon,
                  color: ColorUtility.color5457BE,
                  width: 15.w,
                  height: 15.w,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 17.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  title ?? "",
                  textAlign: TextAlign.center,
                  style: StyleUtility.quicksandRegularBlackTextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize18.sp),
                ),
              ),
              SizedBox(
                height: 23.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomOutlineButton(
                          //  buttonText: "No",
                            buttonText: context.loc.buttonNo,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            buttonColor: ColorUtility.color5457BE)),
                    SizedBox(
                      width: 12.w,
                    ),

                    Expanded(
                      child: CustomButton(
                          buttonText: context.loc.buttonYes,
                        //  buttonType: ButtonType.yellow,
                          buttonType:  userType == UserType.talent ? ButtonType.blue: ButtonType.yellow,
                          onTap: () {
                            Navigator.pop(context);
                            onYesTap();
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
