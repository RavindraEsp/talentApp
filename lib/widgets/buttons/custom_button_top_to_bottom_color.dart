import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class CustomButtonTopToBottomColor extends StatelessWidget {
  final String buttonText;
  String? icon;
  double? height;
  double? width;
  double? padding;
  final VoidCallback? onTap;
  final ButtonType? buttonType;
  final TextStyle? textStyle;

  CustomButtonTopToBottomColor({
    Key? key,
    required this.buttonText,
    this.onTap,
    this.icon,
    this.height,
    this.width,
    this.padding,
    this.buttonType,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Gradient gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: buttonType == ButtonType.yellow
            ? [
                ColorUtility.colorD09B45,
                ColorUtility.colorD6A34C,
                ColorUtility.colorFAD175,
              ]:
        buttonType == ButtonType.green
        ? [
          ColorUtility.color4FCC48,
          ColorUtility.color31B42C,
          ColorUtility.color1B9D16
    ]
            : [
                ColorUtility.color703297,
                ColorUtility.color65389A,
                ColorUtility.color445DB8
              ]);
    final borderRadius = BorderRadius.circular(30.r);
    return Container(
      height: height ?? TextSizeUtility.buttonHeight,
      width: width,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent.withOpacity(0.1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding ?? 10.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon != null
                    ? Image.asset(
                        icon ?? "",
                        height: 20.h,
                        color: Colors.white,
                      )
                    : const SizedBox(),
                icon != null
                    ? SizedBox(
                        width: 15.w,
                      )
                    : const SizedBox(),
                Text(buttonText,
                    maxLines: 1,
                    style: textStyle ?? StyleUtility.buttonTextStyle.copyWith(
                      fontSize: height == null
                          ? TextSizeUtility.textSize18.sp
                          : TextSizeUtility.textSize16.sp,
                    )),
              ],
            ),
          )),
    );
  }
}
