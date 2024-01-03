// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:talent_app/extension/context_extension.dart';
// import 'package:talent_app/logger/app_logger.dart';
// import 'package:talent_app/modules/casting/createAudition/providers/create_audition_provider.dart';
// import 'package:talent_app/modules/talent/commonModels/drop_down_model.dart';
// import 'package:talent_app/modules/talent/createCard/models/talent_create_card_model.dart';
// import 'package:talent_app/modules/talent/createCard/provider/talent_create_card_step_two_provider.dart';
// import 'package:talent_app/modules/talent/createCard/widgets/talent_body_drop_down_widget.dart';
// import 'package:talent_app/routes/route_name.dart';
// import 'package:talent_app/utilities/color_utility.dart';
// import 'package:talent_app/utilities/common.dart';
// import 'package:talent_app/utilities/common_method.dart';
// import 'package:talent_app/utilities/enums.dart';
// import 'package:talent_app/utilities/image_utility.dart';
// import 'package:talent_app/utilities/style_utility.dart';
// import 'package:talent_app/utilities/text_size_utility.dart';
// import 'package:talent_app/utilities/validation.dart';
// import 'package:talent_app/widgets/buttons/custom_button.dart';
// import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
// import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
// import 'package:talent_app/widgets/custom_drop_down_widget.dart';
// import 'package:talent_app/widgets/textField/simple_text_field.dart';
//
// class TalentCreateCardStepTwoScreen extends StatefulWidget {
//   final TalentCreateCardModel talentCreateCardModel;
//
//   TalentCreateCardStepTwoScreen(
//       {super.key, required this.talentCreateCardModel});
//
//   @override
//   State<TalentCreateCardStepTwoScreen> createState() =>
//       _TalentCreateCardStepTwoScreenState();
// }
//
// class _TalentCreateCardStepTwoScreenState
//     extends State<TalentCreateCardStepTwoScreen> {
//   TalentCreateCardModel? talentCreateCardModel;
//
//   DropDownModel? selectEyeColor;
//   DropDownModel? selectHairColor;
//   DropDownModel? selectHeight;
//   DropDownModel? selectWeight;
//   DropDownModel? selectShirtSize;
//   DropDownModel? selectPansSize;
//   DropDownModel? selectShoeSize;
//
//   List<DropDownModel> eyeColorList = [
//     DropDownModel("Red", "1"),
//     DropDownModel("Green", "1")
//   ];
//   List<DropDownModel> hairColorList = [
//     DropDownModel("White", "1"),
//     DropDownModel("Black", "1")
//   ];
//
//   // List<DropDownModel> heightList = [
//   //   DropDownModel("5 Meter", "5"),
//   //   DropDownModel("4 Meter", "4")
//   // ];
//   // List<DropDownModel> weightList = [
//   //   DropDownModel("50 Kg", "50"),
//   //   DropDownModel("40 Kg", "40")
//   // ];
//   List<DropDownModel> shirtSizeList = [
//     DropDownModel("L", "1"),
//     DropDownModel("XL", "2")
//   ];
//   List<DropDownModel> pansSizeList = [
//     DropDownModel("Pants 1", "1"),
//     DropDownModel("Pants 2", "2")
//   ];
//   List<DropDownModel> shoeSizeList = [
//     DropDownModel("7", "7"),
//     DropDownModel("8", "8")
//   ];
//
//   TextEditingController heightController = TextEditingController();
//   TextEditingController weightController = TextEditingController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     talentCreateCardModel = widget.talentCreateCardModel;
//
//     Provider.of<TalentCreateCardStepTwoProvider>(context, listen: false).getTalentData(
//         onFailure: (msg) {
//           Common.showErrorToast(context, msg);
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           Container(
//             height: 80.h,
//             width: double.infinity,
//             alignment: Alignment.topCenter,
//             decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.bottomLeft,
//                     end: Alignment.topRight,
//                     colors: ColorUtility.talentHeaderGradientColor)),
//           ),
//           SafeArea(
//               child: Container(
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage(ImageUtility.talentSignupBgImage),
//                         fit: BoxFit.fill),
//                   ),
//                   child: GestureDetector(
//                     onTap: () {
//                       CommonMethod.hideKeyBoard(context);
//                     },
//                     child: Consumer<TalentCreateCardStepTwoProvider>(
//                       builder: (context, talentCreateCardStepTwoProvider, child) {
//                         return
//
//                           talentCreateCardStepTwoProvider.isLoading == true
//                               ? const CustomCircularLoaderWidget():Column(children: [
//                           Container(
//                             //  margin: EdgeInsets.only(left: 24.w, top: 12.h),
//                             margin: EdgeInsets.only(left: 24.w, top: 22.h),
//
//                             child: AppBar(
//                               backgroundColor: Colors.transparent,
//                               elevation: 0,
//                               centerTitle: true,
//                               iconTheme: const IconThemeData(color: Colors.white),
//                               title: Text(
//                                 context.loc.headerCreateCard,
//                                 style: StyleUtility.headerTextStyle.copyWith(
//                                     fontSize: TextSizeUtility.textSize18.sp),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                               child: ListView(
//                                   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                                   children: [
//                                 SizedBox(
//                                   height: 30.h,
//                                 ),
//                                 Text(
//                                   context.loc.titleCreateCardDescription,
//                                   style: StyleUtility
//                                       .quicksandSemiBold5457BETextStyle
//                                       .copyWith(
//                                           fontSize: TextSizeUtility.textSize16.sp),
//                                 ),
//                                 SizedBox(
//                                   height: 25.h,
//                                 ),
//                                     TalentBodyDropDownWidget(
//                                     ovValueChange: (item) {
//                                       talentCreateCardStepTwoProvider.selectEyeColor = item;
//                                       setState(() {});
//                                     },
//                                     dropDownList: talentCreateCardStepTwoProvider.eyeColorModel,
//                                         selectItem: talentCreateCardStepTwoProvider.selectEyeColor,
//                                     hintText: context.loc.hintEyeColor
//                                     // hintText: context.loc.hint
//                                     ),
//
//
//                                 SizedBox(
//                                   height: 22.h,
//                                 ),
//                                 CustomDropDownWidget(
//                                     ovValueChange: (item) {
//                                       selectHairColor = item;
//                                       setState(() {});
//                                     },
//                                     dropDownList: hairColorList,
//                                     selectItem: selectHairColor,
//                                     hintText: context.loc.hintHairColor),
//                                 SizedBox(
//                                   height: 22.h,
//                                 ),
//                                 // CustomDropDownWidget(
//                                 //     ovValueChange: (item) {
//                                 //       selectHeight = item;
//                                 //       setState(() {});
//                                 //     },
//                                 //     dropDownList: heightList,
//                                 //     selectItem: selectHeight,
//                                 //     hintText: context.loc.hintHeight),
//                                 // SizedBox(
//                                 //   height: 22.h,
//                                 // ),
//                                 // CustomDropDownWidget(
//                                 //     ovValueChange: (item) {
//                                 //       selectWeight = item;
//                                 //       setState(() {});
//                                 //     },
//                                 //     dropDownList: weightList,
//                                 //     selectItem: selectWeight,
//                                 //     hintText: context.loc.hintWeight),
//                                 // SizedBox(
//                                 //   height: 22.h,
//                                 // ),
//                                 CustomDropDownWidget(
//                                     ovValueChange: (item) {
//                                       selectShirtSize = item;
//                                       setState(() {});
//                                     },
//                                     dropDownList: shirtSizeList,
//                                     selectItem: selectShirtSize,
//                                     hintText: context.loc.hintShirtSize),
//                                 SizedBox(
//                                   height: 22.h,
//                                 ),
//                                 CustomDropDownWidget(
//                                     ovValueChange: (item) {
//                                       selectPansSize = item;
//                                       setState(() {});
//                                     },
//                                     dropDownList: pansSizeList,
//                                     selectItem: selectPansSize,
//                                     hintText: context.loc.hintPantsSize),
//                                 SizedBox(
//                                   height: 22.h,
//                                 ),
//                                 CustomDropDownWidget(
//                                     ovValueChange: (item) {
//                                       selectShoeSize = item;
//                                       setState(() {});
//                                     },
//                                     dropDownList: shoeSizeList,
//                                     selectItem: selectShoeSize,
//                                     hintText: context.loc.hintShoeSize),
//
//                                 SizedBox(
//                                   height: 22.h,
//                                 ),
//
//                                 Text(
//                                   context.loc.titleWeightRange,
//                                   style: StyleUtility
//                                       .quicksandSemiBold5457BETextStyle
//                                       .copyWith(
//                                           fontSize: TextSizeUtility.textSize16.sp),
//                                 ),
//                                 SizedBox(
//                                   height: 10.h,
//                                 ),
//                                 SimpleTextField(
//                                   controller: weightController,
//                                   hintText: context.loc.hintMin,
//                                   textInputType: TextInputType.number,
//                                   validator: Validators(context).validatorMinWeight,
//                                 ),
//                                 SizedBox(
//                                   height: 27.h,
//                                 ),
//                                 Text(
//                                   context.loc.titleHeightRange,
//                                   style: StyleUtility
//                                       .quicksandSemiBold5457BETextStyle
//                                       .copyWith(
//                                           fontSize: TextSizeUtility.textSize16.sp),
//                                 ),
//                                 SizedBox(
//                                   height: 10.h,
//                                 ),
//                                 SimpleTextField(
//                                   controller: heightController,
//                                   hintText: context.loc.hintMin,
//                                   textInputType: TextInputType.number,
//                                   validator: Validators(context).validatorMinHeight,
//                                 ),
//
//                                 SizedBox(
//                                   height: 10.h,
//                                 ),
//                                 SizedBox(
//                                   height: 40.h,
//                                 ),
//                               ])),
//                           Container(
//                             padding: EdgeInsets.only(
//                               left: 20.w,
//                               right: 20.w,
//                               top: 20.h,
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                     child: CustomOutlineButton(
//                                         buttonText: context.loc.buttonBack,
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         buttonColor: ColorUtility.color5457BE)),
//                                 SizedBox(
//                                   width: 10.w,
//                                 ),
//                                 Expanded(
//                                   child: CustomButton(
//                                     buttonText: context.loc.buttonNext,
//                                     buttonType: ButtonType.blue,
//                                     onTap: () async {
//                                       talentCreateCardModel = TalentCreateCardModel(
//                                           weight: weightController.text,
//                                           height: heightController.text);
//                                       AppLogger.logD(
//                                           talentCreateCardModel?.toJson());
//                                       Navigator.pushNamed(
//                                           context, RouteName.addYourPhotoScreen,
//                                           arguments: {
//                                             "talentCreateCardModel": talentCreateCardModel
//                                           });
//                                     },
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 35.h,
//                           ),
//                         ]);
//                       }
//                     ),
//                   ))),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/providers/create_audition_provider.dart';
import 'package:talent_app/modules/talent/commonModels/drop_down_model.dart';
import 'package:talent_app/modules/talent/createCard/models/talent_create_card_model.dart';
import 'package:talent_app/modules/talent/createCard/provider/talent_create_card_step_two_provider.dart';
import 'package:talent_app/modules/talent/createCard/widgets/talent_body_drop_down_widget.dart';
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
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/custom_drop_down_widget.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

