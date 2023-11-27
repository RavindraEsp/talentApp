import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/profile/cast_profile_provider.dart';
import 'package:talent_app/modules/talent/commonModels/drop_down_model.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/shared_preference.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/utilities/validation.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/custom_drop_down_widget.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

class CastProfileScreen extends StatefulWidget {
  const CastProfileScreen({super.key});

  @override
  State<CastProfileScreen> createState() => _CastProfileScreenState();
}

class _CastProfileScreenState extends State<CastProfileScreen> {
  final _createCardKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<CastProfileProvider>(context, listen: false)
        .getProfileData(onSuccess: (msg) {}, onFailure: (msg) {
          Common.showErrorToast(context, msg);
    });
  }


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
                    colors: ColorUtility.castHeaderGradientColor)),
          ),
          SafeArea(
              child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageUtility.castSignupBgImage),
                        fit: BoxFit.fill),
                  ),
                  child: Consumer<CastProfileProvider>(
                      builder: (context, castProfileProvider, child) {
                    return Column(children: [
                      Container(
                        margin: EdgeInsets.only(left: 24.w, top: 12.h),
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          centerTitle: true,
                          title: Text(
                            "${context.loc.helloUserName} ${Preference().getUserName()}",
                            style: StyleUtility.headerTextStyle.copyWith(
                                fontSize: TextSizeUtility.textSize18.sp),
                          ),
                        ),
                      ),
                      Expanded(
                          child:  castProfileProvider.isLoading == true ?
                          const CustomCircularLoaderWidget():



                          Form(
                        key: _createCardKey,
                        child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            children: [
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                context.loc.titleYourProfileDetails,
                                style: StyleUtility
                                    .quicksandSemiBold5457BETextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize16.sp),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SimpleTextField(
                                      controller: castProfileProvider
                                          .firstNameController,
                                      validator: Validators(context)
                                          .validatorFirstName,
                                      hintText: context.loc.hintFirstName,

                                    ),
                                  ),
                                  SizedBox(
                                    width: 14.w,
                                  ),
                                  Expanded(
                                    child: SimpleTextField(
                                      controller: castProfileProvider
                                          .lastNameController,
                                      hintText: context.loc.hintLastName,
                                      validator:
                                          Validators(context).validatorLastName,

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
                                          castProfileProvider.idController,
                                      hintText: context.loc.hintID,
                                      validator:
                                          Validators(context).validatorId,

                                    ),
                                  ),
                                  SizedBox(
                                    width: 14.w,
                                  ),
                                  Expanded(
                                      child: CustomDropDownWidget(
                                          ovValueChange: (item) {
                                            castProfileProvider.selectGender =
                                                item;
                                            castProfileProvider.updateUi();
                                          },
                                          dropDownList:
                                              castProfileProvider.genderList,
                                          selectItem:
                                              castProfileProvider.selectGender,
                                          hintText: context.loc.hintGender))
                                ],
                              ),


                              SizedBox(
                                height: 25.h,
                              ),
                              SimpleTextField(
                                controller:
                                    castProfileProvider.addressController,
                                hintText: context.loc.hintAddress,
                                validator: Validators(context).validatorAddress,

                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              SimpleTextField(
                                controller:
                                    castProfileProvider.companyNameController,
                                hintText: context.loc.hintCompanyName,
                                validator:
                                    Validators(context).validatorCompanyName,

                              ),
                              SizedBox(
                                height: 35.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                          await castProfileProvider
                                              .getImageLogo();
                                        },
                                        child: imageWidget(
                                            castProfileProvider.logoImage,castProfileProvider.networkLogoImage ?? ""),
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
                                          await castProfileProvider
                                              .getImageProfile();
                                        },
                                        child: imageWidget(
                                            castProfileProvider.profileImage,
                                            castProfileProvider.networkProfileImage ?? ""
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              CustomButton(
                                buttonText: context.loc.buttonUpdate,
                                buttonType: ButtonType.yellow,
                                onTap: () async {
                                  if (_createCardKey.currentState!.validate()) {
                                    AppLogger.logD("Valid data");
                                    // if (_logoimage == null &&
                                    //     _profileImage == null &&
                                    //     _selectedValue == null) {
                                    //   await showToast("Please Fill All Fields");
                                    // }
                                  } else {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const CastBottomNavigationBar()));
                                  }

                                  if (_createCardKey.currentState!.validate()) {
                                    Common.showLoadingDialog(context);
                                    castProfileProvider.updateProfile(
                                      onSuccess: (msg) {
                                        Navigator.pop(context);
                                        Common.showSuccessToast(context, msg);
                                      },
                                      onFailure: (message) {
                                        Navigator.pop(context);
                                        Common.showErrorSnackBar(
                                            context, message);
                                      },
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: 35.h,
                              ),
                            ]),
                      )),
                    ]);
                  }))),
        ],
      ),
    );
  }

  SizedBox imageWidget(XFile? imageFile,String networkImageUrl) {
    return SizedBox(
        height: 145.w,
        width: 146.w,
        child: imageFile == null
            ?
        networkImageUrl != "" ?
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              margin: EdgeInsets.only(right: 12.w, bottom: 12.w),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child:

                CachedNetworkImage(
                    width: double.infinity,
                    height:double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Container(
                            color: Colors.grey,
                            child: Center(child:  Icon(Icons.error,size: 25.sp,))),
                    // imageUrl: "https://espsofttech.in:7272/api/auth/uploads/image-1696339902307.jpg"),
                    imageUrl: "${Endpoints.imageBaseUrl}$networkImageUrl"),
              ),
            ),
            Image.asset(
              ImageUtility.editCircleIcon,
              width: 33.w,
              height: 33.w,
            )
          ],
        ):
        Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: ColorUtility.colorD6D6D8,
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    height: 30.w,
                    width: 30.w,
                    child: Image.asset(
                      ImageUtility.addIcon,
                    ),
                  ),
                ),
              )
            : Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12.w, bottom: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: ColorUtility.colorD6D6D8,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child:

                      Image.file(
                        File(imageFile.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Image.asset(
                    ImageUtility.editCircleIcon,
                    width: 33.w,
                    height: 33.w,
                  )
                ],
              ));
  }
}
