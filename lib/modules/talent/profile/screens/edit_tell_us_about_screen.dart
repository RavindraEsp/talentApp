import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/congratulation_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';

import 'package:talent_app/widgets/textField/simple_text_field.dart';

class EditTellUsAboutScreen extends StatefulWidget {
  const EditTellUsAboutScreen({super.key});

  @override
  State<EditTellUsAboutScreen> createState() => _EditTellUsAboutScreenState();
}

class _EditTellUsAboutScreenState extends State<EditTellUsAboutScreen> {
  final _formKey = GlobalKey<FormState>();



  TextEditingController aboutYouController = TextEditingController();


  @override
  void initState() {
    super.initState();

    aboutYouController.text = "My name is Michaela, and I’m thrilled to be here auditioning for this incredible movie opportunity. Allow me to introduce myself and share a little about who I am. I am an aspiring actress with a burning passion for storytelling through the magic of film.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
      body: Stack(
        children: [

          SafeArea(
              child: Column(children: [


                Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding:  EdgeInsets.all(20.w),
                      child: Image.asset(ImageUtility.crossIcon,
                      height: 20.w,width: 20.w,),
                    ),
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        CommonMethod.hideKeyBoard(context);
                      },
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 18.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [




                              Text(
                                context.loc.titleTellUsAboutYou,
                                style: StyleUtility
                                    .kantumruyProMedium5457BETextStyle
                                    .copyWith(
                                    fontSize:
                                    TextSizeUtility.textSize18.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SimpleTextField(
                                controller: aboutYouController,
                                hintText: context
                                    .loc.hintWriteAFewWordsAboutYourself,
                                maxLine: 7,
                              ),
                              SizedBox(
                                height: 27.h,
                              ),


                              CustomButtonTopToBottomColor(
                                width: MediaQuery.of(context).size.width,
                                buttonText: context.loc.buttonUpdate,
                              ),

                              SizedBox(
                                height: 35.h,
                              ),
                        ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ])),
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
            title: context.loc.dialogWellDone,
            description: context.loc.dialogTalentCardSetSuccessDescription,
            buttonText: context.loc.buttonImReadyBringItOn,
            onButtonTap: onButtonTap,
            userType: UserType.talent,
          );
        }).then((value) {
      AppLogger.logD("Then is called");
    });
  }
}
