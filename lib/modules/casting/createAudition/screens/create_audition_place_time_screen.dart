import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/createAudition/models/date_time_model.dart';
import 'package:talent_app/modules/casting/createAudition/widgets/date_time_row_widget.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/success_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

class CreateAuditionPlaceTimeScreen extends StatefulWidget {
  const CreateAuditionPlaceTimeScreen({super.key});

  @override
  State<CreateAuditionPlaceTimeScreen> createState() =>
      _CreateAuditionPlaceTimeScreenState();
}

class _CreateAuditionPlaceTimeScreenState
    extends State<CreateAuditionPlaceTimeScreen> {
  final _formKey = GlobalKey<FormState>();
  List<DateTimeModel>? dateTimeList = [];
  TextEditingController auditionDescriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController spotsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
      body: Form(
        key: _formKey,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            CommonMethod.hideKeyBoard(context);
          },
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.r),
                        bottomRight: Radius.circular(40.r)),
                    gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          ColorUtility.color1B215C,
                          ColorUtility.color263287,
                          ColorUtility.color857784,
                          ColorUtility.colorEFC275,
                        ])),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 18.w, right: 18.w, top: 24.h, bottom: 24.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SettingButtonWidget(),
                        Row(
                          children: [
                            const BackButton(
                              color: Colors.white,
                            ),
                            Text(
                              context.loc.headerCreateAnAudition,
                              style: StyleUtility.kantumruyProSMedium18TextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize18.sp),
                            ),
                          ],
                        ),
                        const MenuButtonWidget()
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 18.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.loc.titleAuditionLocation,
                          style: StyleUtility.quicksandSemiBold5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SimpleTextField(
                          controller: auditionDescriptionController,
                          hintText: "Location picker",
                          maxLine: 1,
                        ),
                        SizedBox(height: 15.h),
                        SizedBox(
                          height: 170.sp,
                          child: GoogleMap(
                            initialCameraPosition: const CameraPosition(
                                tilt: 50,
                                target: LatLng(22.719568, 75.857727),
                                zoom: 15),
                            onMapCreated: (GoogleMapController controller) {},
                          ),
                        ),
                        SizedBox(height: 36.h),
                        Text(
                          context.loc.createAuditionDateTimeDesc,
                          style: StyleUtility.quicksandRegularBlackTextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize16.sp),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Center(
                                    child: Text(
                                  context.loc.titleDate,
                                  style: StyleUtility
                                      .quicksandRegular5457BETextStyle
                                      .copyWith(
                                          fontSize: TextSizeUtility.textSize15),
                                ))),
                            SizedBox(
                              width: 7.w,
                            ),
                            Expanded(
                                flex: 2,
                                child: Center(
                                    child: Text(
                                  context.loc.titleTime,
                                  style: StyleUtility
                                      .quicksandRegular5457BETextStyle
                                      .copyWith(
                                          fontSize: TextSizeUtility.textSize15),
                                ))),
                            SizedBox(
                              width: 7.w,
                            ),
                            Expanded(
                                flex: 2,
                                child: Center(
                                    child: Text(
                                  context.loc.titleSpots,
                                  style: StyleUtility
                                      .quicksandRegular5457BETextStyle
                                      .copyWith(
                                          fontSize: TextSizeUtility.textSize15),
                                ))),
                            SizedBox(
                              width: 7.w,
                            ),
                            const Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
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
                                      Common.showErrorSnackBar(
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
                          height: 35.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomOutlineButton(
                                  buttonText: context.loc.buttonBack,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  buttonColor: ColorUtility.color5457BE),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Expanded(
                              child: CustomButton(
                                buttonText: context.loc.buttonPublish,
                                buttonType: ButtonType.yellow,
                                onTap: () {
                                  showAuditionAuditionCreateSuccessDialog(
                                      context: context);
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showAuditionAuditionCreateSuccessDialog({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return SuccessAlertDialog(
            title: "Good job!",
            description:
                "You successfully manage to set up an audition. Take a seat, unwind, and allow the registration process to begin as we wait for participants to sign up.",
            onCrossTap: () {},
          );
        }).then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }
}
