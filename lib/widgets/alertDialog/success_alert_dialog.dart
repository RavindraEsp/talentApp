import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class SuccessAlertDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final String? buttonText;
  final VoidCallback onCrossTap;

  const SuccessAlertDialog({
    super.key,
    this.title,
    this.description,
    this.buttonText,
    required this.onCrossTap,
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
              EdgeInsets.only(left: 12.w, right: 12.w, top: 14.w, bottom: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                    onCrossTap();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.sp),
                    child: Image.asset(
                      ImageUtility.crossIcon,
                      color: ColorUtility.color5457BE,
                      width: 15.w,
                      height: 15.w,
                      fit: BoxFit.contain,
                    ),
                  ),
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
                  style: StyleUtility.kantumruyProSemiBold5457BETextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize22.sp),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  description ?? "",
                  textAlign: TextAlign.center,
                  style: StyleUtility.quicksandRegularBlackTextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize18.sp),
                ),
              ),
              SizedBox(
                height: 23.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
