import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';

class ApprovedDialog extends StatelessWidget {
  final VoidCallback onAddMoreSpots;
  final VoidCallback onCloseRegistration;
  final String? buttonText;

  const ApprovedDialog({
    super.key,
    required this.onAddMoreSpots,
    this.buttonText, required this.onCloseRegistration,
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
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, top: 14.w, bottom: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                context.loc.dialogAuditionSlotsHasBeenFilledOut,
                style: StyleUtility.kantumruyProSemiBold5457BETextStyle
                    .copyWith(fontSize: TextSizeUtility.textSize24.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 13.h,
              ),
              Text(
                context.loc.dialogYouCan,
                style: StyleUtility.quicksandRegularBlackTextStyle
                    .copyWith(fontSize: TextSizeUtility.textSize16.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButtonTopToBottomColor(
                buttonText: context.loc.buttonAddThisCandidate,
                width: double.infinity,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomButton(
                buttonText: context.loc.buttonAddMoreSpots,
                onTap: () {
                  Navigator.pop(context);
                  onAddMoreSpots();
                },
                buttonType: ButtonType.yellow,
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomOutlineButton(
                buttonText: context.loc.buttonCloseRegistration,
                onTap: () {
                  Navigator.pop(context);
                  onCloseRegistration();
                },
                buttonColor: ColorUtility.color5457BE,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
