import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/auth/signup/provider/cast_verify_phone_provider.dart';
import 'package:talent_app/network/model/request/auth/signup/SignUpRequest.dart';
import 'package:talent_app/network/model/request/auth/signup/SignUpSendOtpRequest.dart';
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
  final UserType userType;

  final String email;
  final String phone;
  final String countyCode;
  final String userName;
  final String password;
  final String confirmPassword;

  const CastVerifyPhoneScreen(
      {super.key,
      required this.userType,
      required this.email,
      required this.phone,
      required this.countyCode,
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
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
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
                        //  colors: ColorUtility.castHeaderGradientColor,
                        colors: widget.userType == UserType.cast
                            ? ColorUtility.castHeaderGradientColor
                            : ColorUtility.talentHeaderGradientColor)),
              ),
              SafeArea(
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              //  ImageUtility.castSignupBgImage
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
                          iconTheme: const IconThemeData(color: Colors.white),
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
                            style: StyleUtility.headerTextStyle.copyWith(
                                fontSize: TextSizeUtility.textSize22.sp),
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
                                style: StyleUtility
                                    .kantumruyProSemiBold5457BETextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize26.sp),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: context.loc.enter4DigitCode,
                                  style: StyleUtility
                                      .quicksandRegular16TextStyle
                                      .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          " ${widget.countyCode} ${widget.phone}",
                                      style: StyleUtility
                                          .quicksandRegular16TextStyle
                                          .copyWith(
                                              color: ColorUtility.color5457BE,
                                              fontSize:
                                                  TextSizeUtility.textSize16.sp,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 35.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.h),
                                child: CustomOtpTextField(
                                    controller: otpController),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    context.loc.didntReceive,
                                    style: StyleUtility.mulishRegular16TextStyle
                                        .copyWith(
                                      color: ColorUtility.color9A9A9F,
                                      fontSize: TextSizeUtility.textSize16.sp,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Common.showLoadingDialog(context);
                                      provider.reSendOtp(
                                          onSuccess: (message) {
                                            Navigator.pop(context);
                                            Common.showSuccessToast(
                                                context, message);

                                          },
                                          onFailure: (message) {
                                            Navigator.pop(context);
                                            Common.showErrorSnackBar(
                                                context, message);
                                          },
                                          request: SignupSendOtpRequest(
                                              email: widget.email,
                                              mobileNumber:
                                              widget.phone,

                                              userType: widget.userType ==
                                                  UserType.talent
                                                  ? 1
                                                  : 2, // for caster
                                              userName: widget.userName,
                                              apiType: "signup"
                                          ));
                                    },
                                    child: Text(
                                      context.loc.resendCode,
                                      style: StyleUtility.mulishRegular16TextStyle
                                          .copyWith(
                                              fontSize:
                                                  TextSizeUtility.textSize16.sp,
                                              color: ColorUtility.color5457BE,
                                              fontWeight: FontWeight.bold),
                                    ),
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
                                    // buttonType: ButtonType.yellow,
                                    buttonType: widget.userType == UserType.cast
                                        ? ButtonType.yellow
                                        : ButtonType.blue,
                                    onTap: () {
                                      if (otpController.text.length != 4) {
                                        Common.showErrorToast(context,
                                            "Please enter 4 digit otp.");
                                      } else {
                                        /// TODO temp

                                        // showCongratulationDialog(
                                        //     context: context,
                                        //     onButtonTap: () {});

                                        CommonDialog.showLoadingDialog(context);
                                        provider.signUp(
                                            onSuccess: (message) {
                                              Navigator.pop(context);

                                              showCongratulationDialog(
                                                  context: context,
                                                  onButtonTap: () {});
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
                                                confirmPassword:
                                                    widget.confirmPassword,
                                                oTP: otpController.text,
                                                userType: widget.userType ==
                                                        UserType.talent
                                                    ? 1
                                                    : 2 // for caster

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
                    ])),
              ),
            ],
          ),
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
            userType: widget.userType,
          );
        }).then((value) {
      if (widget.userType == UserType.cast) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushNamed(context, RouteName.castLoginScreen,
            arguments: {"userType": UserType.cast});
      } else {
        // Navigator.pop(context);
        // Navigator.pop(context);
        // Navigator.pushNamed(context, RouteName.talentCreateCardScreen);

        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushNamed(context, RouteName.castLoginScreen,
            arguments: {"userType": UserType.talent});
      }
    });
  }
}
