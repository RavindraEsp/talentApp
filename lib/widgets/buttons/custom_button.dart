import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  String? icon;
  final VoidCallback? onTap;
  final ButtonType? buttonType;

  CustomButton({
    Key? key,
    required this.buttonText,
     this.onTap,
    this.icon,
    this.buttonType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Gradient gradient = LinearGradient(
        colors: buttonType == ButtonType.yellow
            ? [
                ColorUtility.colorD09B45,
                ColorUtility.colorD6A34C,
                ColorUtility.colorFAD175,
              ]
            : [
                ColorUtility.color703297,
                ColorUtility.color65389A,
                ColorUtility.color445DB8
              ]);
    final borderRadius = BorderRadius.circular(30.r);
    return Container(
      height: TextSizeUtility.buttonHeight,
      width: MediaQuery.of(context).size.width,
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
          child: Row(
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
                  maxLines: 1, style: StyleUtility.buttonTextStyle.copyWith(
                    fontSize: TextSizeUtility.textSize18.sp,
                  )),
            ],
          )),
    );
  }
}
