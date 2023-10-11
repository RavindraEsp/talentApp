import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/talent/commonModels/drop_down_model.dart';
import 'package:talent_app/modules/talent/createCard/screens/talent_create_card_step_two_screen.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/utilities/validation.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/custom_drop_down_widget.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

class TalentCreateCardScreen extends StatefulWidget {
  const TalentCreateCardScreen({super.key});

  @override
  State<TalentCreateCardScreen> createState() => _TalentCreateCardScreenState();
}

class _TalentCreateCardScreenState extends State<TalentCreateCardScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  final _createCardKey = GlobalKey<FormState>();

  DropDownModel? selectGender;

  List<DropDownModel> genderList = [
    DropDownModel("Male", "1"),
    DropDownModel("Female", "1")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          CommonMethod.hideKeyBoard(context);
        },
        child: Stack(
          children: [
            Container(
              height: 80.h,
              width: double.infinity,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: ColorUtility.talentHeaderGradientColor)),
            ),
            SafeArea(
                child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageUtility.talentSignupBgImage),
                          fit: BoxFit.fill),
                    ),
                    child: Column(children: [
                      Container(
                        //  margin: EdgeInsets.only(left: 24.w, top: 12.h),
                        margin: EdgeInsets.only(left: 24.w, top: 22.h),
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          centerTitle: true,
                          title: Text(
                            context.loc.headerCreateCard,
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
                                context.loc.titleCreateCardDescription,
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
                                      controller: firstNameController,
                                      validator: Validators(context)
                                          .validatorFirstName,
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
                                          Validators(context).validatorId,
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
                                height: 40.h,
                              ),
                            ]),
                      )),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                        child: CustomButton(
                          buttonText: context.loc.buttonNext,
                          buttonType: ButtonType.blue,
                          onTap: () async {
                            if (_createCardKey.currentState!.validate()) {
                              if (selectGender != null) {
                                Navigator.pushNamed(context,
                                    RouteName.talentCreateCardStepTwoScreen);
                              } else {
                                Common.showErrorSnackBar(
                                    context, context.loc.validationGender);
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                    ]))),
          ],
        ),
      ),
    );
  }
}
