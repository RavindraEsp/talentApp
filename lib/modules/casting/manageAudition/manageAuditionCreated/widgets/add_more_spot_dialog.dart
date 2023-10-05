import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/createAudition/models/date_time_model.dart';
import 'package:talent_app/modules/casting/createAudition/widgets/date_time_row_widget.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

class AddMoreSpotDialog extends StatefulWidget {
  final VoidCallback onUpdateTap;
  final VoidCallback onBackTab;
  final String? title;
  final String? buttonText;

  const AddMoreSpotDialog({
    super.key,
    required this.onUpdateTap,
    this.title,
    this.buttonText,
    required this.onBackTab,
  });

  @override
  State<AddMoreSpotDialog> createState() => _AddMoreSpotDialogState();
}

class _AddMoreSpotDialogState extends State<AddMoreSpotDialog> {
  List<DateTimeModel>? dateTimeList = [];

  TextEditingController dateController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController spotsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
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
            padding: EdgeInsets.only(top: 5.w, bottom: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    child: BackButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onBackTab();
                      },
                    )),
                Text(
                  "Add More Spots",
                  style: StyleUtility.kantumruyProMedium5457BETextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize20.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 13.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          itemCount: dateTimeList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: DateTimeRowWidget(
                                    onRemoveIconTap: () {
                                      dateTimeList?.removeAt(index);
                                      setState(() {});
                                    },
                                    date: dateTimeList?[index].date ?? "",
                                    time: dateTimeList?[index].time ?? "",
                                    spots: dateTimeList?[index].spots ?? ""));
                          }),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: GestureDetector(
                                onTap: () {
                                  Common.selectDate(context, dateController);
                                },
                                child: SimpleTextField(
                                  controller: dateController,
                                  hintText: "DD/MM/YYYY",
                                  isEnable: false,
                                ),
                              )),
                          SizedBox(
                            width: 7.w,
                          ),
                          Expanded(
                              flex: 2,
                              child: SimpleTextField(
                                  controller: timeController,
                                  hintText: "00:00")),
                          SizedBox(
                            width: 7.w,
                          ),
                          Expanded(
                              flex: 2,
                              child: SimpleTextField(
                                controller: spotsController,
                                hintText: "0",
                                textInputType: TextInputType.number,
                              )),
                          SizedBox(
                            width: 7.w,
                          ),
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  if (dateController.text.isNotEmpty &&
                                      timeController.text.isNotEmpty &&
                                      spotsController.text.isNotEmpty) {
                                    dateTimeList?.add(DateTimeModel(
                                        dateController.text,
                                        timeController.text,
                                        spotsController.text));

                                    dateController.clear();
                                    timeController.clear();
                                    spotsController.clear();
                                  } else {
                                    Common.showErrorToast(
                                        context, "Please Fill All field");
                                  }

                                  setState(() {});
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: ColorUtility.color5457BE)),
                                    child: Center(
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 15.sp, bottom: 15.sp),
                                            child: Icon(
                                              Icons.add,
                                              size: 15.sp,
                                              color: ColorUtility.color5457BE,
                                            )))),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomButtonTopToBottomColor(
                        buttonText: context.loc.buttonUpdate,
                        width: double.infinity,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
