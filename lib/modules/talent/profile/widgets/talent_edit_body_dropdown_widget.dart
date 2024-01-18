


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/modules/talent/profile/model/talent_body_response_model.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class TalentEditBodyDropDownWidget extends StatelessWidget {
  const TalentEditBodyDropDownWidget({
    super.key,
    required this.ovValueChange,
    required this.dropDownList,
    required this.selectItem,
    required this.hintText,
  });

  final ValueChanged<EyeColorArr> ovValueChange;

  final List<EyeColorArr>? dropDownList;
  final EyeColorArr? selectItem;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: ColorUtility.colorD6D6D8,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<EyeColorArr>(
          value: selectItem,
          items: dropDownList?.map((EyeColorArr items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items.option ?? "",
                style: StyleUtility.inputTextStyle
                    .copyWith(fontSize: TextSizeUtility.textSize15.sp),
              ),
            );
          }).toList(),
          isExpanded: true,
          icon: SizedBox(
            height: 10.h,
            child: Image.asset(ImageUtility.dropDownArrowIcon),
          ),
          underline: Container(
            color: ColorUtility.colorD6D6D8,
          ),
          hint: Text(
            hintText,
            style: StyleUtility.hintTextStyle
                .copyWith(fontSize: TextSizeUtility.textSize15.sp),
          ),
          onChanged: (EyeColorArr? value) {

            ovValueChange.call(value!);
          },
        ),
      ),
    );
  }
}