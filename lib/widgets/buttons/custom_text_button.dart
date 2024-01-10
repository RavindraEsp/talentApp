import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class CustomTextButton extends StatelessWidget {
  final String buttonText;
  double? height;
  double? width;
  final VoidCallback? onTap;


  CustomTextButton({
    Key? key,
    required this.buttonText,
    this.onTap,

    this.height,
    this.width,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: TextSizeUtility.buttonHeight,
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent.withOpacity(0.1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child:Center(child:
            Text(buttonText,
                maxLines: 1,
                style: StyleUtility.buttonTextStyle.copyWith(
                    fontSize: TextSizeUtility.textSize18.sp
                    ,
                    color: ColorUtility.color5457BE

                )),)
          )),
    );
  }
}
