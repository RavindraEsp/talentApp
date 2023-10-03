import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';

class CustomOtpTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomOtpTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
        appContext: context,
        pastedTextStyle: const TextStyle(
          color: ColorUtility.colorD6D6D8,
          fontWeight: FontWeight.bold,
        ),
        length: 4,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          activeColor: ColorUtility.colorD6D6D8,
          inactiveColor: ColorUtility.colorD6D6D8,
          disabledColor: ColorUtility.colorD6D6D8,
          activeFillColor: ColorUtility.colorFFFFFF,
          selectedFillColor: ColorUtility.colorFFFFFF,
          inactiveFillColor: ColorUtility.colorFFFFFF,
          selectedColor: ColorUtility.colorD6D6D8,
          shape: PinCodeFieldShape.box,
          fieldOuterPadding: const EdgeInsets.all(6.0),
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 70.h,
          fieldWidth: 75.w,
        ),
        cursorColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        controller: controller,
        keyboardType: TextInputType.number,
        textStyle: StyleUtility.quicksandSemiBold5457BETextStyle
            .copyWith(color: ColorUtility.color5457BE),
        boxShadows: const [
          BoxShadow(
            color: Colors.black12,
          )
        ],
        onCompleted: (v) {
          AppLogger.logD("Completed");
        },
        onChanged: (value) {
          AppLogger.logD(value);
        },
        beforeTextPaste: (text) {
          AppLogger.logD("Allowing to paste $text");
          return true;
        });
  }
}
