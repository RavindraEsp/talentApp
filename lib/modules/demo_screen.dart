import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class DateOfBirthdayWidget extends StatefulWidget {
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;

  ValueChanged<int>? onYearChange;
  ValueChanged<int>? onMonthChange;
  ValueChanged<int>? onDayChange;

  DateOfBirthdayWidget(
      {super.key,
      required this.selectedDay,
      required this.selectedMonth,
      required this.selectedYear,

      required this.onYearChange,
      required this.onMonthChange,
      required this.onDayChange,

});

  @override
  State<DateOfBirthdayWidget> createState() => _DateOfBirthdayWidgetState();
}

class _DateOfBirthdayWidgetState extends State<DateOfBirthdayWidget> {
  List<int> days = List.generate(31, (index) => index + 1); // 1-31
  List<int> months = List.generate(12, (index) => index + 1); // 1-12
  List<int> years = List.generate(
      100, (index) => DateTime.now().year - index); // Last 100 years

  void updateDays() {
    AppLogger.logD("updateDays called");

    int month = widget.selectedMonth ?? 1;
    int year = widget.selectedYear ?? DateTime.now().year;
    int dayCount;
    if (month == 2) {
      dayCount =
          (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ? 29 : 28;
    } else if ([4, 6, 9, 11].contains(month)) {
      dayCount = 30;
    } else {
      dayCount = 31;
    }

    // Update days list
    days = List.generate(dayCount, (index) => index + 1);

    // Check if the currently selected day is valid after the update
    if (widget.selectedDay != null && (widget.selectedDay! > dayCount)) {
      // If not, reset selectedDay to null or adjust as needed
      widget.selectedDay = null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: ColorUtility.colorD6D6D8,
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              isExpanded: false,
              hint: Text(
                "Month",
                style: StyleUtility.hintTextStyle
                    .copyWith(fontSize: TextSizeUtility.textSize15.sp),
                textAlign: TextAlign.center,
              ),
              value: widget.selectedMonth,
              items: months.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString().padLeft(2, '0'),
                    style: StyleUtility.inputTextStyle
                        .copyWith(fontSize: TextSizeUtility.textSize15.sp),
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
              icon: SizedBox(
                height: 8.h,
                child: Padding(
                    padding: EdgeInsets.only(left: 7.w),
                    child: Image.asset(ImageUtility.dropDownArrowIcon)),
              ),
              underline: Container(
                color: ColorUtility.colorD6D6D8,
              ),
              onChanged: (newValue) {
                setState(() {
                  widget.selectedMonth = newValue;
                  updateDays();
                  widget.onMonthChange?.call(newValue!);
                });
              },
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              hint: Text(
                "Day",
                style: StyleUtility.hintTextStyle
                    .copyWith(fontSize: TextSizeUtility.textSize15.sp),
                textAlign: TextAlign.center,
              ),
              value: widget.selectedDay,
              items: days.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString().padLeft(2, '0'),
                    style: StyleUtility.inputTextStyle
                        .copyWith(fontSize: TextSizeUtility.textSize15.sp),
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
              icon: SizedBox(
                height: 8.h,
                child: Padding(
                    padding: EdgeInsets.only(left: 7.w),
                    child: Image.asset(ImageUtility.dropDownArrowIcon)),
              ),
              underline: Container(
                color: ColorUtility.colorD6D6D8,
              ),
              onChanged: (newValue) {
                setState(() {
                  widget.selectedDay = newValue;
                  widget.onDayChange?.call(newValue!);
                  updateDays();
                });
              },
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              hint: Text(
                "Year",
                style: StyleUtility.hintTextStyle
                    .copyWith(fontSize: TextSizeUtility.textSize15.sp),
                textAlign: TextAlign.center,
              ),
              value: widget.selectedYear,
              items: years.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: StyleUtility.inputTextStyle
                        .copyWith(fontSize: TextSizeUtility.textSize15.sp),
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
              icon: SizedBox(
                height: 8.h,
                child: Padding(
                    padding: EdgeInsets.only(left: 7.w),
                    child: Image.asset(ImageUtility.dropDownArrowIcon)),
              ),
              underline: Container(
                color: ColorUtility.colorD6D6D8,
              ),
              onChanged: (newValue) {
                setState(() {
                  widget.selectedYear = newValue;
                  widget.onYearChange?.call(newValue!);
                  updateDays();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
