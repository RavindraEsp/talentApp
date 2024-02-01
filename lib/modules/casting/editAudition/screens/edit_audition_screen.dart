import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/models/audition_property_model.dart';
import 'package:talent_app/modules/casting/createAudition/screens/create_audition_screen.dart';
import 'package:talent_app/modules/casting/createAudition/widgets/select_unselect_widget.dart';
import 'package:talent_app/modules/casting/createAudition/widgets/yes_no_checkbox.dart';
import 'package:talent_app/modules/casting/editAudition/provider/edit_audition_screen_provider.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
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

class EditAuditionScreen extends StatefulWidget {
  final int auditionId;
  const EditAuditionScreen({super.key, required this.auditionId});

  @override
  State<EditAuditionScreen> createState() => _EditAuditionScreenState();
}

class _EditAuditionScreenState extends State<EditAuditionScreen> {
  @override
  void initState() {
    super.initState();

    AppLogger.logD("auditionId ${widget.auditionId}");

    Provider.of<EditAuditionScreenProvider>(context, listen: false)
        .getAuditionDetailById(widget.auditionId, onFailure: (message) {
      Common.showErrorSnackBar(context, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
      body: Consumer<EditAuditionScreenProvider>(
          builder: (context, provider, child) {
        return provider.isLoading == true
            ? const CustomCircularLoaderWidget()
            : Form(
                key: provider.formKey,
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
                            bottom: false,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 18.w,
                                  right: 18.w,
                                  //  top: 24.h, bottom: 24.h
                                  top: 14.h,
                                  bottom: 14.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        style: StyleUtility
                                            .kantumruyProSMedium18TextStyle
                                            .copyWith(
                                                fontSize: TextSizeUtility
                                                    .textSize18.sp),
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
                                    controller:
                                        provider.auditionDescriptionController,
                                    hintText:
                                        context.loc.hintAuditionDescription,
                                    maxLine: 4,
                                    validator: Validators(context)
                                        .validatorDescription,
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
                                      for (var item in provider.lookingForModel)
                                        SelectUnselectWidgetEdit(
                                            onTap: () {
                                              item.isSelect = !item.isSelect;
                                              setState(() {});
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
                                          status: provider.isExperienceNeeded ==
                                              true,
                                          onTap: () {
                                            provider.toggelWorkExperience(true);
                                          }),
                                      SizedBox(
                                        width: 38.h,
                                      ),
                                      YesNoCheckBoxWidget(
                                          title: context.loc.checkBoxNo,
                                          status: provider.isExperienceNeeded ==
                                              false,
                                          onTap: () {
                                            provider
                                                .toggelWorkExperience(false);
                                            // isExperienceNeeded = false;
                                            // setState(() {});
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
                                          status:
                                              provider.isTrainingNeeded == true,
                                          onTap: () {
                                            provider.toggelTrainingNeeded(true);
                                            // isTrainingNeeded = true;
                                            // setState(() {});
                                          }),
                                      SizedBox(
                                        width: 38.h,
                                      ),
                                      YesNoCheckBoxWidget(
                                          title: context.loc.checkBoxNo,
                                          status: provider.isTrainingNeeded ==
                                              false,
                                          onTap: () {
                                            provider
                                                .toggelTrainingNeeded(false);
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
                                          status:
                                              provider.isRepresented == true,
                                          onTap: () {
                                            provider.toggelRepresented(true);
                                          }),
                                      SizedBox(
                                        width: 38.h,
                                      ),
                                      YesNoCheckBoxWidget(
                                          title: context.loc.checkBoxNo,
                                          status:
                                              provider.isRepresented == false,
                                          onTap: () {
                                            provider.toggelRepresented(false);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: SimpleTextField(
                                          controller: provider.minAgeController,
                                          hintText: context.loc.hintMin,
                                          textInputType: TextInputType.number,
                                          validator: Validators(context)
                                              .validatorMinAge,
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
                                          controller: provider.maxAgeController,
                                          hintText: context.loc.hintMax,
                                          textInputType: TextInputType.number,
                                         // validator: Validators(context).validatorMaxAge,

                                            validator: (value){

                                              return Validators(context).validatorMaxAge2(provider.minAgeController.text,value);
                                            }

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: SimpleTextField(
                                          controller:
                                              provider.minWeightController,
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
                                          controller:
                                              provider.maxWeightController,
                                          hintText: context.loc.hintMax,
                                          textInputType: TextInputType.number,
                                         // validator: Validators(context).validatorMaxWeight,

                                            validator: (value){

                                              return Validators(context).validatorMaxWeight2(provider.minWeightController.text,value);
                                            }
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: SimpleTextField(
                                          controller:
                                              provider.minHeightController,
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
                                          controller:
                                              provider.maxHeightController,
                                          hintText: context.loc.hintMax,
                                          textInputType: TextInputType.number,
                                         // validator: Validators(context).validatorMaxHeight,
                                            validator: (value){

                                              return Validators(context).validatorMaxHeight2(provider.minHeightController.text,value);
                                            }
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
                                          for (var item
                                              in provider.eyeColorModelList) {
                                            provider.selectAll(item);
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
                                      for (var item
                                          in provider.eyeColorModelList)
                                        SelectUnselectWidgetEdit(
                                            onTap: () {
                                              item.isSelect = !item.isSelect;
                                              setState(() {});
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
                                          for (var item
                                              in provider.hairColorModelList) {
                                            // item.isSelect = true;
                                            // setState(() {});
                                            provider.selectAll(item);
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
                                      for (var item
                                          in provider.hairColorModelList)
                                        SelectUnselectWidgetEdit(
                                            onTap: () {
                                              item.isSelect = !item.isSelect;
                                              setState(() {});
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
                                          for (var item
                                              in provider.painsSizeModelList) {
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
                                      for (var item
                                          in provider.painsSizeModelList)
                                        SelectUnselectWidgetEdit(
                                            onTap: () {
                                              item.isSelect = !item.isSelect;
                                              setState(() {});
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
                                          for (var item
                                              in provider.shirtSizeModelList) {
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
                                      for (var item
                                          in provider.shirtSizeModelList)
                                        SelectUnselectWidgetEdit(
                                            onTap: () {
                                              item.isSelect = !item.isSelect;
                                              setState(() {});
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
                                          for (var item
                                              in provider.shoeSizeModelList) {
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
                                      for (var item
                                          in provider.shoeSizeModelList)
                                        SelectUnselectWidgetEdit(
                                            onTap: () {
                                              item.isSelect = !item.isSelect;
                                              setState(() {});
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
                                            //  buttonText: context.loc.buttonCancelAudition,
                                              buttonText: context.loc.buttonCancel,
                                              onTap: () {
                                                showCancelDialog(
                                                    context: context,
                                                    onYesTap: () {

                                                      Common.showLoadingDialog(context);
                                                      provider.cancelTheAuditionApi(id: widget.auditionId,
                                                          context: context, onFailure: (message){
                                                        Navigator.pop(context);

                                                        Common.showErrorSnackBar(context, message);
                                                          }, onSuccess: (message){
                                                            Navigator.pop(context);

                                                            showAuditionCancelSuccessDialog(
                                                                context: context);
                                                          });
                                                      // showAuditionCancelSuccessDialog(
                                                      //     context: context);


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
                                            provider.nextBtnClick(context);
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
                    )),
              );
      }),
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
     // Navigator.pop(context);
      Navigator
          .pushNamedAndRemoveUntil(
          context,
          RouteName
              .castBottomBarScreen,
          arguments: {
            "selectIndex": 0
          },
              (route) => false);
    });
  }
}
