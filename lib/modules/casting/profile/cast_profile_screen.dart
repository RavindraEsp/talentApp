import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/utilities/validation.dart';
import 'package:talent_app/widgets/alertDialog/congratulation_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
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
  int? _selectedGenderValue = 1;
  final _createCardKey = GlobalKey<FormState>();

  Future getImageLogo() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    print('PickedFileLogo: ${image.toString()}');
    setState(() {
      _logoImage = XFile(image!.path);
      // Navigator.pop(this.context);
    });
  }

  Future getImageProfile() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    print('PickedFileProfile: ${image.toString()}');
    setState(() {
      _profileImage = XFile(image!.path);
      // Navigator.pop(this.context);
    });
  }

  List<DropdownMenuItem<int>> listItems = [
    DropdownMenuItem(
      value: 1,
      child: Text(
        "Male",
        style: StyleUtility.hintTextStyle,
      ),
    ),
    DropdownMenuItem(
      value: 2,
      child: Text(
        "Female",
        style: StyleUtility.hintTextStyle,
      ),
    )
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
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageUtility.castSignupBgImage),
                  fit: BoxFit.fill),
            ),
            child: Column(children: [
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "Hello Alen",
                  style: StyleUtility.headerTextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize22.sp),
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
                        "Your profile details",
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
                                  value: _selectedGenderValue,
                                  items: listItems,
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
                                    style: StyleUtility.hintTextStyle.copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize15.sp),
                                  ),
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedGenderValue = value!;
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
                                        fontSize: TextSizeUtility.textSize16),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                onTap: () async {
                                  await getImageProfile();
                                },
                                child: Container(
                                  height: 160.h,
                                  width: 140.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: ColorUtility.colorD6D6D8,
                                    ),
                                  ),
                                  child: _profileImage == null
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
                                                  BorderRadius.circular(10.r),
                                              child: Image.file(
                                                File(_profileImage!.path),
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
                                        fontSize: TextSizeUtility.textSize16),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                onTap: () async {
                                  await getImageLogo();
                                },
                                child: Container(
                                    height: 160.h,
                                    width: 140.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: ColorUtility.colorD6D6D8,
                                      ),
                                    ),
                                    child: _logoImage == null
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
                                                  BorderRadius.circular(10.r),
                                              child: Image.file(
                                                File(_logoImage!.path),
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
            ])));
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
            image: ImageUtility.congratulationIcon,
          );
        }).then((value) {
      print("Then is called");
    });
  }
}
