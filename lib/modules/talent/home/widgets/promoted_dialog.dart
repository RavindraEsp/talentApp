import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';

class PromotedAlertDialog extends StatelessWidget {
  final String? title;

  const PromotedAlertDialog({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.topCenter,
      insetPadding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(9.r))),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorUtility.colorE03939,
                  ColorUtility.colorFFB62C,
                ]),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              bottomLeft: Radius.circular(10.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
              top: 14.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 3.sp, left: 3.sp, right: 3.sp),
                    child: Image.asset(
                      ImageUtility.crossIcon,
                      color: ColorUtility.colorWhite,
                      width: 15.w,
                      height: 15.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      ImageUtility.boostIcon,
                      width: 36.w,
                    )),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    title ?? "",
                    textAlign: TextAlign.center,
                    style: StyleUtility.kantumruyProMediumWhiteTextStyle
                        .copyWith(fontSize: TextSizeUtility.textSize22.sp),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
