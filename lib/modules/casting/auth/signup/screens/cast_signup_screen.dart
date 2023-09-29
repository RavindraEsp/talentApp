import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/auth/signup/provider/signup_screen_provider.dart';
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
import 'package:talent_app/widgets/buttons/social_button.dart';
import 'package:talent_app/widgets/custom_gradient_checkbox.dart';
import 'package:talent_app/widgets/textField/mobile_number_text_field.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

class CastSignupScreen extends StatefulWidget {
  const CastSignupScreen({super.key});

  @override
  State<CastSignupScreen> createState() => _CastSignupScreenState();
}

class _CastSignupScreenState extends State<CastSignupScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool passwordObscure = true;
  bool confPasswordObscure = true;
  String passPrefixImage = ImageUtility.eyeOpenIcon;
  String confPassPrefixImage = ImageUtility.eyeOpenIcon;
  bool isChecked = false;
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
                child: Form(
                  key: _formKey,
                  child: Consumer<SignUpScreenProvider>(
                      builder: (context, provider, child) {
                    return Column(
                      children: [
                        Container(
                          //  margin: EdgeInsets.only(left: 24.w, top: 5.h),
                          margin: EdgeInsets.only(left: 24.w, top: 22.h),
                          child: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            centerTitle: true,
                            title: Text(
                              context.loc.headerSignUp,
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
                                    context.loc.joinUs,
                                    textAlign: TextAlign.center,
                                    style: StyleUtility
                                        .kantumruyProSemiBold5457BETextStyle
                                        .copyWith(
                                            fontSize: TextSizeUtility
                                                .textSize26.sp),
                                  ),
                                  SizedBox(
                                    height: 6.5.h,
                                  ),
                                  Text(
                                    context.loc.createNewAccount,
                                    textAlign: TextAlign.center,
                                    style: StyleUtility
                                        .quicksandRegular16TextStyle
                                        .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  SimpleTextField(
                                    controller: userNameController,
                                    suffixImage: ImageUtility.userIcon,
                                    hintText: context.loc.hintCreateUserName,
                                    validator:
                                        Validators(context).validatorName,
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  SimpleTextField(
                                    controller: passwordController,
                                    suffixImage: passPrefixImage,
                                    hintText: context.loc.hintCreatePassword,
                                    passwordObscure: passwordObscure,
                                    validator:
                                        Validators(context).validatorPassword,
                                    onPrefixIconTap: () {
                                      passwordObscure = !passwordObscure;
                                      if (passwordObscure == true) {
                                        passPrefixImage =
                                            ImageUtility.eyeOpenIcon;
                                      } else {
                                        passPrefixImage =
                                            ImageUtility.eyeCloseIcon;
                                      }
                                      provider.updateUi();
                                    },
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  SimpleTextField(
                                    controller: confirmPasswordController,
                                    suffixImage: confPassPrefixImage,
                                    hintText: context.loc.hintConfirmPassword,
                                    passwordObscure: confPasswordObscure,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Password is required.';
                                      } else if (passwordController.text !=
                                          confirmPasswordController.text) {
                                        return 'Password did not match.';
                                      }
                                      return null;
                                    },
                                    onPrefixIconTap: () {
                                      confPasswordObscure =
                                          !confPasswordObscure;
                                      if (confPasswordObscure == true) {
                                        confPassPrefixImage =
                                            ImageUtility.eyeOpenIcon;
                                      } else {
                                        confPassPrefixImage =
                                            ImageUtility.eyeCloseIcon;
                                      }

                                      provider.updateUi();
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
                                      AppLogger.logD(
                                          "Number ${value.number}");
                                    },
                                  ),
                                  SizedBox(
                                    height: 29.h,
                                  ),
                                  CustomGradientCheckbox(
                                      isChecked: isChecked,
                                      title: context.loc.rememberMe,
                                      onChanged: (value) {
                                        isChecked = value;
                                        provider.updateUi();
                                      }),
                                  SizedBox(
                                    height: 29.h,
                                  ),
                                  CustomButton(
                                    buttonText: context.loc.buttonSignUp,
                                    buttonType: ButtonType.yellow,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (phoneController.text.length < 6) {
                                          Common.showErrorSnackBar(context,
                                              context.loc.validationPhone);
                                        } else {
                                          CommonMethod.hideKeyBoard(context);

                                          ///Todo temp
                                          Navigator.pushNamed(context,
                                              RouteName.castVerifyPhoneScreen,
                                              arguments: {
                                                "email": emailController.text,
                                                "phone": phoneController.text,
                                                "userName":
                                                    userNameController.text,
                                                "password":
                                                    passwordController.text,
                                                "confirmPassword":
                                                    confirmPasswordController
                                                        .text,
                                              });

                                          // Common.showLoadingDialog(context);
                                          // provider.signUpGetOtp(
                                          //     onSuccess: (message) {
                                          //       Navigator.pop(context);
                                          //       Common.showSuccessToast(
                                          //           context, message);
                                          //
                                          //       Navigator.pushNamed(context,
                                          //           RouteName.castVerifyPhoneScreen,
                                          //           arguments: {
                                          //             "email": emailController.text,
                                          //             "phone": phoneController.text,
                                          //             "userName":
                                          //                 userNameController.text,
                                          //             "password":
                                          //                 passwordController.text,
                                          //             "confirmPassword":
                                          //                 confirmPasswordController
                                          //                     .text,
                                          //           });
                                          //     },
                                          //     onFailure: (message) {
                                          //       Navigator.pop(context);
                                          //       Common.showErrorSnackBar(
                                          //           context, message);
                                          //     },
                                          //     request: SignupSendOtpRequest(
                                          //         email: emailController.text,
                                          //         mobileNumber:
                                          //             phoneController.text));
                                        }
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 28.h,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        color: ColorUtility.color9A9A9F,
                                        height: 1,
                                      )),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          context.loc.or,
                                          style: StyleUtility
                                              .quicksandRegular16TextStyle
                                              .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize16.sp,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        color: ColorUtility.color9A9A9F,
                                        height: 1,
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 29.h,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SocialButton(
                                          buttonText: context.loc.buttonVia,
                                          onTap: () {},
                                          icon: ImageUtility.googleIcon,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 14.w,
                                      ),
                                      Expanded(
                                        child: SocialButton(
                                          buttonText: context.loc.buttonVia,
                                          onTap: () {},
                                          icon: ImageUtility.fbIcon,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 45.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
