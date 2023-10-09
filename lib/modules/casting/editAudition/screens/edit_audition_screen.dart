import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/createAudition/models/audition_property_model.dart';
import 'package:talent_app/modules/casting/createAudition/widgets/yes_no_checkbox.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/confirm_alert_dialog.dart';
import 'package:talent_app/widgets/alertDialog/success_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

class EditAuditionScreen extends StatefulWidget {
  const EditAuditionScreen({super.key});

  @override
  State<EditAuditionScreen> createState() => _EditAuditionScreenState();
}

class _EditAuditionScreenState extends State<EditAuditionScreen> {
  final _formKey = GlobalKey<FormState>();

  List<AuditionPropertyModel>? lookingForModel;
  List<AuditionPropertyModel>? eyeColorModel;
  List<AuditionPropertyModel>? hairColorModel;
  List<AuditionPropertyModel>? painsSizeModel;
  List<AuditionPropertyModel>? shirtSizeModel;
  List<AuditionPropertyModel>? shoeSizeModel;

  bool? isExperienceNeeded;
  bool? isTrainingNeeded;
  bool? isRepresented;

  TextEditingController auditionDescriptionController = TextEditingController();
  TextEditingController minAgeController = TextEditingController();
  TextEditingController maxAgeController = TextEditingController();
  TextEditingController minWeightController = TextEditingController();
  TextEditingController maxWeightController = TextEditingController();
  TextEditingController minHeightController = TextEditingController();
  TextEditingController maxHeightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    lookingForModel = [
      AuditionPropertyModel("Model", false),
      AuditionPropertyModel("Actor", false),
      AuditionPropertyModel("Network Star", false),
      AuditionPropertyModel("Singer", false),
      AuditionPropertyModel("Kid Star", false),
      AuditionPropertyModel("Kid Star", false),
      AuditionPropertyModel("Other Artist", false),
      AuditionPropertyModel("Dancer", false)
    ];

    eyeColorModel = [
      AuditionPropertyModel("Brown", false),
      AuditionPropertyModel("Blue", false),
      AuditionPropertyModel("Green", false),
      AuditionPropertyModel("Green-Grey", false),
      AuditionPropertyModel("Pale gold", false),
      AuditionPropertyModel("Black", false)
    ];

    hairColorModel = [
      AuditionPropertyModel("Brown", false),
      AuditionPropertyModel("Black", false),
      AuditionPropertyModel("Auburn", false),
      AuditionPropertyModel("Blond", false),
      AuditionPropertyModel("Gray", false),
      AuditionPropertyModel("Red", false),
      AuditionPropertyModel("White", false)
    ];

    painsSizeModel = [
      AuditionPropertyModel("XS", false),
      AuditionPropertyModel("S", false),
      AuditionPropertyModel("M", false),
      AuditionPropertyModel("L", false),
      AuditionPropertyModel("XL", false),
      AuditionPropertyModel("S/M", false),
      AuditionPropertyModel("M/L", false),
      AuditionPropertyModel("XXL", false),
      AuditionPropertyModel("XXXL", false)
    ];

    shirtSizeModel = [
      AuditionPropertyModel("XS", false),
      AuditionPropertyModel("S", false),
      AuditionPropertyModel("M", false),
      AuditionPropertyModel("L", false),
      AuditionPropertyModel("XL", false),
      AuditionPropertyModel("S/M", false),
      AuditionPropertyModel("M/L", false),
      AuditionPropertyModel("XXL", false),
      AuditionPropertyModel("XXXL", false)
    ];

