import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class YesNoCheckBoxWidget extends StatelessWidget {
  final String title;
  final bool status;
  final VoidCallback? onTap;

  const YesNoCheckBoxWidget(
      {super.key,
        required this.title,
        required this.status,
         this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorUtility.colorD6D6D8)),
            child: Center(
              child: status == true
                  ? Image.asset(
                ImageUtility.checkIcon,
                width: 16.w,
              )
                  : const SizedBox(),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          title,
          style: StyleUtility.quicksandRegularBlackTextStyle
              .copyWith(fontSize: TextSizeUtility.textSize16.sp),
        )
      ],
    );
  }
}
