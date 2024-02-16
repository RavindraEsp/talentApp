
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class NoDataWidget extends StatelessWidget {
 final String? title;
  const NoDataWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(title ?? "No Data",
      style: StyleUtility.quicksandRegularBlackTextStyle.copyWith(
        fontSize: TextSizeUtility.textSize16.sp
      ),),
    );
  }
}