    shoeSizeModel = [
      AuditionPropertyModel("36", false),
      AuditionPropertyModel("37", false),
      AuditionPropertyModel("38", false),
      AuditionPropertyModel("39", false),
      AuditionPropertyModel("40", false),
      AuditionPropertyModel("41", false),
      AuditionPropertyModel("42", false),
      AuditionPropertyModel("43", false),
      AuditionPropertyModel("44", false)
    ];
  }

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
                        left: 18.w, right: 18.w,
                      //  top: 24.h, bottom: 24.h
                        top: 14.h, bottom: 14.h
                    ),
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
                              context.loc.headerEditAudition,
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
                          context.loc.titleAuditionDescription,
                          style: StyleUtility.quicksandSemiBold5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SimpleTextField(
                          controller: auditionDescriptionController,
                          hintText: context.loc.hintAuditionDescription,
                          maxLine: 4,
                        ),
                        SizedBox(height: 35.h),
                        Text(
                          context.loc.titleImLookingForA,
                          style: StyleUtility.quicksandSemiBold5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize16.sp),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Wrap(
                          children: [
                            for (var item in lookingForModel!)
                              GestureDetector(
                                onTap: () {
                                  item.isSelect = !item.isSelect;
                                  setState(() {});
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        right: 9.w, bottom: 13.h),
                                    padding: EdgeInsets.only(
                                        left: 15.sp,
                                        right: 20.sp,
                                        top: 9.sp,
                                        bottom: 9.sp),
                                    decoration: BoxDecoration(
                                        color: item.isSelect == false
                                            ? ColorUtility.colorWhite
                                            : ColorUtility.colorEFF2F4,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        border: Border.all(
                                            color: ColorUtility.colorD3D6D6)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          item.isSelect == false
                                              ? ImageUtility.plusIcon
                                              : ImageUtility.crossSelectIcon,
                                          width: 5.w,
                                          height: 5.w,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          item.title,
                                          style: StyleUtility
                                              .quicksandRegularBlackTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
                                        ),
                                      ],
                                    )),
                              )
                          ],
                        ),
                        SizedBox(
                          height: 27.h,
                        ),
                        Text(
                          context.loc.titleWorkExperienceNeeded,
                          style: StyleUtility.quicksandSemiBold5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            YesNoCheckBoxWidget(
                                title: context.loc.checkBoxYes,
                                status: isExperienceNeeded == true,
                                onTap: () {
                                  isExperienceNeeded = true;
                                  setState(() {});
                                }),
                            SizedBox(
                              width: 38.h,
                            ),
                            YesNoCheckBoxWidget(
                                title: context.loc.checkBoxNo,
                                status: isExperienceNeeded == false,
                                onTap: () {
                                  isExperienceNeeded = false;
                                  setState(() {});
                                }),
                          ],
                        ),
                        SizedBox(
                          height: 27.h,
                        ),
                        Text(
                          context.loc.titleProfessionalTrainingNeeded,
                          style: StyleUtility.quicksandSemiBold5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            YesNoCheckBoxWidget(
                                title: context.loc.checkBoxYes,
                                status: isTrainingNeeded == true,
                                onTap: () {
                                  isTrainingNeeded = true;
                                  setState(() {});
                                }),
                            SizedBox(
                              width: 38.h,
                            ),
                            YesNoCheckBoxWidget(
                                title: context.loc.checkBoxNo,
                                status: isTrainingNeeded == false,
                                onTap: () {
                                  isTrainingNeeded = false;
                                  setState(() {});
                                }),
                          ],
                        ),
                        SizedBox(
                          height: 27.h,
                        ),
                        Text(
                          context.loc.titleCandidateMustRepresented,
                          style: StyleUtility.quicksandSemiBold5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            YesNoCheckBoxWidget(
                                title: context.loc.checkBoxYes,
                                status: isRepresented == true,
                                onTap: () {
                                  isRepresented = true;
                                  setState(() {});
                                }),
                            SizedBox(
                              width: 38.h,
                            ),
                            YesNoCheckBoxWidget(
                                title: context.loc.checkBoxNo,
                                status: isRepresented == false,
                                onTap: () {
                                  isRepresented = false;
                                  setState(() {});
                                }),
                          ],
                        ),
                        SizedBox(
                          height: 27.h,
                        ),
                        Text(
                          context.loc.titleAgeRange,
                          style: StyleUtility.quicksandSemiBold5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SimpleTextField(
                                controller: minAgeController,
                                hintText: context.loc.hintMin,
                                textInputType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              width: 29.w,
                            ),
                            Expanded(
                              child: SimpleTextField(
                                controller: maxAgeController,
                                hintText: context.loc.hintMax,
                                textInputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 27.h,
                        ),
                        Text(
                          context.loc.titleWeightRange,
                          style: StyleUtility.quicksandSemiBold5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SimpleTextField(
                                controller: minWeightController,
                                hintText: context.loc.hintMin,
                                textInputType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              width: 29.w,
                            ),
                            Expanded(
                              child: SimpleTextField(
                                controller: maxWeightController,
                                hintText: context.loc.hintMax,
                                textInputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 27.h,
                        ),
                        Text(
                          context.loc.titleHeightRange,
                          style: StyleUtility.quicksandSemiBold5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SimpleTextField(
                                controller: minHeightController,
                                hintText: context.loc.hintMin,
                                textInputType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              width: 29.w,
                            ),
                            Expanded(
                              child: SimpleTextField(
                                controller: maxHeightController,
                                hintText: context.loc.hintMax,
                                textInputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.loc.titleEyeColor,
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                for (var item in eyeColorModel!) {
                                  item.isSelect = true;
                                  setState(() {});
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(2.w),
                                child: Text(
                                  "Select All",
                                  style: StyleUtility
                                      .quicksandMedium5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize14.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Wrap(
                          children: [
                            for (var item in eyeColorModel!)
                              GestureDetector(
                                onTap: () {
                                  item.isSelect = !item.isSelect;
                                  setState(() {});
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        right: 9.w, bottom: 13.h),
                                    padding: EdgeInsets.only(
                                        left: 15.sp,
                                        right: 20.sp,
                                        top: 9.sp,
                                        bottom: 9.sp),
                                    decoration: BoxDecoration(
                                        color: item.isSelect == false
                                            ? ColorUtility.colorWhite
                                            : ColorUtility.colorEFF2F4,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        border: Border.all(
                                            color: ColorUtility.colorD3D6D6)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          item.isSelect == false
                                              ? ImageUtility.plusIcon
                                              : ImageUtility.crossSelectIcon,
                                          width: 5.w,
                                          height: 5.w,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          item.title,
                                          style: StyleUtility
                                              .quicksandRegularBlackTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
                                        ),
                                      ],
                                    )),
                              )
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.loc.titleHairColor,
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                for (var item in hairColorModel!) {
                                  item.isSelect = true;
                                  setState(() {});
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(2.w),
                                child: Text(
                                  "Select All",
                                  style: StyleUtility
                                      .quicksandMedium5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize14.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Wrap(
                          children: [
                            for (var item in hairColorModel!)
                              GestureDetector(
                                onTap: () {
                                  item.isSelect = !item.isSelect;
                                  setState(() {});
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        right: 9.w, bottom: 13.h),
                                    padding: EdgeInsets.only(
                                        left: 15.sp,
                                        right: 20.sp,
                                        top: 9.sp,
                                        bottom: 9.sp),
                                    decoration: BoxDecoration(
                                        color: item.isSelect == false
                                            ? ColorUtility.colorWhite
                                            : ColorUtility.colorEFF2F4,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        border: Border.all(
                                            color: ColorUtility.colorD3D6D6)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          item.isSelect == false
                                              ? ImageUtility.plusIcon
                                              : ImageUtility.crossSelectIcon,
                                          width: 5.w,
                                          height: 5.w,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          item.title,
                                          style: StyleUtility
                                              .quicksandRegularBlackTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
                                        ),
                                      ],
                                    )),
                              )
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.loc.titlePansSize,
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                for (var item in painsSizeModel!) {
                                  item.isSelect = true;
                                  setState(() {});
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(2.w),
                                child: Text(
                                  "Select All",
                                  style: StyleUtility
                                      .quicksandMedium5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize14.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Wrap(
                          children: [
                            for (var item in painsSizeModel!)
                              GestureDetector(
                                onTap: () {
                                  item.isSelect = !item.isSelect;
                                  setState(() {});
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        right: 9.w, bottom: 13.h),
                                    padding: EdgeInsets.only(
                                        left: 15.sp,
                                        right: 20.sp,
                                        top: 9.sp,
                                        bottom: 9.sp),
                                    decoration: BoxDecoration(
                                        color: item.isSelect == false
                                            ? ColorUtility.colorWhite
                                            : ColorUtility.colorEFF2F4,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        border: Border.all(
                                            color: ColorUtility.colorD3D6D6)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          item.isSelect == false
                                              ? ImageUtility.plusIcon
                                              : ImageUtility.crossSelectIcon,
                                          width: 5.w,
                                          height: 5.w,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          item.title,
                                          style: StyleUtility
                                              .quicksandRegularBlackTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
                                        ),
                                      ],
                                    )),
                              )
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.loc.titleShirtSize,
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                for (var item in shirtSizeModel!) {
                                  item.isSelect = true;
                                  setState(() {});
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(2.w),
                                child: Text(
                                  "Select All",
                                  style: StyleUtility
                                      .quicksandMedium5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize14.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Wrap(
                          children: [
                            for (var item in shirtSizeModel!)
                              GestureDetector(
                                onTap: () {
                                  item.isSelect = !item.isSelect;
                                  setState(() {});
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        right: 9.w, bottom: 13.h),
                                    padding: EdgeInsets.only(
                                        left: 15.sp,
                                        right: 20.sp,
                                        top: 9.sp,
                                        bottom: 9.sp),
                                    decoration: BoxDecoration(
                                        color: item.isSelect == false
                                            ? ColorUtility.colorWhite
                                            : ColorUtility.colorEFF2F4,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        border: Border.all(
                                            color: ColorUtility.colorD3D6D6)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          item.isSelect == false
                                              ? ImageUtility.plusIcon
                                              : ImageUtility.crossSelectIcon,
                                          width: 5.w,
                                          height: 5.w,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          item.title,
                                          style: StyleUtility
                                              .quicksandRegularBlackTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
                                        ),
                                      ],
                                    )),
                              )
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.loc.titleShoeSize,
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                for (var item in shoeSizeModel!) {
                                  item.isSelect = true;
                                  setState(() {});
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(2.w),
                                child: Text(
                                  "Select All",
                                  style: StyleUtility
                                      .quicksandMedium5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize14.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Wrap(
                          children: [
                            for (var item in shoeSizeModel!)
                              GestureDetector(
                                onTap: () {
                                  item.isSelect = !item.isSelect;
                                  setState(() {});
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        right: 9.w, bottom: 13.h),
                                    padding: EdgeInsets.only(
                                        left: 15.sp,
                                        right: 20.sp,
                                        top: 9.sp,
                                        bottom: 9.sp),
                                    decoration: BoxDecoration(
                                        color: item.isSelect == false
                                            ? ColorUtility.colorWhite
                                            : ColorUtility.colorEFF2F4,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        border: Border.all(
                                            color: ColorUtility.colorD3D6D6)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          item.isSelect == false
                                              ? ImageUtility.plusIcon
                                              : ImageUtility.crossSelectIcon,
                                          width: 5.w,
                                          height: 5.w,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          item.title,
                                          style: StyleUtility
                                              .quicksandRegularBlackTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
                                        ),
                                      ],
                                    )),
                              )
                          ],
                        ),
                        SizedBox(
                          height: 38.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: CustomOutlineButton(
                                    buttonText:
                                        context.loc.buttonCancelAudition,
                                    onTap: () {
                                      showCancelDialog(
                                          context: context,
                                          onYesTap: () {
                                            showAuditionCancelSuccessDialog(
                                                context: context);
                                          });
                                    },
                                    buttonColor: ColorUtility.color5457BE)),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: CustomButton(
                                buttonText: context.loc.buttonNext,
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      RouteName.editAuditionPlaceTimeScreen);
                                },
                                buttonType: ButtonType.yellow,
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

  Future<dynamic> showCancelDialog({
    required BuildContext context,
    required VoidCallback onYesTap,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return ConfirmAlertDialog(
            onYesTap: onYesTap,
            title: context.loc.dialogAreYouSureCancelAudition,
          );
        }).then((value) {});
  }

  Future<dynamic> showAuditionCancelSuccessDialog({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return SuccessAlertDialog(
            title: context.loc.dialogYouHaveCanceledAudition,
            description: context.loc.dialogCancelAuditionSuccessDescription,
            onCrossTap: () {},
          );
        }).then((value) {
      Navigator.pop(context);
    });
  }
}
