import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/auth/login/provider/cast_login_provider.dart';
import 'package:talent_app/network/model/request/auth/login_request.dart';
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
import 'package:talent_app/widgets/textField/simple_text_field.dart';

class CastLoginScreen extends StatefulWidget {
  final UserType userType;

  const CastLoginScreen({super.key, required this.userType});

  @override
  State<CastLoginScreen> createState() => _CastLoginScreenState();
}

class _CastLoginScreenState extends State<CastLoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                    // colors: ColorUtility.castHeaderGradientColor

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
                      // margin: EdgeInsets.only(left: 24.w, top: 5.h),
                      margin: EdgeInsets.only(left: 24.w, top: 22.h),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        centerTitle: true,
                        iconTheme: const IconThemeData(color: Colors.white),
                        title: Text(
                          context.loc.headerLogIn,
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
                          child: Consumer<CastLoginProvider>(
                              builder: (context, castLoginProvider, child) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Text(
                                    context.loc.hello,
                                    textAlign: TextAlign.center,
                                    style: StyleUtility
                                        .kantumruyProSemiBold5457BETextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize26.sp),
                                  ),
                                  SizedBox(
                                    height: 6.5.h,
                                  ),
                                  Text(
                                    context.loc.signInToContinue,
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
                                    controller: nameController,
                                    suffixImage: ImageUtility.userIcon,
                                    hintText: context.loc.hintUserName,
                                    validator:
                                        Validators(context).validatorName,
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  SimpleTextField(
                                    controller: passwordController,
                                    suffixImage: ImageUtility.passLocIcon,
                                    hintText: context.loc.hintPassword,
                                    validator:
                                        Validators(context).validatorPassword,
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          RouteName
                                              .forgotPassFindAccountScreen,
                                          arguments: {
                                            "userType": widget.userType
                                          });
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        context.loc.forgotPassword,
                                        style: StyleUtility
                                            .quicksandRegular15TextStyle
                                            .copyWith(
                                                fontSize: TextSizeUtility
                                                    .textSize12.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 29.h,
                                  ),
                                  CustomButton(
                                    buttonText: context.loc.buttonLogIn,
                                    // buttonType: ButtonType.yellow,

                                    buttonType: widget.userType == UserType.cast
                                        ? ButtonType.yellow
                                        : ButtonType.blue,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        CommonMethod.hideKeyBoard(context);

                                        ///Todo temp

                                        // if (widget.userType == UserType.cast) {
                                        //   Navigator.pushNamedAndRemoveUntil(
                                        //       context,
                                        //       RouteName.castBottomBarScreen,
                                        //       arguments: {"selectIndex": 0},
                                        //       (route) => false);
                                        // } else {
                                        //   Navigator.pushNamedAndRemoveUntil(
                                        //       context,
                                        //       RouteName.talentBottomBarScreen,
                                        //       arguments: {"selectIndex": 0},
                                        //           (route) => false);
                                        // }


                                        ///with api

                                        Common.showLoadingDialog(context);
                                        castLoginProvider.login(
                                            onSuccess: (response) {
                                              Navigator.pop(context);
                                              Common.showSuccessToast(
                                                  context, response.msg ?? "");



                                              if (widget.userType == UserType.cast) {



                                                // Navigator.pushNamedAndRemoveUntil(
                                                //     context,
                                                //     RouteName.castCreateCardScreen,
                                                //     arguments: {
                                                //       "userId":0,
                                                //     },
                                                //         (route) => false);


                                                ///valid
                                                if(response.data?.isCardcreated == true){

                                                  Navigator.pushNamedAndRemoveUntil(
                                                      context,
                                                      RouteName.castBottomBarScreen,
                                                      arguments: {"selectIndex": 0},
                                                          (route) => false);
                                                }else{

                                                  Navigator.pushNamedAndRemoveUntil(
                                                      context,
                                                      RouteName.castCreateCardScreen,
                                                          (route) => false);
                                                }




                                              } else {
                                                Navigator.pushNamedAndRemoveUntil(
                                                    context,
                                                    RouteName.talentBottomBarScreen,
                                                    arguments: {"selectIndex": 0},
                                                        (route) => false);
                                              }


                                            },
                                            onFailure: (message) {
                                              Navigator.pop(context);
                                              Common.showErrorSnackBar(
                                                  context, message);
                                            },
                                            request: LoginRequest(
                                                userName: nameController.text,
                                                password: passwordController.text,
                                                userType: widget.userType == UserType.talent  ? 1 :2,// for caster
                                                fCMToken: "fcm token001"));
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 72.h,
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
                                    height: 58.h,
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
                                    height: 35.h,
                                  ),
                                ],
                              ),
                            );
                          }),
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
}
