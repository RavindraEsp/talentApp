import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class SearchTextField extends StatelessWidget {
   SearchTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.textInputType,
    this.passwordObscure,
    this.maxLine = 1,
    this.inputFormatter,
    this.suffixImage,
    this.validator,
    this.isEnable = true,
     this.onChange,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType? textInputType;
  final bool? passwordObscure;
  final int? maxLine;
  final List<TextInputFormatter>? inputFormatter;
  final String? suffixImage;

  final FormFieldValidator? validator;
  final bool? isEnable;
   ValueChanged<String>? onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
     // height: 55,
      child: TextFormField(
        enabled: isEnable,
        obscureText: passwordObscure ?? false,
        controller: controller,
        validator: validator,
        textAlign: TextAlign.start,
        keyboardType: textInputType ?? TextInputType.text,
        maxLines: maxLine ?? 1,
        style: StyleUtility.inputTextStyle.copyWith(
          fontSize: TextSizeUtility.textSize15.sp,
        ),
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: inputFormatter,
        onChanged: (value){

          onChange?.call(value);
        },
        decoration: InputDecoration(

          contentPadding: EdgeInsets.only(left: 20.w, top: 16, bottom: 16, right: 5.w),
          filled: true,
          fillColor: Colors.white,
          hintStyle: StyleUtility.hintTextStyle.copyWith(
            fontSize: TextSizeUtility.textSize15.sp,
          ),
          hintText: hintText,
          label: maxLine == 1
              ? Text(
                  hintText,
                  textAlign: TextAlign.start,
                )
              : null,
          labelStyle: StyleUtility.labelTextStyle
              .copyWith(fontSize: TextSizeUtility.textSize13.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: ColorUtility.colorD6D6D8,
            ),
          ),
          errorStyle: StyleUtility.errorTextStyle
              .copyWith(fontSize: TextSizeUtility.textSize13.sp),
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
          prefixIcon: SizedBox(
            height: 55.sp,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.sp),
              child: Image.asset(
                ImageUtility.searchIcon,
                height: 5.h,
                // color: Colors.blue,
              ),
            ),
          ),
          focusColor: Colors.white,
        ),
      ),
    );
  }
}
