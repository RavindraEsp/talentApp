import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/commonModels/drop_down_model.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/modules/talent/widgets/talent_setting_widget.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/utilities/validation.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/custom_drop_down_widget.dart';
import 'package:talent_app/widgets/textField/mobile_number_text_field.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

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

  XFile? _logoImage;
  XFile? _profileImage;

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
    firstNameController.text = "Nir";
    lastNameController.text = "David";
    idController.text = "0548977559";
    addressController.text = "Neve Tzedek,12 ,Tel Aviv";
    emailController.text = "dummy@gmail.com";
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
                  top: 14.h,
                  bottom: 14.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TalentSettingButtonWidget(),
                  Row(
                    children: [
                      const BackButton(
                        color: Colors.white,
                      ),
                      Text(
                        context.loc.headerEditAudition,
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
                        validator: Validators(context).validatorId,
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
                  validator:
                  Validators(context).validatorPhone,
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
                  controller: emailController,
                  suffixImage: ImageUtility.emailIcon,
                  hintText: context.loc.hintEmail,
                  textInputType: TextInputType.emailAddress,
                  validator:
                  Validators(context).validatorEmail,
                ),


                SizedBox(
                  height: 25.h,
                ),

                GestureDetector(
                  onTap: () {
                    Common.selectDate(
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
                    Text(context.loc.titleTellUsAboutYou,style: StyleUtility.quicksandBold5457BETextStyle,),
                    Text(context.loc.edit,style: StyleUtility.quicksandBold5457BETextStyle,),


                  ],
                ),

                SizedBox(
                  height: 13.h,
                ),
                Text("My name is Michaela, and I’m thrilled to be here auditioning for this incredible movie opportunity. Allow me to introduce myself and share a little about who I am. I am an aspiring actress with a burning passion for storytelling through the magic of film.",
                style: StyleUtility.quicksandRegularBlackTextStyle,),
                SizedBox(
                  height: 20.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                    //  context.loc.titleVideos,
                      "Your Photos",
                      style: StyleUtility.quicksandSemiBold5457BETextStyle
                          .copyWith(
                          fontSize: TextSizeUtility.textSize16.sp),
                    ),
                    Text(context.loc.edit,style: StyleUtility.quicksandBold5457BETextStyle,),

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
                      itemBuilder: (context,index){

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
                )
                ,

                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.loc.titleVideos,
                      style: StyleUtility.quicksandSemiBold5457BETextStyle
                          .copyWith(
                          fontSize: TextSizeUtility.textSize16.sp),
                    ),
                    Text(context.loc.edit,style: StyleUtility.quicksandBold5457BETextStyle,),

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
                Text(
                  context.loc.titleAudioFiles,
                  style: StyleUtility.quicksandSemiBold5457BETextStyle
                      .copyWith(
                      fontSize: TextSizeUtility.textSize16.sp),
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
                            border: Border.all(
                                color: ColorUtility.colorD6D6D8),
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
                                      fontSize: TextSizeUtility
                                          .textSize13.sp),
                                )
                              ],
                            ),
                          ));
                    }),


                SizedBox(
                  height: 35.h,
                ),
                CustomButton(
                  buttonText: context.loc.buttonUpdate,
                  buttonType: ButtonType.blue,
                  onTap: () async {
                    if (_createCardKey.currentState!.validate()) {
                      AppLogger.logD("Valid data");

                    } else {

                    }
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

  SizedBox logoProfileWidget(XFile? imageFile) {
    return SizedBox(
        height: 145.w,
        width: 146.w,
        child: imageFile == null
            ? Container(
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
                      child: Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
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
