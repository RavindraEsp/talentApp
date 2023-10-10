import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/commonModels/drop_down_model.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/utilities/validation.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/custom_drop_down_widget.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

class CastProfileScreen extends StatefulWidget {
  const CastProfileScreen({super.key});

  @override
  State<CastProfileScreen> createState() => _CastProfileScreenState();
}

class _CastProfileScreenState extends State<CastProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  XFile? _logoImage;
  XFile? _profileImage;

  final ImagePicker picker = ImagePicker();

  final _createCardKey = GlobalKey<FormState>();

  Future getImageLogo() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    AppLogger.logD('PickedFileLogo: ${image.toString()}');
    setState(() {
      _logoImage = XFile(image!.path);
    });
  }

  Future getImageProfile() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    AppLogger.logD('PickedFileProfile: ${image.toString()}');
    setState(() {
      _profileImage = XFile(image!.path);
    });
  }

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
    companyNameController.text = "Talentteam";
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
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(left: 24.w, top: 12.h),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        centerTitle: true,
                        title: Text(
                          "Hello, Alen",
                          style: StyleUtility.headerTextStyle.copyWith(
                              fontSize: TextSizeUtility.textSize18.sp),
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
                            SimpleTextField(
                              controller: companyNameController,
                              hintText: context.loc.hintCompanyName,
                              validator:
                                  Validators(context).validatorCompanyName,
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
                                        await getImageLogo();
                                      },
                                      child: logoProfileWidget(_logoImage),
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
                                        await getImageProfile();
                                      },
                                      child: logoProfileWidget(_profileImage),
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
                              },
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                          ]),
                    )),
                  ]))),
        ],
      ),
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
