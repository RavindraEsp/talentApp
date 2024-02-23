import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class CustomOutlineButton extends StatelessWidget {
  final String buttonText;
  final String? icon;
  final Color buttonColor;
  final VoidCallback onTap;

  const CustomOutlineButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
    this.icon,
    required this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TextSizeUtility.buttonHeight.h,
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          side: BorderSide(color: buttonColor, width: 1),
        ),
        onPressed: onTap,
        child: Text(
          buttonText,
          maxLines: 1,
          style: StyleUtility.buttonTextStyle.copyWith(
              color: buttonColor, fontSize: TextSizeUtility.textSize18.sp),
        ),
      ),
    );
  }
}

//   return TextButton(
//       onPressed: onTab,
//       style: OutlinedButton.styleFrom(
//         fixedSize: Size(MediaQuery.of(context).size.width, 50),
//       ),
//       child: Text(
//           buttonText,
//           maxLines: 1,
//           style: StyleUtility.buttonTextStyle.copyWith(
//               color: ColorUtility.color282828
//           )
//       ));
