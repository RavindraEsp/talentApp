import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/talent/commonModels/drop_down_model.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
import 'package:talent_app/widgets/custom_drop_down_widget.dart';

class TalentCreateCardStepTwoScreen extends StatefulWidget {
  const TalentCreateCardStepTwoScreen({super.key});

  @override
  State<TalentCreateCardStepTwoScreen> createState() =>
      _TalentCreateCardStepTwoScreenState();
}

class _TalentCreateCardStepTwoScreenState
    extends State<TalentCreateCardStepTwoScreen> {
  DropDownModel? selectEyeColor;
  DropDownModel? selectHairColor;
  DropDownModel? selectHeight;
  DropDownModel? selectWeight;
  DropDownModel? selectShirtSize;
  DropDownModel? selectPansSize;
  DropDownModel? selectShoeSize;

  List<DropDownModel> eyeColorList = [
    DropDownModel("Red", "1"),
    DropDownModel("Green", "1")
  ];
  List<DropDownModel> hairColorList = [
    DropDownModel("White", "1"),
    DropDownModel("Black", "1")
  ];
  List<DropDownModel> heightList = [
    DropDownModel("5 Meter", "5"),
    DropDownModel("4 Meter", "4")
  ];
  List<DropDownModel> weightList = [
    DropDownModel("50 Kg", "50"),
    DropDownModel("40 Kg", "40")
  ];
  List<DropDownModel> shirtSizeList = [
    DropDownModel("L", "1"),
    DropDownModel("XL", "2")
  ];
  List<DropDownModel> pansSizeList = [
    DropDownModel("Pans 1", "1"),
    DropDownModel("Pans 2", "2")
  ];
  List<DropDownModel> shoeSizeList = [
    DropDownModel("7", "7"),
    DropDownModel("8", "8")
  ];

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
                        child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            context.loc.titleCreateCardDescription,
                            style: StyleUtility.quicksandSemiBold5457BETextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          CustomDropDownWidget(
                              ovValueChange: (item) {
                                selectEyeColor = item;
                                setState(() {});
                              },
                              dropDownList: eyeColorList,
                              selectItem: selectEyeColor,
                              hintText: context.loc.hintEyeColor
                              // hintText: context.loc.hint
                              ),
                          SizedBox(
                            height: 22.h,
                          ),
                          CustomDropDownWidget(
                              ovValueChange: (item) {
                                selectHairColor = item;
                                setState(() {});
                              },
                              dropDownList: hairColorList,
                              selectItem: selectHairColor,
                              hintText: context.loc.hintHairColor),
                          SizedBox(
                            height: 22.h,
                          ),
                          CustomDropDownWidget(
                              ovValueChange: (item) {
                                selectHeight = item;
                                setState(() {});
                              },
                              dropDownList: heightList,
                              selectItem: selectHeight,
                              hintText: context.loc.hintHeight),
                          SizedBox(
                            height: 22.h,
                          ),
                          CustomDropDownWidget(
                              ovValueChange: (item) {
                                selectWeight = item;
                                setState(() {});
                              },
                              dropDownList: weightList,
                              selectItem: selectWeight,
                              hintText: context.loc.hintWeight),
                          SizedBox(
                            height: 22.h,
                          ),
                          CustomDropDownWidget(
                              ovValueChange: (item) {
                                selectShirtSize = item;
                                setState(() {});
                              },
                              dropDownList: shirtSizeList,
                              selectItem: selectShirtSize,
                              hintText: context.loc.hintShirtSize),
                          SizedBox(
                            height: 22.h,
                          ),
                          CustomDropDownWidget(
                              ovValueChange: (item) {
                                selectPansSize = item;
                                setState(() {});
                              },
                              dropDownList: pansSizeList,
                              selectItem: selectPansSize,
                              hintText: context.loc.hintPansSize),
                          SizedBox(
                            height: 22.h,
                          ),
                          CustomDropDownWidget(
                              ovValueChange: (item) {
                                selectShoeSize = item;
                                setState(() {});
                              },
                              dropDownList: shoeSizeList,
                              selectItem: selectShoeSize,
                              hintText: context.loc.hintShoeSize),
                          SizedBox(
                            height: 40.h,
                          ),
                          Row(
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
                                  onTap: () async {},
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                        ])),
                  ]))),
        ],
      ),
    );
  }
}
