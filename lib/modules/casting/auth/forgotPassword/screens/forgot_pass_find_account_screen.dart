import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/utilities/validation.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

class ForgotPassFindAccountScreen extends StatefulWidget {
  final UserType userType;

  const ForgotPassFindAccountScreen({super.key, required this.userType});

  @override
  State<ForgotPassFindAccountScreen> createState() =>
      _ForgotPassFindAccountScreenState();
}

class _ForgotPassFindAccountScreenState
    extends State<ForgotPassFindAccountScreen> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          CommonMethod.hideKeyBoard(context);
        },
        child: Stack(
          children: [
            Container(
              height: 80.h,
              width: double.infinity,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      //  colors: ColorUtility.castHeaderGradientColor

                      colors: widget.userType == UserType.cast
                          ? ColorUtility.castHeaderGradientColor
                          : ColorUtility.talentHeaderGradientColor)),
            ),
            SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          // ImageUtility.castSignupBgImage
                          widget.userType == UserType.cast
                              ? ImageUtility.castSignupBgImage
                              : ImageUtility.talentSignupBgImage),
                      fit: BoxFit.fill),
                ),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          //  margin: EdgeInsets.only(left: 24.w, top: 5.h),
                          margin: EdgeInsets.only(left: 24.w, top: 22.h),
                          child: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            centerTitle: true,
                            title: Text(
                              context.loc.headerFindYourAccount,
                              style: StyleUtility.headerTextStyle.copyWith(
                                  fontSize: TextSizeUtility.textSize22.sp),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Text(
                                    context.loc.pleaseEnterYourEmailAddressTextToForgotPassText,
                                    textAlign: TextAlign.center,
                                    style: StyleUtility
                                        .quicksandRegular9F9E9ETextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize16.sp),
                                  ),
                                  SizedBox(
                                    height: 43.h,
                                  ),
                                  SimpleTextField(
                                    controller: emailController,
                                    hintText: context.loc.hintEmail,
                                    textInputType: TextInputType.emailAddress,
                                    validator:
                                        Validators(context).validatorEmail,
                                  ),
                                  SizedBox(
                                    height: 70.h,
                                  ),
                                  CustomButton(
                                    buttonText: context.loc.buttonContinue,
                                    //   buttonType: ButtonType.yellow,
                                    buttonType: widget.userType == UserType.cast
                                        ? ButtonType.yellow
                                        : ButtonType.blue,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.pushNamed(context,
                                            RouteName.forgotPassVerifyOtpScreen,
                                            arguments: {
                                              "email": emailController.text,
                                              "userType": widget.userType
                                            });
                                      }
                                    },
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
