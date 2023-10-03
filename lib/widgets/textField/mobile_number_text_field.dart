import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class MobileNumberTextField extends StatelessWidget {
  const MobileNumberTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;

  final ValueChanged<PhoneNumber> onChanged;
  final String hintText;

  final FormFieldValidator? validator;

  @override
  Widget build(BuildContext context) {
    PhoneNumber? phoneNumber;
    return IntlPhoneField(
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        validator: validator,
        textAlign: TextAlign.left,
        style: StyleUtility.inputTextStyle.copyWith(
          fontSize: TextSizeUtility.textSize15.sp,
        ),
        dropdownIconPosition: IconPosition.trailing,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(

          contentPadding:
              EdgeInsets.only(left: 20.w, top: 16, bottom: 16, right: 5.w),
          filled: true,
          fillColor: Colors.white,
          hintStyle: StyleUtility.hintTextStyle.copyWith(
            fontSize: TextSizeUtility.textSize15.sp,
          ),
          hintText: hintText,
          label: Text(hintText),
          labelStyle: StyleUtility.labelTextStyle.copyWith(
              fontSize: TextSizeUtility.textSize13.sp
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: ColorUtility.colorD6D6D8,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: ColorUtility.colorD6D6D8,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: ColorUtility.colorD6D6D8,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: ColorUtility.color5457BE, // focused color
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: ColorUtility.colorD6D6D8,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: ColorUtility.colorD6D6D8,
            ),
          ),
          focusColor: Colors.white,
        ),
        initialCountryCode: 'IL',
        onChanged: (phone) {
          onChanged.call(phone);
          phoneNumber = phone;
          // print("Phone $phone");
        },
        onCountryChanged: (country) {
          controller.clear();
        },
        dropdownIcon:
            const Icon(Icons.arrow_drop_down, color: ColorUtility.color5457BE));
  }
}
