import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createCard/provider/cast_create_card_provider.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/utilities/validation.dart';
import 'package:talent_app/widgets/alertDialog/congratulation_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

class CastCreateCardScreen extends StatefulWidget {
  const CastCreateCardScreen({super.key});

  @override
  State<CastCreateCardScreen> createState() => _CastCreateCardScreenState();
}

class _CastCreateCardScreenState extends State<CastCreateCardScreen> {
  final _createCardKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
      children: [
        Container(
          height: 80.h,
          width: double.infinity,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  // colors: ColorUtility.castHeaderGradientColor

                  colors: ColorUtility.castHeaderGradientColor)),
        ),
        SafeArea(
          child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageUtility.castSignupBgImage),
                    fit: BoxFit.fill),
              ),
              child: Consumer<CastCreateCardProvider>(
                  builder: (context, castCreateCardProvider, child) {
                return Column(children: [
                  Container(
                    margin: EdgeInsets.only(left: 24.w, top: 22.h),
                    child: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      centerTitle: true,
                      title: Text(
                        context.loc.headerCreateCard,
                        style: StyleUtility.headerTextStyle
                            .copyWith(fontSize: TextSizeUtility.textSize22.sp),
                      ),
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          CommonMethod.hideKeyBoard(context);
                        },
                        child: Form(
                    key: _createCardKey,
                    child: ListView(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,left: 20.w,right: 20.w),
                        //  padding: EdgeInsets.symmetric(horizontal: 20.w),
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              context.loc.fillCardDetailText,
                              style: StyleUtility.quicksandSemiBold5457BETextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SimpleTextField(
                                    controller: castCreateCardProvider
                                        .firstNameController,
                                    validator:
                                        Validators(context).validatorFirstName,
                                    hintText: context.loc.hintFirstName,
                                    onPrefixIconTap: () {
                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 14.w,
                                ),
                                Expanded(
                                  child: SimpleTextField(
                                    controller:
                                        castCreateCardProvider.lastNameController,
                                    hintText: context.loc.hintLastName,
                                    validator:
                                        Validators(context).validatorLastName,
                                    onPrefixIconTap: () {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SimpleTextField(

                                    controller:
                                        castCreateCardProvider.govtIdController,
                                    maxLength: 9,
                                    hintText: context.loc.hintID,
                                    validator: Validators(context).validatorGovtId,
                                  //   validator: (value) {
                                  //     if (value.isEmpty ) {
                                  //       return context.loc.validationID;
                                  //     }else if (value.length != 9) {
                                  //       return 'Id must be exactly 9 characters and numbers.';
                                  //     }
                                  //   },
                                    onPrefixIconTap: () {
                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 14.w,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: ColorUtility.colorD6D6D8,
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(

                                        value:
                                            castCreateCardProvider.selectedValue,
                                        items: castCreateCardProvider.listItems,
                                        isExpanded: true,
                                        icon: SizedBox(
                                          height: 10.h,
                                          child: Image.asset(
                                              ImageUtility.dropDownArrowIcon),
                                        ),
                                        underline: Container(
                                          color: ColorUtility.colorD6D6D8,
                                        ),
                                        hint: Text(
                                          context.loc.hintGender,
                                          style: StyleUtility.hintTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize15.sp),
                                        ),
                                        onChanged: (int? value) {
                                          setState(() {
                                            castCreateCardProvider.selectedValue =
                                                value!;
                                            print(value);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            SimpleTextField(
                              controller:
                                  castCreateCardProvider.addressController,
                              hintText: context.loc.hintAddress,
                              validator: Validators(context).validatorAddress,
                              onPrefixIconTap: () {
                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            SimpleTextField(
                              controller:
                                  castCreateCardProvider.companyNameController,
                              hintText: context.loc.hintCompanyName,
                              validator: Validators(context).validatorCompanyName,
                              onPrefixIconTap: () {
                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      context.loc.addLogo,
                                      style: StyleUtility
                                          .quicksandSemiBold5457BETextStyle
                                          .copyWith(
                                              color: ColorUtility.color445DB8,
                                              fontSize:
                                                  TextSizeUtility.textSize16),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await castCreateCardProvider
                                            .getImageProfile();
                                      },
                                      child: Container(
                                        height: 160.h,
                                        width: 140.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(
                                            color: ColorUtility.colorD6D6D8,
                                          ),
                                        ),
                                        child: castCreateCardProvider
                                                    .profileImage ==
                                                null
                                            ? Container(
                                                padding: EdgeInsets.all(53.w),
                                                height: 5.h,
                                                width: 30.w,
                                                child: Image.asset(
                                                  ImageUtility.addIcon,
                                                ),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10.r),
                                                ),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    child: Image.file(
                                                      File(castCreateCardProvider
                                                          .profileImage!.path),
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      context.loc.addProfileImage,
                                      style: StyleUtility
                                          .quicksandSemiBold5457BETextStyle
                                          .copyWith(
                                              color: ColorUtility.color445DB8,
                                              fontSize:
                                                  TextSizeUtility.textSize16),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await castCreateCardProvider
                                            .getImageLogo();
                                      },
                                      child: Container(
                                          height: 160.h,
                                          width: 140.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border: Border.all(
                                              color: ColorUtility.colorD6D6D8,
                                            ),
                                          ),
                                          child: castCreateCardProvider
                                                      .logoImage ==
                                                  null
                                              ? Container(
                                                  padding: EdgeInsets.all(53.w),
                                                  height: 5.h,
                                                  width: 30.w,
                                                  child: Image.asset(
                                                    ImageUtility.addIcon,
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    child: Image.file(
                                                      File(castCreateCardProvider
                                                          .logoImage!.path),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            CustomButton(
                              buttonText: context.loc.buttonNext,
                              buttonType: ButtonType.yellow,
                              onTap: () async {

                                if (_createCardKey.currentState!.validate()) {
                                  AppLogger.logD("Valid data");
                                  if (castCreateCardProvider.logoImage == null ||
                                      castCreateCardProvider.profileImage ==
                                          null ||
                                      castCreateCardProvider.selectedValue ==
                                          null) {
                                    await Common.showErrorToast(
                                        context, "Please Fill All Fields");
                                  }else{
                                    Common.showLoadingDialog(context);
                                    castCreateCardProvider.createCard(
                                      onSuccess: (msg) {
                                        Navigator.pop(context);

                                        showCongratulationDialog(
                                            context: context, onButtonTap: () {});


                                      },
                                      onFailure: (message) {
                                        Navigator.pop(context);
                                        Common.showErrorSnackBar(context, message);
                                      },
                                    );
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                          ]),
                  ),
                      )),
                ]);
              })),
        ),
      ],
    ));
  }

  Future<dynamic> showCongratulationDialog({
    required BuildContext context,
    required VoidCallback onButtonTap,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CongratulationAlertDialog(
            onButtonTap: onButtonTap,
            userType: UserType.cast,
            buttonText: context.loc.buttonLetsGetStarted,
            title: context.loc.dialogWellDone,
            description: context.loc.dialogCasterCardSetSuccessDescription,
          );
        }).then((value) {

      AppLogger.logD("Then is called");
      Navigator.pushNamedAndRemoveUntil(
          context,
          RouteName.castBottomBarScreen,
          arguments: {"selectIndex": 0},
          (route) => false);
    });
  }
}