class TalentCreateCardStepTwoScreen extends StatefulWidget {
  final TalentCreateCardModel talentCreateCardModel;

  const TalentCreateCardStepTwoScreen(
      {super.key, required this.talentCreateCardModel});

  @override
  State<TalentCreateCardStepTwoScreen> createState() =>
      _TalentCreateCardStepTwoScreenState();
}

class _TalentCreateCardStepTwoScreenState
    extends State<TalentCreateCardStepTwoScreen> {
  TalentCreateCardModel? talentCreateCardModel;

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    talentCreateCardModel = widget.talentCreateCardModel;

    Provider.of<TalentCreateCardStepTwoProvider>(context, listen: false).getTalentData(
        onFailure: (msg) {
          Navigator.pop(context);
          Common.showErrorToast(context, msg);
        });
  }

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
                  child: GestureDetector(
                    onTap: () {
                      CommonMethod.hideKeyBoard(context);
                    },
                    child: Consumer<TalentCreateCardStepTwoProvider>(
                        builder: (context, talentCreateCardStepTwoProvider, child) {
                          return

                            talentCreateCardStepTwoProvider.isLoading == true
                                ? const CustomCircularLoaderWidget():Column(children: [
                              Container(
                                //  margin: EdgeInsets.only(left: 24.w, top: 12.h),
                                margin: EdgeInsets.only(left: 24.w, top: 22.h),

                                child: AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  centerTitle: true,
                                  iconTheme: const IconThemeData(color: Colors.white),
                                  title: Text(
                                    context.loc.headerCreateCard,
                                    style: StyleUtility.headerTextStyle.copyWith(
                                        fontSize: TextSizeUtility.textSize18.sp),
                                  ),
                                ),
                              ),
                              Expanded(
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
                                              fontSize: TextSizeUtility.textSize16.sp),
                                        ),
                                        SizedBox(
                                          height: 25.h,
                                        ),


                                        Text(
                                          context.loc.titleWeightRange,
                                          style: StyleUtility
                                              .quicksandSemiBold5457BETextStyle
                                              .copyWith(
                                              fontSize: TextSizeUtility.textSize16.sp),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        SimpleTextField(
                                            controller: weightController,
                                            hintText: context.loc.hintMin,
                                            textInputType: TextInputType.number
                                        ),
                                        SizedBox(
                                          height: 22.h,
                                        ),
                                        Text(
                                          context.loc.titleHeightRange,
                                          style: StyleUtility
                                              .quicksandSemiBold5457BETextStyle
                                              .copyWith(
                                              fontSize: TextSizeUtility.textSize16.sp),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        SimpleTextField(
                                            controller: heightController,
                                            hintText: context.loc.hintMin,
                                            textInputType: TextInputType.number
                                        ),

                                        SizedBox(
                                          height: 22.h,
                                        ),


                                        TalentBodyDropDownWidget(
                                            ovValueChange: (item) {
                                              talentCreateCardStepTwoProvider.selectEyeColor = item;
                                              talentCreateCardStepTwoProvider.updateUi();
                                            },
                                            dropDownList: talentCreateCardStepTwoProvider.eyeColorModel,
                                            selectItem: talentCreateCardStepTwoProvider.selectEyeColor,
                                            hintText: context.loc.hintEyeColor
                                          // hintText: context.loc.hint
                                        ),


                                        SizedBox(
                                          height: 22.h,
                                        ),
                                        TalentBodyDropDownWidget(
                                            ovValueChange: (item) {

                                              talentCreateCardStepTwoProvider.selectHairColor = item;
                                              talentCreateCardStepTwoProvider.updateUi();


                                            },
                                            dropDownList: talentCreateCardStepTwoProvider.hairColorModel,
                                            selectItem: talentCreateCardStepTwoProvider.selectHairColor,
                                            hintText: context.loc.hintHairColor),
                                        SizedBox(
                                          height: 22.h,
                                        ),
                                        // CustomDropDownWidget(
                                        //     ovValueChange: (item) {
                                        //       selectHeight = item;
                                        //       setState(() {});
                                        //     },
                                        //     dropDownList: heightList,
                                        //     selectItem: selectHeight,
                                        //     hintText: context.loc.hintHeight),
                                        // SizedBox(
                                        //   height: 22.h,
                                        // ),
                                        // CustomDropDownWidget(
                                        //     ovValueChange: (item) {
                                        //       selectWeight = item;
                                        //       setState(() {});
                                        //     },
                                        //     dropDownList: weightList,
                                        //     selectItem: selectWeight,
                                        //     hintText: context.loc.hintWeight),
                                        // SizedBox(
                                        //   height: 22.h,
                                        // ),
                                        TalentBodyDropDownWidget(
                                            ovValueChange: (item) {
                                              talentCreateCardStepTwoProvider.selectShirtSize = item;
                                              talentCreateCardStepTwoProvider.updateUi();
                                            },
                                            dropDownList: talentCreateCardStepTwoProvider.shirtSizeModel,
                                            selectItem: talentCreateCardStepTwoProvider.selectShirtSize,
                                            hintText: context.loc.hintShirtSize),
                                        SizedBox(
                                          height: 22.h,
                                        ),
                                        TalentBodyDropDownWidget(
                                            ovValueChange: (item) {

                                              talentCreateCardStepTwoProvider.selectPainsSize = item;
                                              talentCreateCardStepTwoProvider.updateUi();

                                            },
                                            dropDownList: talentCreateCardStepTwoProvider.painsSizeModel,
                                            selectItem: talentCreateCardStepTwoProvider.selectPainsSize,
                                            hintText: context.loc.hintPantsSize),
                                        SizedBox(
                                          height: 22.h,
                                        ),
                                        TalentBodyDropDownWidget(
                                            ovValueChange: (item) {
                                              talentCreateCardStepTwoProvider.selectShoeSize = item;
                                              talentCreateCardStepTwoProvider.updateUi();
                                            },
                                            dropDownList: talentCreateCardStepTwoProvider.shoeSizeModel,
                                            selectItem: talentCreateCardStepTwoProvider.selectShoeSize,
                                            hintText: context.loc.hintShoeSize),

                                        SizedBox(
                                          height: 22.h,
                                        ),



                                        SizedBox(
                                          height: 40.h,
                                        ),
                                      ])),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 20.w,
                                  right: 20.w,
                                  top: 20.h,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: CustomOutlineButton(
                                            buttonText: context.loc.buttonBack,
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            buttonColor: ColorUtility.color5457BE)),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: CustomButton(
                                        buttonText: context.loc.buttonNext,
                                        buttonType: ButtonType.blue,
                                        onTap: () async {

                                          talentCreateCardStepTwoProvider.setTalentBodyValue();

                                          talentCreateCardModel?.weight = weightController.text;
                                          talentCreateCardModel?.height = heightController.text;
                                          talentCreateCardModel?.profileTalentdata = talentCreateCardStepTwoProvider.talentBodyData;
                                          AppLogger.logD(
                                              talentCreateCardModel?.toJson());
                                          Navigator.pushNamed(
                                              context, RouteName.addYourPhotoScreen,
                                              arguments: {
                                                "talentCreateCardModel": talentCreateCardModel
                                              });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 35.h,
                              ),
                            ]);
                        }
                    ),
                  ))),
        ],
      ),
    );
  }



}


