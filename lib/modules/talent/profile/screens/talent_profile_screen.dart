import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/models/audition_property_model.dart';
import 'package:talent_app/modules/talent/commonModels/drop_down_model.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/utilities/validation.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/custom_drop_down_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';
import 'package:talent_app/widgets/textField/mobile_number_text_field.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

import '../../../casting/createAudition/widgets/yes_no_checkbox.dart';

class TalentProfileScreen extends StatefulWidget {
  const TalentProfileScreen({super.key});

  @override
  State<TalentProfileScreen> createState() => _TalentProfileScreenState();
}

class _TalentProfileScreenState extends State<TalentProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  TextEditingController instagramLinkController = TextEditingController();
  TextEditingController facebookLinkController = TextEditingController();
  TextEditingController tikTokLinkController = TextEditingController();

  TextEditingController youtubeLinkController = TextEditingController();

  bool isExperienceNeeded = true;
  bool isParticipate = false;

  List<AuditionPropertyModel>? genreModel;
  List<AuditionPropertyModel>? bodyModel;

  final ImagePicker picker = ImagePicker();

  final _createCardKey = GlobalKey<FormState>();

  DropDownModel? selectGender;
  List<DropDownModel> genderList = [
    DropDownModel("Male", "1"),
    DropDownModel("Female", "1")
  ];

  @override
  void initState() {
    super.initState();
    setAutoFillValue();
  }

  setAutoFillValue() {
    firstNameController.text = "Michaela";
    lastNameController.text = "Cohoen";
    idController.text = "0548977559";
    addressController.text = "Hahagana, 75, Rehovot, Israel";
    emailController.text = "Michaela@gmail.com";
    phoneController.text = "674294624";

    instagramLinkController.text = "https://instagram.Com";
    facebookLinkController.text = "https://facebook.Com";
    tikTokLinkController.text = "https://tiktok.Com";

    youtubeLinkController.text = "https://tiktok.Com";

    genreModel = [
      AuditionPropertyModel("Modeling", false),
      AuditionPropertyModel("Acting", false),
      AuditionPropertyModel("Singing", false)
    ];

    bodyModel = [
      AuditionPropertyModel("Eye color: Blue", false),
      AuditionPropertyModel("Hair color: blond", false),
      AuditionPropertyModel("H :1.7cm", false),
      AuditionPropertyModel("W :55k", false),
      AuditionPropertyModel("Pants Size : 36", false),
      AuditionPropertyModel("Shirt Size : S", false),
      AuditionPropertyModel("Shoe Size : 36", false)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r)),
              gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: ColorUtility.talentHeaderGradientColor)),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 18.w,
                  right: 18.w,
                  //  top: 24.h, bottom: 24.h
                  top: 24.h,
                  bottom: 24.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SettingButtonWidget(),
                  Row(
                    children: [
                      // const BackButton(
                      //   color: Colors.white,
                      // ),
                      Text(
                       // context.loc.headerEditProfile,
                        "Edit Profile",
                        style: StyleUtility.kantumruyProSMedium18TextStyle
                            .copyWith(fontSize: TextSizeUtility.textSize18.sp),
                      ),
                    ],
                  ),
                  const TalentMenuButtonWidget()
                ],
              ),
            ),
          ),
        ),
        Expanded(
            child: Form(
          key: _createCardKey,
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  context.loc.titleYourProfileDetails,
                  style: StyleUtility.quicksandSemiBold5457BETextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SimpleTextField(
                        controller: firstNameController,
                        validator: Validators(context).validatorFirstName,
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
                        controller: lastNameController,
                        hintText: context.loc.hintLastName,
                        validator: Validators(context).validatorLastName,
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
                        controller: idController,
                        hintText: context.loc.hintID,
                        validator: Validators(context).validatorGovtId,
                        onPrefixIconTap: () {
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    Expanded(
                        child: CustomDropDownWidget(
                            ovValueChange: (item) {
                              selectGender = item;
                              setState(() {});
                            },
                            dropDownList: genderList,
                            selectItem: selectGender,
                            hintText: context.loc.hintGender))
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                MobileNumberTextField(
                  controller: phoneController,
                  hintText: context.loc.hintMobile,
                  validator: Validators(context).validatorPhone,
                  onChanged: (PhoneNumber value) {
                    AppLogger.logD("IsoCode ${value.countryISOCode}");
                    AppLogger.logD("Country Code ${value.countryCode}");
                    AppLogger.logD("Number ${value.number}");
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                SimpleTextField(
                  controller: emailController,
                  suffixImage: ImageUtility.emailIcon,
                  hintText: context.loc.hintEmail,
                  textInputType: TextInputType.emailAddress,
                  validator: Validators(context).validatorEmail,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  context.loc.titleBirthday,
                  style: StyleUtility.quicksandSemiBold5457BETextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () {
                    Common.selectDateOfBirth(context, birthdayController);
                  },
                  child: SimpleTextField(
                    controller: birthdayController,
                    hintText: "DD/MM/YYYY",
                    isEnable: false,
                    suffixImage: ImageUtility.calenderIcon,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  context.loc.titleFullAddress,
                  style: StyleUtility.quicksandSemiBold5457BETextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SimpleTextField(
                  controller: addressController,
                  hintText: context.loc.hintAddress,
                  validator: Validators(context).validatorAddress,
                  onPrefixIconTap: () {
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.loc.titleTellUsAboutYou,
                      style: StyleUtility.quicksandBold5457BETextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteName.editTellUsAboutScreen);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Text(
                          context.loc.edit,
                          style: StyleUtility.quicksandMedium5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize14.sp),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 13.h,
                ),
                Text(
                  "My name is Michaela, and I’m thrilled to be here auditioning for this incredible movie opportunity. Allow me to introduce myself and share a little about who I am. I am an aspiring actress with a burning passion for storytelling through the magic of film.",
                  style: StyleUtility.quicksandRegularBlackTextStyle,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.loc.titleYourPhotos,
                      style: StyleUtility.quicksandSemiBold5457BETextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteName.editPhotoGalleryScreen);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Text(
                          context.loc.edit,
                          style: StyleUtility.quicksandMedium5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize14.sp),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 95.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 10.w),
                          child: Image.asset(
                            ImageUtility.dummyVideoThumbnailImage,
                            width: 90.w,
                            height: 120.h,
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.loc.titleVideos,
                      style: StyleUtility.quicksandSemiBold5457BETextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteName.editVideoGalleryScreen);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Text(
                          context.loc.edit,
                          style: StyleUtility.quicksandMedium5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize14.sp),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      ImageUtility.dummyVideoThumbnailImage,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Image.asset(
                      ImageUtility.playCircleIcon,
                      width: 55.w,
                      height: 55.w,
                      fit: BoxFit.contain,
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.loc.titleAudioFiles,
                      style: StyleUtility.quicksandSemiBold5457BETextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.editAudioScreen);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Text(
                          context.loc.edit,
                          style: StyleUtility.quicksandMedium5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize14.sp),
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 2,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(top: 16.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.sp),
                            border: Border.all(color: ColorUtility.colorD6D6D8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 20.w,
                                right: 14.w,
                                top: 10.h,
                                bottom: 10.h),
                            child: Row(
                              children: [
                                Image.asset(
                                  ImageUtility.playIcon,
                                  width: 13.w,
                                ),
                                SizedBox(
                                  width: 28.w,
                                ),
                                Expanded(
                                    child: Image.asset(
                                  ImageUtility.dummyAudioImage,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                )),
                                SizedBox(
                                  width: 22.w,
                                ),
                                Text(
                                  "0:31",
                                  style: StyleUtility
                                      .quicksandMediumACACAFTextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize13.sp),
                                )
                              ],
                            ),
                          ));
                    }),
                SizedBox(
                  height: 35.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      //  context.loc.titleEyeColor,
                      "Genre",
                      style: StyleUtility.quicksandSemiBold5457BETextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.editGenreScreen);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Text(
                          context.loc.edit,
                          style: StyleUtility.quicksandMedium5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize14.sp),
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
                    for (var item in genreModel!)
                      Container(
                          margin: EdgeInsets.only(right: 9.w, bottom: 13.h),
                          padding: EdgeInsets.only(
                              left: 15.sp,
                              right: 20.sp,
                              top: 9.sp,
                              bottom: 9.sp),
                          decoration: BoxDecoration(
                              color: item.isSelect == false
                                  ? ColorUtility.colorWhite
                                  : ColorUtility.colorEFF2F4,
                              borderRadius: BorderRadius.circular(30.r),
                              border:
                                  Border.all(color: ColorUtility.colorD3D6D6)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                item.title,
                                style: StyleUtility
                                    .quicksandRegularBlackTextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize14.sp),
                              ),
                            ],
                          ))
                  ],
                ),
                SizedBox(
                  height: 35.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.loc.titleBody,
                      style: StyleUtility.quicksandSemiBold5457BETextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.editBodyScreen);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Text(
                          context.loc.edit,
                          style: StyleUtility.quicksandMedium5457BETextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize14.sp),
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
                    for (var item in bodyModel!)
                      Container(
                          margin: EdgeInsets.only(right: 9.w, bottom: 13.h),
                          padding: EdgeInsets.only(
                              left: 15.sp,
                              right: 20.sp,
                              top: 9.sp,
                              bottom: 9.sp),
                          decoration: BoxDecoration(
                              color: item.isSelect == false
                                  ? ColorUtility.colorWhite
                                  : ColorUtility.colorEFF2F4,
                              borderRadius: BorderRadius.circular(30.r),
                              border:
                                  Border.all(color: ColorUtility.colorD3D6D6)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                item.title,
                                style: StyleUtility
                                    .quicksandRegularBlackTextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize14.sp),
                              ),
                            ],
                          ))
                  ],
                ),
                SizedBox(
                  height: 35.h,
                ),
                Text(
                  context.loc.titleAnyWorkExperience,
                  style: StyleUtility.quicksandSemiBold5457BETextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize16.sp),
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
                        setState(() {
                          isExperienceNeeded = true;
                        });
                      },
                    ),
                    SizedBox(
                      width: 38.h,
                    ),
                    YesNoCheckBoxWidget(
                      title: context.loc.checkBoxNo,
                      status: isExperienceNeeded == false,
                      onTap: () {
                        setState(() {
                          isExperienceNeeded = false;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 35.h,
                ),
                Text(
                  context.loc.titleDidYouParticipatedRealityShow,
                  style: StyleUtility.quicksandSemiBold5457BETextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    YesNoCheckBoxWidget(
                      title: context.loc.checkBoxYes,
                      status: isParticipate == true,
                      onTap: () {
                        setState(() {
                          isParticipate = true;
                        });
                      },
                    ),
                    SizedBox(
                      width: 38.h,
                    ),
                    YesNoCheckBoxWidget(
                      title: context.loc.checkBoxNo,
                      status: isParticipate == false,
                      onTap: () {
                        setState(() {
                          isParticipate = false;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 35.h,
                ),
                Text(
                  context.loc.titleSocialMediaLinks,
                  style: StyleUtility.quicksandSemiBold5457BETextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SimpleTextField(
                  controller: instagramLinkController,
                  hintText: context.loc.hintAddInstagramProfileLink,
                ),
                SizedBox(
                  height: 20.h,
                ),
                SimpleTextField(
                  controller: facebookLinkController,
                  hintText: context.loc.hintAddFacebookProfileLink,
                ),
                SizedBox(
                  height: 20.h,
                ),
                SimpleTextField(
                  controller: tikTokLinkController,
                  hintText: context.loc.hintAddTikTokProfileLink,
                ),
                SizedBox(
                  height: 20.h,
                ),
                SimpleTextField(
                  controller: youtubeLinkController,
                  hintText: context.loc.hintYouTubeProfileLink,
                ),
                SizedBox(
                  height: 35.h,
                ),
                CustomButton(
                  buttonText: context.loc.buttonUpdate,
                  buttonType: ButtonType.blue,
                  onTap: () async {
                    if (_createCardKey.currentState!.validate()) {
                      AppLogger.logD("Valid data");
                    } else {}
                  },
                ),
                SizedBox(
                  height: 35.h,
                ),
              ]),
        )),
      ]),
    );
  }
}
