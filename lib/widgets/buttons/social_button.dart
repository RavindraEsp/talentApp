import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class SocialButton extends StatelessWidget {
  final String buttonText;
  String? icon;
  final VoidCallback onTap;
  final ButtonType? buttonType;

  SocialButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
    this.icon,
    this.buttonType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(30.r);
    return Container(
      height: TextSizeUtility.buttonHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorUtility.colorEFEFEF,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
          onPressed: () {
            onTap();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(buttonText,
                  maxLines: 1,
                  style: StyleUtility.socialButtonTextStyle.copyWith(
                    fontSize: TextSizeUtility.textSize16.sp,
                  )),
              icon != null
                  ? SizedBox(
                      width: 15.w,
                    )
                  : const SizedBox(),
              icon != null
                  ? Image.asset(
                      icon ?? "",
                      height: 38.h,
                      fit: BoxFit.fill,
                    )
                  : const SizedBox(),
            ],
          )),
    );
  }
}
