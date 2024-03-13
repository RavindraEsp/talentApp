import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/auth/forgotPassword/provider/create_new_pass_screen_provider.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/utilities/validation.dart';
import 'package:talent_app/widgets/alertDialog/congratulation_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

class CreateNewPassScreen extends StatefulWidget {
  final UserType userType;
  final String email;
  final String otp;

  const CreateNewPassScreen({super.key,
    required this.userType, required this.email, required this.otp});

  @override
  State<CreateNewPassScreen> createState() => _CreateNewPassScreenState();
}

class _CreateNewPassScreenState extends State<CreateNewPassScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: widget.userType == UserType.cast
                        ? ColorUtility.castHeaderGradientColor
                        : ColorUtility.talentHeaderGradientColor)),
          ),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.userType == UserType.cast
                        ? ImageUtility.castSignupBgImage
                        : ImageUtility.talentSignupBgImage),
                    fit: BoxFit.fill),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 24.w, top: 22.h),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        centerTitle: true,
                        iconTheme: const IconThemeData(color: Colors.white),
                        title: Text(
                          "Create new password",
                          style: StyleUtility.headerTextStyle.copyWith(
                              fontSize: TextSizeUtility.textSize22.sp),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          CommonMethod.hideKeyBoard(context);
                        },
                        child: SingleChildScrollView(
                          child: Consumer<CreateNewPassScreenProvider>(
                            builder: (context, createNewPassScreenProvider,child) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 70.h,
                                    ),
                                    SimpleTextField(
                                      controller: passwordController,
                                      suffixImage: ImageUtility.passLocIcon,
                                      hintText: context.loc.hintNewPassword,
                                      validator:
                                          Validators(context).validatorPassword,
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    SimpleTextField(
                                      controller: confirmPasswordController,
                                      suffixImage: ImageUtility.passLocIcon,
                                      hintText: context.loc.hintConfirmPassword,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return context.loc.validationPass;
                                        } else if (passwordController.text !=
                                            confirmPasswordController.text) {
                                          return context.loc.validationPassNotMatch;
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    SizedBox(
                                      height: 29.h,
                                    ),
                                    CustomButton(
                                      buttonText: context.loc.buttonContinue,
                                      buttonType: widget.userType == UserType.cast
                                          ? ButtonType.yellow
                                          : ButtonType.blue,
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          CommonMethod.hideKeyBoard(context);

                                          Common.showLoadingDialog(context);

                                          createNewPassScreenProvider.forgotPassSetNewPass(
                                              onSuccess: (message) {
                                                Navigator.pop(context);
                                                showCongratulationDialog(
                                                    context: context, onButtonTap: () {});

                                              },
                                              onFailure: (message) {
                                                Navigator.pop(context);
                                                Common.showErrorToast(
                                                    context, message);
                                              },

                                              request: {
                                                "emailormobile" :widget.email,
                                                "otp" :widget.otp,
                                                "password" :passwordController.text,
                                                "confirmPassword" :confirmPasswordController.text,
                                                "userType": widget.userType ==
                                                    UserType.talent
                                                    ? 1
                                                    : 2
                                              });

                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                  ],
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showCongratulationDialog({
    required BuildContext context,
    required VoidCallback onButtonTap,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CongratulationAlertDialog(
            title: context.loc.dialogPasswordChanged,
            description:
                context.loc.dialogCongratulationsYouSuccessfullyChangedYourPassword,
            buttonText: context.loc.buttonGoToLogin,
            onButtonTap: onButtonTap,
            userType: widget.userType,
          );
        }).then((value) {
      AppLogger.logD("Then is called");
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }
}
