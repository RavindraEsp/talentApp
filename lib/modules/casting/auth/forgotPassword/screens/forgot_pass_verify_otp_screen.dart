import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/auth/forgotPassword/provider/ForgotPassVerifyOtpProvider.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/congratulation_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/textField/custom_otp_text_field.dart';

class ForgotPassVerifyOtpScreen extends StatefulWidget {
  final UserType userType;
  final String email;

  const ForgotPassVerifyOtpScreen({
    super.key,
    required this.email,
    required this.userType,
  });

  @override
  State<ForgotPassVerifyOtpScreen> createState() =>
      _ForgotPassVerifyOtpScreenState();
}

class _ForgotPassVerifyOtpScreenState extends State<ForgotPassVerifyOtpScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Consumer<ForgotPassVerifyOtpProvider>(
              builder: (context, forgotPassVerifyOtpProvider, child) {
            return Stack(
              children: [
                Container(
                  height: 80.h,
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          // colors: ColorUtility.castHeaderGradientColor,
                          colors: widget.userType == UserType.cast
                              ? ColorUtility.castHeaderGradientColor
                              : ColorUtility.talentHeaderGradientColor)),
                ),
                SafeArea(
                  child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                //ImageUtility.castSignupBgImage
                                widget.userType == UserType.cast
                                    ? ImageUtility.castSignupBgImage
                                    : ImageUtility.talentSignupBgImage),
                            fit: BoxFit.fill),
                      ),
                      child: Column(children: [
                        Container(
                          //  margin: EdgeInsets.only(left: 24.w, top: 5.h),
                          margin: EdgeInsets.only(left: 24.w, top: 22.h),
                          child: AppBar(
                            automaticallyImplyLeading: true,

                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            centerTitle: true,
                            iconTheme: const IconThemeData(color: Colors.white),
                            title: Text(
                              context.loc.headerVerifyYourEmail,
                              style: StyleUtility.headerTextStyle.copyWith(
                                  fontSize: TextSizeUtility.textSize22.sp),
                            ),
                          ),
                        ),
                        Expanded(child: Consumer<ForgotPassVerifyOtpProvider>(
                            builder: (context, provider, child) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 25.h,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: context.loc.enter4DigitCodeEmail,
                                    style: StyleUtility
                                        .quicksandRegular16TextStyle
                                        .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: " ${widget.email}",
                                        style: StyleUtility
                                            .quicksandRegular16TextStyle
                                            .copyWith(
                                                color: ColorUtility.color5457BE,
                                                fontSize: TextSizeUtility
                                                    .textSize16.sp,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 35.h,
                                ),
                                CustomOtpTextField(controller: otpController),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      context.loc.didntReceive,
                                      style: StyleUtility
                                          .mulishRegular16TextStyle
                                          .copyWith(
                                        color: ColorUtility.color9A9A9F,
                                        fontSize: TextSizeUtility.textSize16.sp,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Common.showLoadingDialog(context);
                                        provider.forgotPassGetOtp(
                                            onSuccess: (message) {
                                              Navigator.pop(context);
                                              Common.showSuccessToast(
                                                  context, message);
                                              CommonMethod.hideKeyBoard(context);

                                                },
                                            onFailure: (message) {
                                              Navigator.pop(context);
                                            },
                                            request: {
                                              "emailormobile": widget.email,
                                              "userType": widget.userType ==
                                                      UserType.talent
                                                  ? 1
                                                  : 2
                                            });
                                      },
                                      child: Text(
                                        context.loc.resendCode,
                                        style: StyleUtility
                                            .mulishRegular16TextStyle
                                            .copyWith(
                                                fontSize: TextSizeUtility
                                                    .textSize16.sp,
                                                color: ColorUtility.color5457BE,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 89.h,
                                ),
                                CustomButton(
                                    buttonText: context.loc.buttonContinue,
                                    //  buttonType: ButtonType.yellow,
                                    buttonType: widget.userType == UserType.cast
                                        ? ButtonType.yellow
                                        : ButtonType.blue,
                                    onTap: () {
                                      if (otpController.text.length != 4) {
                                        Common.showErrorToast(
                                            context, context.loc.validationOtp);
                                      } else {
                                        Common.showLoadingDialog(context);
                                        forgotPassVerifyOtpProvider
                                            .forgotPassMobileotpVerify(
                                                onSuccess: (message) {
                                                  Navigator.pop(context);
                                                  Common.showSuccessToast(
                                                      context, message);

                                                  Navigator.pushNamed(
                                                      context,
                                                      RouteName
                                                          .createNewPassScreen,
                                                      arguments: {
                                                        "userType":
                                                            widget.userType,
                                                        "email": widget.email,
                                                        "otp":
                                                            otpController.text,
                                                      });
                                                },
                                                onFailure: (message) {
                                                  Navigator.pop(context);
                                                  Common.showErrorToast(
                                                      context, message);
                                                },
                                                request: {
                                              "emailormobile": widget.email,
                                              "otp": otpController.text
                                            });
                                      }
                                    })
                              ],
                            ),
                          );
                        })),
                      ])),
                ),
              ],
            );
          }),
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
            image: ImageUtility.congratulationIcon,
            title: context.loc.congratulations,
            description: context.loc.dialogAccountReadyDesc,
            buttonText: context.loc.buttonNext,
          );
        }).then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, RouteName.castLoginScreen);
    });
  }
}
