import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class AppliedUserDetailWidget extends StatelessWidget {
  const AppliedUserDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(right: 20.w, left: 20.w),
      child: Container(
        height: 420.sp,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageUtility.dummyAppliedUserImage),
              fit: BoxFit.fill),
        ),
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageUtility.userIcon,
                  color: Colors.white,
                  width: 18.w,
                  //  height: 22.w,
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Text(
                        "Michaela Cohoen 25",
                        style: StyleUtility.quicksandBoldWhiteTextStyle
                            .copyWith(fontSize: TextSizeUtility.textSize18.sp),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  ImageUtility.locationIcon,
                  color: Colors.white,
                  width: 20.w,
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Text(
                        "Rehovot",
                        style: StyleUtility.quicksandMediumWhiteTextStyle
                            .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(
                      ImageUtility.backCircleIcon,
                      width: 52.w,
                    ),
                    Text(
                      context.loc.buttonBack,
                      style: StyleUtility.quicksandMediumWhiteTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize12.sp),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      ImageUtility.declineCircleIcon,
                      width: 52.w,
                    ),
                    Text(
                      context.loc.decline,
                      style: StyleUtility.quicksandMediumWhiteTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize12.sp),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      ImageUtility.verifyGreenIcon,
                      width: 52.w,
                    ),
                    Text(
                    context.loc.approve,
                      style: StyleUtility.quicksandMediumWhiteTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize12.sp),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      ImageUtility.nextCircleIcon,
                      width: 52.w,
                    ),
                    Text(
                      context.loc.buttonNext,
                      style: StyleUtility.quicksandMediumWhiteTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize12.sp),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
