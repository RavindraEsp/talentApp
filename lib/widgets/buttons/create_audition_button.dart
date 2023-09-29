import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class CreateAuditionButton extends StatelessWidget {
  final String buttonText;
  String? icon;
  final VoidCallback onTap;
  final ButtonType? buttonType;

  CreateAuditionButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
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
          onPressed: () {
            onTap();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r)),
          ),
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            alignment: Alignment.center,
            children: [
              Text(
                buttonText,
                maxLines: 1,
                style: StyleUtility.buttonTextStyle.copyWith(
                  fontSize: TextSizeUtility.textSize18.sp,
                ),
              ),
              icon != null
                  ? Container(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        icon ?? "",
                        height: 45,
                        color: Colors.white,
                        fit: BoxFit.fill,
                      ),
                    )
                  : const SizedBox(),
            ],
          )),
    );
  }
}
