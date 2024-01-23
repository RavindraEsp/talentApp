import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/model/telent_user_profile_model.dart';
import 'package:talent_app/modules/talent/commonModels/drop_down_model.dart';
import 'package:talent_app/modules/talent/profile/providers/talent_profile_screen_provider.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/utilities/validation.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/custom_drop_down_widget.dart';
import 'package:talent_app/widgets/no_data_widget.dart';
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

  bool isExperienceNeeded = false;
  bool isParticipate = false;

  List<String> genreModel = [];
  List<String> bodyModel = [];

  final ImagePicker picker = ImagePicker();

  final _createCardKey = GlobalKey<FormState>();

  DropDownModel? selectGender;
  List<DropDownModel> genderList = [
    DropDownModel("Male", "1"),
    DropDownModel("Female", "2")
  ];

  @override
  void initState() {
    super.initState();

    Provider.of<TalentProfileScreenProvider>(context, listen: false)
        .getTalentProfile(onFailure: (message) {
      Common.showErrorSnackBar(context, message);
    }, onSuccess: (talantUserProfileModel) {
      setAutoFillValue(talantUserProfileModel);
    });
  }

  setAutoFillValue(TalantUserProfileModel talantUserProfileModel) {
    genreModel = [];
    bodyModel = [];

    var talentProfile = talantUserProfileModel.data?[0];
    firstNameController.text = talentProfile?.firstName ?? "";
    lastNameController.text = talentProfile?.lastName ?? "";
    idController.text = talentProfile?.govtId.toString() ?? "";
    addressController.text = talentProfile?.address ?? "";
    emailController.text = talentProfile?.email ?? "";
    phoneController.text = talentProfile?.phone ?? "";

    instagramLinkController.text = talentProfile?.instalink ?? "";
    facebookLinkController.text = talentProfile?.facebooklink ?? "";
    tikTokLinkController.text = talentProfile?.tiktoklink ?? "";
    youtubeLinkController.text = talentProfile?.youtubelink ?? "";
    birthdayController.text = talentProfile?.dateofbirth ?? "";

    selectGender = genderList.firstWhere((gender) =>
        gender.value.toString() == talentProfile?.gender.toString());

    for (String item in talentProfile?.lookingFor ?? []) {
      genreModel.add(item);
    }
    for (String item in talentProfile?.bodyList ?? []) {
      bodyModel.add(item);
    }

    isExperienceNeeded = talentProfile?.experience == 1 ? true : false;
    isParticipate = talentProfile?.participated == 1 ? true : false;
  }

  getTalentProfileDataAfterUpdate(
      TalentProfileScreenProvider talentProfileScreenProvider) {
    talentProfileScreenProvider.isLoading = true;
    talentProfileScreenProvider.updateUi();
    talentProfileScreenProvider.getTalentProfile(onFailure: (message) {
      Common.showErrorSnackBar(context, message);
    }, onSuccess: (talantUserProfileModel) {
      setAutoFillValue(talantUserProfileModel);
    });
  }

  deleteFile(TalentProfileScreenProvider talentProfileScreenProvider, int id) {
    Common.showLoadingDialog(context);
    talentProfileScreenProvider.deleteFile(
        id: id,
        onFailure: (message) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          Common.showErrorSnackBar(context, message);
        },
        onSuccess: (msg) {
          Navigator.pop(context);
          Common.showSuccessSnackBar(context, msg);
          getTalentProfileDataAfterUpdate(talentProfileScreenProvider);
        });
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
                  left: 18.w, right: 18.w, top: 24.h, bottom: 24.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SettingButtonWidget(),
                  Row(
                    children: [
                      Text(
                        context.loc.headerEditProfile,
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
        Consumer<TalentProfileScreenProvider>(
            builder: (context, talentProfileScreenProvider, child) {
          return Expanded(
              child: talentProfileScreenProvider.isLoading == true
                  ? const Center(
                      child: CustomCircularLoaderWidget(),
                    )
                  : Form(
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
                                    controller: firstNameController,
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
                                    controller: lastNameController,
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
                                    controller: idController,
                                    hintText: context.loc.hintID,
                                    validator:
                                        Validators(context).validatorGovtId,
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
                              isoCode: talentProfileScreenProvider
                                  .talantUserProfileModel
                                  ?.data?[0]
                                  .countryISOCode,
                              //  validator: Validators(context).validatorPhone,
                              isEnable: false,
                              onChanged: (PhoneNumber value) {
                                AppLogger.logD(
                                    "IsoCode ${value.countryISOCode}");
                                AppLogger.logD(
                                    "Country Code ${value.countryCode}");
                                AppLogger.logD("Number ${value.number}");
                              },
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            SimpleTextField(
                              isEnable: false,
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
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                Common.selectDateOfBirth(
                                    context, birthdayController);
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
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp),
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
                                  style: StyleUtility
                                      .quicksandBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RouteName.editTellUsAboutScreen,
                                        arguments: {
                                          "about": talentProfileScreenProvider
                                                  .talantUserProfileModel
                                                  ?.data?[0]
                                                  .about ??
                                              "",
                                          "id": talentProfileScreenProvider
                                                  .talantUserProfileModel
                                                  ?.data?[0]
                                                  .id ??
                                              0
                                        }).then((value) {
                                      if (value == true) {
                                        getTalentProfileDataAfterUpdate(
                                            talentProfileScreenProvider);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: Text(
                                      context.loc.edit,
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
                              height: 13.h,
                            ),
                            Text(
                              // "My name is Michaela, and I’m thrilled to be here auditioning for this incredible movie opportunity. Allow me to introduce myself and share a little about who I am. I am an aspiring actress with a burning passion for storytelling through the magic of film.",
                              talentProfileScreenProvider
                                      .talantUserProfileModel?.data?[0].about ??
                                  "",
                              style: StyleUtility.quicksandRegularBlackTextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  context.loc.titleYourPhotos,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RouteName.editPhotoGalleryScreen,
                                        arguments: {
                                          "id": talentProfileScreenProvider
                                                  .talantUserProfileModel
                                                  ?.data?[0]
                                                  .id ??
                                              0
                                        }).then((value) {
                                      if (value == true) {
                                        getTalentProfileDataAfterUpdate(
                                            talentProfileScreenProvider);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: Text(
                                      context.loc.edit,
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
                              height: 15.h,
                            ),
                            (talentProfileScreenProvider.talantUserProfileModel
                                            ?.data?[0].imageFiles?.length ??
                                        0) ==
                                    0
                                ? SizedBox(
                                    height: 100.h, child: const NoDataWidget())
                                : SizedBox(
                                    height: 120.sp,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: talentProfileScreenProvider
                                                .talantUserProfileModel
                                                ?.data?[0]
                                                .imageFiles
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          return Container(
                                              margin:
                                                  EdgeInsets.only(right: 10.w),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    child: CachedNetworkImage(
                                                        width: 90.sp,
                                                        height: 120.sp,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            const Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                                color:
                                                                    Colors.grey,
                                                                child: Center(
                                                                    child: Icon(
                                                                  Icons.error,
                                                                  size: 25.sp,
                                                                ))),
                                                        imageUrl:
                                                            "${Endpoints.imageBaseUrl}${talentProfileScreenProvider.talantUserProfileModel?.data?[0].imageFiles?[index].files}"),
                                                  ),
                                                  Container(
                                                    width: 90.sp,
                                                    height: 120.sp,
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: InkWell(
                                                      onTap: () {
                                                        AppLogger.logD(
                                                            "Deleted image");
                                                        deleteFile(
                                                            talentProfileScreenProvider,
                                                            talentProfileScreenProvider
                                                                    .talantUserProfileModel
                                                                    ?.data?[0]
                                                                    .imageFiles?[
                                                                        index]
                                                                    .fileId ??
                                                                0);
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            5.sp),
                                                        child: Icon(
                                                          Icons
                                                              .delete_outline_outlined,
                                                          size: 20.sp,
                                                          color: ColorUtility
                                                              .colorE24848,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                              // Image.asset(
                                              //   ImageUtility.dummyVideoThumbnailImage,
                                              //   width: 90.w,
                                              //   height: 120.h,
                                              //   fit: BoxFit.cover,
                                              // ),

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
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RouteName.editVideoGalleryScreen,
                                        arguments: {
                                          "id": talentProfileScreenProvider
                                                  .talantUserProfileModel
                                                  ?.data?[0]
                                                  .id ??
                                              0
                                        }).then((value) {
                                      if (value == true) {
                                        getTalentProfileDataAfterUpdate(
                                            talentProfileScreenProvider);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: Text(
                                      context.loc.edit,
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
                              height: 15.h,
                            ),

                            (talentProfileScreenProvider.talantUserProfileModel
                                            ?.data?[0].videoFiles?.length ??
                                        0) ==
                                    0
                                ? SizedBox(
                                    height: 100.h, child: const NoDataWidget())
                                : SizedBox(
                                    height: 210.h,
                                    child: (talentProfileScreenProvider
                                                    .talantUserProfileModel
                                                    ?.data?[0]
                                                    .videoFiles
                                                    ?.length ??
                                                0) ==
                                            0
                                        ? const NoDataWidget()
                                        : ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount:
                                                talentProfileScreenProvider
                                                        .talantUserProfileModel
                                                        ?.data?[0]
                                                        .videoFiles
                                                        ?.length ??
                                                    0,
                                            // itemCount: 2,

                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                    right: 15.w),
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    // Image.asset(
                                                    //   ImageUtility
                                                    //       .dummyVideoThumbnailImage,
                                                    //   //  width: double.infinity,
                                                    //   height: 210.h,
                                                    //   fit: BoxFit.fill,
                                                    // ),

                                                    Container(
                                                      height: 210.h,
                                                      width: 300.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        color: Colors.black,
                                                      ),
                                                    ),

                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.pushNamed(context,
                                                            RouteName.videoPlayerScreen,
                                                            arguments: {
                                                              "videoFromApi":talentProfileScreenProvider
                                                                  .talantUserProfileModel
                                                                  ?.data?[0]
                                                                  .videoFiles?[index]
                                                                  .files ?? ""
                                                            });
                                                      },
                                                      child: Image.asset(
                                                        ImageUtility
                                                            .playCircleIcon,
                                                        width: 55.w,
                                                        height: 55.w,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),

                                                    Container(
                                                      height: 210.h,
                                                      width: 300.w,
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: InkWell(
                                                        onTap: () {
                                                          AppLogger.logD(
                                                              "Deleted image");
                                                          deleteFile(
                                                              talentProfileScreenProvider,
                                                              talentProfileScreenProvider
                                                                      .talantUserProfileModel
                                                                      ?.data?[0]
                                                                      .videoFiles?[
                                                                          index]
                                                                      .fileId ??
                                                                  0);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.sp),
                                                          child: Icon(
                                                            Icons
                                                                .delete_outline_outlined,
                                                            size: 24.sp,
                                                            color: ColorUtility
                                                                .colorE24848,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
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
                                  context.loc.titleAudioFiles,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.editAudioScreen,
                                        arguments: {
                                          "id": talentProfileScreenProvider
                                                  .talantUserProfileModel
                                                  ?.data?[0]
                                                  .id ??
                                              0
                                        }).then((value) {
                                      if (value == true) {
                                        getTalentProfileDataAfterUpdate(
                                            talentProfileScreenProvider);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: Text(
                                      context.loc.edit,
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
                            (talentProfileScreenProvider.talantUserProfileModel
                                            ?.data?[0].audioFiles?.length ??
                                        0) ==
                                    0
                                ? SizedBox(
                                    height: 100.h, child: const NoDataWidget())
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: talentProfileScreenProvider
                                            .talantUserProfileModel
                                            ?.data?[0]
                                            .audioFiles
                                            ?.length ??
                                        0,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 16.h),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.sp),
                                                  border: Border.all(
                                                      color: ColorUtility
                                                          .colorD6D6D8),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20.w,
                                                      right: 14.w,
                                                      top: 10.h,
                                                      bottom: 10.h),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap:(){
                                                          Navigator.pushNamed(context,
                                                              RouteName.audioPlayerScreen,
                                                          arguments: {
                                                            "audioFromApi":talentProfileScreenProvider
                                                                .talantUserProfileModel
                                                                ?.data?[0]
                                                                .audioFiles?[index]
                                                                .files ?? ""
                                                          });
                                                        },
                                                        child: Image.asset(
                                                          ImageUtility.playIcon,
                                                          width: 13.w,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 28.w,
                                                      ),
                                                      Expanded(
                                                          child: Image.asset(
                                                        ImageUtility
                                                            .dummyAudioImage,
                                                        width: double.infinity,
                                                        fit: BoxFit.contain,
                                                      )),
                                                      SizedBox(
                                                        width: 22.w,
                                                      ),
                                                      // Text(
                                                      //   "0:31",
                                                      //   style: StyleUtility
                                                      //       .quicksandMediumACACAFTextStyle
                                                      //       .copyWith(
                                                      //       fontSize:
                                                      //       TextSizeUtility
                                                      //           .textSize13
                                                      //           .sp),
                                                      // ),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 16.h),
                                            child: InkWell(
                                              onTap: () {
                                                AppLogger.logD("Deleted image");
                                                deleteFile(
                                                    talentProfileScreenProvider,
                                                    talentProfileScreenProvider
                                                            .talantUserProfileModel
                                                            ?.data?[0]
                                                            .audioFiles?[index]
                                                            .fileId ??
                                                        0);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(5.sp),
                                                child: Icon(
                                                  Icons.delete_outline_outlined,
                                                  size: 24.sp,
                                                  color:
                                                      ColorUtility.colorE24848,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                            SizedBox(
                              height: 35.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  context.loc.titleGenre,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.editGenreScreen,
                                        arguments: {
                                          "id": talentProfileScreenProvider
                                                  .talantUserProfileModel
                                                  ?.data?[0]
                                                  .id ??
                                              0
                                        }).then((value) {
                                      if (value == true) {
                                        getTalentProfileDataAfterUpdate(
                                            talentProfileScreenProvider);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: Text(
                                      context.loc.edit,
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
                                for (var item in genreModel!)
                                  Container(
                                      margin: EdgeInsets.only(
                                          right: 9.w, bottom: 13.h),
                                      padding: EdgeInsets.only(
                                          left: 15.sp,
                                          right: 20.sp,
                                          top: 9.sp,
                                          bottom: 9.sp),
                                      decoration: BoxDecoration(
                                          color: ColorUtility.colorEFF2F4,
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          border: Border.all(
                                              color: ColorUtility.colorD3D6D6)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            item,
                                            style: StyleUtility
                                                .quicksandRegularBlackTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize14.sp),
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
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.editBodyScreen,
                                        arguments: {
                                          "id": talentProfileScreenProvider
                                                  .talantUserProfileModel
                                                  ?.data?[0]
                                                  .id ??
                                              0
                                        }).then((value) {
                                      if (value == true) {
                                        getTalentProfileDataAfterUpdate(
                                            talentProfileScreenProvider);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: Text(
                                      context.loc.edit,
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
                                for (var item in bodyModel!)
                                  Container(
                                      margin: EdgeInsets.only(
                                          right: 9.w, bottom: 13.h),
                                      padding: EdgeInsets.only(
                                          left: 15.sp,
                                          right: 20.sp,
                                          top: 9.sp,
                                          bottom: 9.sp),
                                      decoration: BoxDecoration(
                                          color: ColorUtility.colorEFF2F4,
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          border: Border.all(
                                              color: ColorUtility.colorD3D6D6)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            item,
                                            style: StyleUtility
                                                .quicksandRegularBlackTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize14.sp),
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
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
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
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
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
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp),
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
                            // CustomButton(
                            //   buttonText: context.loc.buttonUpdate,
                            //   buttonType: ButtonType.blue,
                            //   onTap: () async {
                            //     if (_createCardKey.currentState!.validate()) {
                            //       AppLogger.logD("Valid data");
                            //     } else {}
                            //   },
                            // ),
                            SizedBox(
                              height: 35.h,
                            ),
                          ]),
                    ));
        }),
      ]),
    );
  }
}
