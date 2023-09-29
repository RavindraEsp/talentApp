import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class DateTimeRowWidget extends StatelessWidget {
  final VoidCallback onRemoveIconTap;
  final String date;
  final String time;
  final String spots;

  const DateTimeRowWidget(
      {super.key,
        required this.onRemoveIconTap,
        required this.date,
        required this.time,
        required this.spots});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 4,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: ColorUtility.color5457BE)),
                child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.sp, bottom: 15.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageUtility.calenderIcon,
                            width: 14.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            date,
                            style: StyleUtility.quicksandRegular5457BETextStyle
                                .copyWith(fontSize: TextSizeUtility.textSize15),
                          ),
                        ],
                      ),
                    )))),
        SizedBox(
          width: 7.w,
        ),
        Expanded(
            flex: 2,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: ColorUtility.color5457BE)),
                child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.sp, bottom: 15.sp),
                      child: Text(
                        time,
                        style: StyleUtility.quicksandRegular5457BETextStyle
                            .copyWith(fontSize: TextSizeUtility.textSize15),
                      ),
                    )))),
        SizedBox(
          width: 7.w,
        ),
        Expanded(
            flex: 2,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: ColorUtility.color5457BE)),
                child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.sp, bottom: 15.sp),
                      child: Text(
                        spots,
                        style: StyleUtility.quicksandRegular5457BETextStyle
                            .copyWith(fontSize: TextSizeUtility.textSize15),
                      ),
                    )))),
        SizedBox(
          width: 7.w,
        ),
        Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: onRemoveIconTap,
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorUtility.colorE24848)),
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.only(top: 15.sp, bottom: 15.sp),
                          child: Icon(
                            Icons.remove,
                            size: 15.sp,
                            color: ColorUtility.colorE24848,
                          )))),
            )),
      ],
    );
  }
}
