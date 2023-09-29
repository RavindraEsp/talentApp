import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/auth/signup/provider/cast_verify_phone_provider.dart';
import 'package:talent_app/network/model/request/auth/signup/SignUpRequest.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/common_dialog.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/congratulation_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/textField/custom_otp_text_field.dart';

class CastVerifyPhoneScreen extends StatefulWidget {
  final String email;
  final String phone;
  final String userName;
  final String password;
  final String confirmPassword;

  const CastVerifyPhoneScreen(
      {super.key,
      required this.email,
      required this.phone,
      required this.userName,
      required this.password,
      required this.confirmPassword});

  @override
  State<CastVerifyPhoneScreen> createState() => _CastVerifyPhoneScreenState();
}

class _CastVerifyPhoneScreenState extends State<CastVerifyPhoneScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageUtility.castSignupBgImage),
                fit: BoxFit.fill),
          ),
          child: SafeArea(
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(left: 24.w, top: 5.h),
                child: AppBar(
                  automaticallyImplyLeading: true,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    context.loc.headerSignUp,
                    style: StyleUtility.headerTextStyle
                        .copyWith(fontSize: TextSizeUtility.textSize22.sp),
                  ),
                ),
              ),
              Expanded(child: Consumer<CastVerifyPhoneProvider>(
                  builder: (context, provider, child) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        context.loc.verifyPhone,
                        style: StyleUtility.kantumruyProSemiBold5457BETextStyle
                            .copyWith(fontSize: TextSizeUtility.textSize26.sp),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      RichText(
                        text: TextSpan(
                          text: context.loc.enter4DigitCode,
                          style:
                              StyleUtility.quicksandRegular16TextStyle.copyWith(
                            fontSize: TextSizeUtility.textSize16.sp,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "544-546-xxxx",
                              style: StyleUtility.quicksandRegular16TextStyle
                                  .copyWith(
                                      color: ColorUtility.color5457BE,
                                      fontSize: TextSizeUtility.textSize16.sp,
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
                            style:
                                StyleUtility.mulishRegular16TextStyle.copyWith(
                              color: ColorUtility.color9A9A9F,
                              fontSize: TextSizeUtility.textSize16.sp,
                            ),
                          ),
                          Text(
                            context.loc.resendCode,
                            style: StyleUtility.mulishRegular16TextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp,
                                    color: ColorUtility.color5457BE,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.h),
                        child: CustomButton(
                            buttonText: context.loc.buttonContinue,
                            buttonType: ButtonType.yellow,
                            onTap: () {
                              if (otpController.text.length != 4) {
                                Common.showErrorSnackBar(
                                    context, "Please eneter 4 digit otp.");
                              } else {
                                CommonDialog.showLoadingDialog(context);
                                provider.signUp(
                                    onSuccess: (message) {
                                      Navigator.pop(context);

                                      showCongratulationDialog(context: context,onButtonTap: (){

                                      });
                                       },
                                    onFailure: (message) {
                                      Navigator.pop(context);
                                      Common.showErrorSnackBar(
                                          context, message);
                                    },
                                    request: SignupRequest(
                                        email: widget.email,
                                        mobileNumber: widget.phone,
                                        userName: widget.userName,
                                        password: widget.password,
                                        confirmPassword: widget.confirmPassword,
                                        oTP: otpController.text,
                                        talentType: 1 // for caster

                                        ));
                              }
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const CastCreateCard()));
                            }),
                      )
                    ],
                  ),
                );
              })),
            ]),
          )),
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
      Navigator.pushNamed(
          context, RouteName.castLoginScreen);

    });
  }

}
