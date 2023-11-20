import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';

class CongratulationAlertDialog extends StatelessWidget {
  final VoidCallback onButtonTap;
  final String? title;
  final String? description;
  final String? buttonText;
  final String? image;
  final UserType? userType;

  const CongratulationAlertDialog({
    super.key,
    required this.onButtonTap,
    this.title,
    this.description,
    this.buttonText,
    this.image,
    this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
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
            padding: EdgeInsets.only(
                left: 19.w, right: 19.w, top: 24.w, bottom: 18.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                image != null
                    ? Image.asset(
                        image!,
                        width: 87.w,
                        fit: BoxFit.contain,
                      )
                    : const SizedBox(),
                SizedBox(
                  height: 13.h,
                ),
                Text(
                  title ?? "",
                  style: StyleUtility.mulishBold5457BETextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize28.sp),
                ),
                image != null
                    ? SizedBox(
                        height: 13.h,
                      )
                    : SizedBox(
                        height: 28.h,
                      ),
                Text(
                  description ?? "",
                  style: StyleUtility.mulishRegular16TextStyle.copyWith(
                    fontSize: TextSizeUtility.textSize18.sp,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                image != null
                    ? SizedBox(
                        height: 19.h,
                      )
                    : SizedBox(
                        height: 34.h,
                      ),
                SizedBox(
                  height: 19.h,
                ),
                CustomButton(
                    buttonText: buttonText ?? "",
                    // buttonType: ButtonType.yellow,
                    buttonType: userType == UserType.cast
                        ? ButtonType.yellow
                        : ButtonType.blue,
                    onTap: () {
                      Navigator.pop(context);
                      onButtonTap();
                    })
              ],
            ),
          ),
        ),
      );
    });
  }
}
