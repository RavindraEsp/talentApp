import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/models/audition_property_model.dart';
import 'package:talent_app/modules/casting/createAudition/providers/create_audition_provider.dart';
import 'package:talent_app/modules/casting/createAudition/widgets/select_unselect_widget.dart';
import 'package:talent_app/modules/casting/createAudition/widgets/yes_no_checkbox.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/utilities/validation.dart';
import 'package:talent_app/widgets/alertDialog/confirm_alert_dialog.dart';
import 'package:talent_app/widgets/alertDialog/success_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

import '../../../../utilities/common.dart';

class CreateAuditionScreen extends StatefulWidget {
  const CreateAuditionScreen({super.key});

  @override
  State<CreateAuditionScreen> createState() => _CreateAuditionScreenState();
}

class _CreateAuditionScreenState extends State<CreateAuditionScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Provider.of<CreateAuditionProvider>(context, listen: false).getTalentData(
        onFailure: (msg) {
      Common.showErrorToast(context, msg);
    });
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
          child: Consumer<CreateAuditionProvider>(
              builder: (context, createAuditionProvider, child) {
            return Column(
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
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 18.w,
                          right: 18.w,
                          // top: 24.h, bottom: 24.h
                          top: 14.h,
                          bottom: 14.h),
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
                                style: StyleUtility
                                    .kantumruyProSMedium18TextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize18.sp),
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
                  child: createAuditionProvider.isLoading == true
                      ? const CustomCircularLoaderWidget()
                      : SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 18.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.loc.titleAuditionDescription,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SimpleTextField(
                                  controller: createAuditionProvider
                                      .auditionDescriptionController,
                                  hintText: context.loc.hintAuditionDescription,
                                  maxLine: 4,
                                  validator:
                                      Validators(context).validatorDescription,
                                ),
                                SizedBox(height: 35.h),
                                Text(
                                  context.loc.titleImLookingForA,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Wrap(
                                  children: [
                                    for (var item in createAuditionProvider
                                        .lookingForModel!)
                                      LookingForWidget(
                                          onTap: () {
                                            item.isSelect = !item.isSelect;
                                            createAuditionProvider.updateUi();
                                          },
                                          item: item),
                                  ],
                                ),
                                SizedBox(
                                  height: 27.h,
                                ),
                                Text(
                                  context.loc.titleWorkExperienceNeeded,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    YesNoCheckBoxWidget(
                                        title: context.loc.checkBoxYes,
                                        status: createAuditionProvider
                                                .isExperienceNeeded ==
                                            true,
                                        onTap: () {
                                          createAuditionProvider
                                              .isExperienceNeeded = true;
                                          createAuditionProvider.updateUi();
                                        }),
                                    SizedBox(
                                      width: 38.h,
                                    ),
                                    YesNoCheckBoxWidget(
                                        title: context.loc.checkBoxNo,
                                        status: createAuditionProvider
                                                .isExperienceNeeded ==
                                            false,
                                        onTap: () {
                                          createAuditionProvider
                                              .isExperienceNeeded = false;
                                          createAuditionProvider.updateUi();
                                        }),
                                  ],
                                ),
                                SizedBox(
                                  height: 27.h,
                                ),
                                Text(
                                  context.loc.titleProfessionalTrainingNeeded,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    YesNoCheckBoxWidget(
                                        title: context.loc.checkBoxYes,
                                        status: createAuditionProvider
                                                .isTrainingNeeded ==
                                            true,
                                        onTap: () {
                                          createAuditionProvider
                                              .isTrainingNeeded = true;
                                          createAuditionProvider.updateUi();
                                        }),
                                    SizedBox(
                                      width: 38.h,
                                    ),
                                    YesNoCheckBoxWidget(
                                        title: context.loc.checkBoxNo,
                                        status: createAuditionProvider
                                                .isTrainingNeeded ==
                                            false,
                                        onTap: () {
                                          createAuditionProvider
                                              .isTrainingNeeded = false;
                                          createAuditionProvider.updateUi();
                                        }),
                                  ],
                                ),
                                SizedBox(
                                  height: 27.h,
                                ),
                                Text(
                                  context.loc.titleCandidateMustRepresented,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    YesNoCheckBoxWidget(
                                        title: context.loc.checkBoxYes,
                                        status: createAuditionProvider
                                                .isRepresented ==
                                            true,
                                        onTap: () {
                                          createAuditionProvider.isRepresented =
                                              true;
                                          createAuditionProvider.updateUi();
                                        }),
                                    SizedBox(
                                      width: 38.h,
                                    ),
                                    YesNoCheckBoxWidget(
                                        title: context.loc.checkBoxNo,
                                        status: createAuditionProvider
                                                .isRepresented ==
                                            false,
                                        onTap: () {
                                          createAuditionProvider.isRepresented =
                                              false;
                                          createAuditionProvider.updateUi();
                                        }),
                                  ],
                                ),
                                SizedBox(
                                  height: 27.h,
                                ),
                                Text(
                                  context.loc.titleAgeRange,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SimpleTextField(
                                        controller: createAuditionProvider
                                            .minAgeController,
                                        hintText: context.loc.hintMin,
                                        textInputType: TextInputType.number,
                                        validator:
                                            Validators(context).validatorMinAge,
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        child: Container(
                                          height: 1,
                                          width: 10.w,
                                          color: ColorUtility.colorD6D6D8,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SimpleTextField(
                                        controller: createAuditionProvider
                                            .maxAgeController,
                                        hintText: context.loc.hintMax,
                                        textInputType: TextInputType.number,
                                        validator:
                                            Validators(context).validatorMaxAge,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 27.h,
                                ),
                                Text(
                                  context.loc.titleWeightRange,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SimpleTextField(
                                        controller: createAuditionProvider
                                            .minWeightController,
                                        hintText: context.loc.hintMin,
                                        textInputType: TextInputType.number,
                                        validator: Validators(context)
                                            .validatorMinWeight,
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        child: Container(
                                          height: 1,
                                          width: 10.w,
                                          color: ColorUtility.colorD6D6D8,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SimpleTextField(
                                        controller: createAuditionProvider
                                            .maxWeightController,
                                        hintText: context.loc.hintMax,
                                        textInputType: TextInputType.number,
                                        validator: Validators(context)
                                            .validatorMaxWeight,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 27.h,
                                ),
                                Text(
                                  context.loc.titleHeightRange,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SimpleTextField(
                                        controller: createAuditionProvider
                                            .minHeightController,
                                        hintText: context.loc.hintMin,
                                        textInputType: TextInputType.number,
                                        validator: Validators(context)
                                            .validatorMinHeight,
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        child: Container(
                                          height: 1,
                                          width: 10.w,
                                          color: ColorUtility.colorD6D6D8,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SimpleTextField(
                                        controller: createAuditionProvider
                                            .maxHeightController,
                                        hintText: context.loc.hintMax,
                                        textInputType: TextInputType.number,
                                        validator: Validators(context)
                                            .validatorMaxHeight,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      context.loc.titleEyeColor,
                                      style: StyleUtility
                                          .quicksandSemiBold5457BETextStyle
                                          .copyWith(
                                              fontSize: TextSizeUtility
                                                  .textSize16.sp),
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        for (var item in createAuditionProvider
                                            .eyeColorModel!) {
                                          item.isSelect = true;
                                          createAuditionProvider.updateUi();
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(2.w),
                                        child: Text(
                                          "Select All",
                                          style: StyleUtility
                                              .quicksandMedium5457BETextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
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
                                    // for (var item in eyeColorModel!)
                                    for (var item in createAuditionProvider
                                        .eyeColorModel!)
                                      GestureDetector(
                                        onTap: () {
                                          item.isSelect = !item.isSelect;
                                          createAuditionProvider.updateUi();
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
                                                    color: ColorUtility
                                                        .colorD3D6D6)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  item.isSelect == false
                                                      ? ImageUtility.plusIcon
                                                      : ImageUtility
                                                          .crossSelectIcon,
                                                  width: 5.w,
                                                  height: 5.w,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  item.name ?? "",
                                                  style: StyleUtility
                                                      .quicksandRegularBlackTextStyle
                                                      .copyWith(
                                                          fontSize:
                                                              TextSizeUtility
                                                                  .textSize14
                                                                  .sp),
                                                ),
                                              ],
                                            )),
                                      )
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      context.loc.titleHairColor,
                                      style: StyleUtility
                                          .quicksandSemiBold5457BETextStyle
                                          .copyWith(
                                              fontSize: TextSizeUtility
                                                  .textSize16.sp),
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        for (var item in createAuditionProvider
                                            .hairColorModel!) {
                                          item.isSelect = true;
                                          createAuditionProvider.updateUi();
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(2.w),
                                        child: Text(
                                          "Select All",
                                          style: StyleUtility
                                              .quicksandMedium5457BETextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
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
                                    for (var item in createAuditionProvider
                                        .hairColorModel!)
                                      SelectUnselectWidget(
                                          onTap: () {
                                            item.isSelect = !item.isSelect;
                                            createAuditionProvider.updateUi();
                                          },
                                          item: item),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      context.loc.titlePansSize,
                                      style: StyleUtility
                                          .quicksandSemiBold5457BETextStyle
                                          .copyWith(
                                              fontSize: TextSizeUtility
                                                  .textSize16.sp),
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        for (var item in createAuditionProvider
                                            .painsSizeModel!) {
                                          item.isSelect = true;
                                          createAuditionProvider.updateUi();
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(2.w),
                                        child: Text(
                                          "Select All",
                                          style: StyleUtility
                                              .quicksandMedium5457BETextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
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
                                    for (var item in createAuditionProvider
                                        .painsSizeModel!)
                                      SelectUnselectWidget(
                                          onTap: () {
                                            item.isSelect = !item.isSelect;
                                            createAuditionProvider.updateUi();
                                          },
                                          item: item),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      context.loc.titleShirtSize,
                                      style: StyleUtility
                                          .quicksandSemiBold5457BETextStyle
                                          .copyWith(
                                              fontSize: TextSizeUtility
                                                  .textSize16.sp),
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        for (var item in createAuditionProvider
                                            .shirtSizeModel!) {
                                          item.isSelect = true;
                                          createAuditionProvider.updateUi();
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(2.w),
                                        child: Text(
                                          "Select All",
                                          style: StyleUtility
                                              .quicksandMedium5457BETextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
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
                                    for (var item in createAuditionProvider
                                        .shirtSizeModel!)
                                      SelectUnselectWidget(
                                          onTap: () {
                                            item.isSelect = !item.isSelect;
                                            createAuditionProvider.updateUi();
                                          },
                                          item: item),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      context.loc.titleShoeSize,
                                      style: StyleUtility
                                          .quicksandSemiBold5457BETextStyle
                                          .copyWith(
                                              fontSize: TextSizeUtility
                                                  .textSize16.sp),
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        for (var item in createAuditionProvider
                                            .shoeSizeModel!) {
                                          item.isSelect = true;
                                          createAuditionProvider.updateUi();
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(2.w),
                                        child: Text(
                                          "Select All",
                                          style: StyleUtility
                                              .quicksandMedium5457BETextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
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
                                    for (var item in createAuditionProvider
                                        .shoeSizeModel!)
                                      SelectUnselectWidget(
                                          onTap: () {
                                            item.isSelect = !item.isSelect;
                                            createAuditionProvider.updateUi();
                                          },
                                          item: item),
                                  ],
                                ),
                                SizedBox(
                                  height: 38.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomOutlineButton(
                                            buttonText: context
                                                .loc.buttonCancelAudition,
                                            onTap: () {
                                              showCancelDialog(
                                                  context: context,
                                                  onYesTap: () {
                                                    showAuditionCancelSuccessDialog(
                                                        context: context);
                                                  });
                                            },
                                            buttonColor:
                                                ColorUtility.color5457BE)),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: CustomButton(
                                        buttonText: context.loc.buttonNext,
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (createAuditionProvider
                                                    .getAllValue() ==
                                                true) {
                                              Navigator.pushNamed(
                                                  context,
                                                  RouteName
                                                      .createAuditionPlaceTimeScreen,
                                                  arguments: {
                                                    "description":
                                                        createAuditionProvider
                                                            .auditionDescriptionController
                                                            .text,
                                                    "workExperience":
                                                        createAuditionProvider
                                                                    .isExperienceNeeded ==
                                                                true
                                                            ? "1"
                                                            : "0",
                                                    "professionalTraining":
                                                        createAuditionProvider
                                                                    .isTrainingNeeded ==
                                                                true
                                                            ? "1"
                                                            : "0",
                                                    "candidateRepresentation":
                                                        createAuditionProvider
                                                                    .isRepresented ==
                                                                true
                                                            ? "1"
                                                            : "0",
                                                    "ageRangeMin":
                                                        createAuditionProvider
                                                            .minAgeController
                                                            .text,
                                                    "ageRangeMax":
                                                        createAuditionProvider
                                                            .maxAgeController
                                                            .text,
                                                    "weightRangeMin":
                                                        createAuditionProvider
                                                            .minWeightController
                                                            .text,
                                                    "weightRangeMax":
                                                        createAuditionProvider
                                                            .maxWeightController
                                                            .text,
                                                    "heightRangeMin":
                                                        createAuditionProvider
                                                            .minHeightController
                                                            .text,
                                                    "heightRangeMax":
                                                        createAuditionProvider
                                                            .maxHeightController
                                                            .text,
                                                    "careerTag":
                                                        createAuditionProvider
                                                            .selectedLookingForIds,
                                                    "auditionTalentAllData":
                                                        createAuditionProvider
                                                            .auditionTalentAllData,
                                                  });
                                            }
                                          }
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
            );
          }),
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
