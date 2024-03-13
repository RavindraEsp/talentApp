
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
import 'package:talent_app/utilities/strings_utility.dart';
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

  final _formKey = GlobalKey<FormState>();

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
                                  child: Form(
                                    key: _formKey,
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
                                              hintText: context.loc.hintWeight,
                                              textInputType: TextInputType.number,
                                            validator: Validators(context).validatorWeight,
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
                                              hintText: context.loc.hintHeight,
                                              textInputType: TextInputType.number,
                                            validator: Validators(context).validatorHeight,
                                          ),


                                          ListView.builder(
                                            itemCount: talentCreateCardStepTwoProvider.talentDataResponseModel?.data?.bodyDetail?.length ?? 0,
                                              shrinkWrap: true,
                                              primary: false,
                                              itemBuilder: (context,index){

                                            return Column(
                                              children: [

                                                SizedBox(
                                                  height: 22.h,
                                                ),

                                                TalentBodyDropDownWidget(
                                                    ovValueChange: (item) {
                                                      talentCreateCardStepTwoProvider.talentDataResponseModel?.data?.bodyDetail?[index].selectDropDown = item;
                                                      talentCreateCardStepTwoProvider.updateUi();
                                                    },
                                                    dropDownList: talentCreateCardStepTwoProvider.talentDataResponseModel?.data?.bodyDetail?[index].bodyData,
                                                  selectItem: talentCreateCardStepTwoProvider.talentDataResponseModel?.data?.bodyDetail?[index].selectDropDown,
                                                   hintText: talentCreateCardStepTwoProvider.talentDataResponseModel?.data?.bodyDetail?[index].name ?? ""
                                                  // hintText: context.loc.hint
                                                ),


                                              ],
                                            );


                                          }),

                                          // SizedBox(
                                          //   height: 22.h,
                                          // ),
                                          //
                                          // TalentBodyDropDownWidget(
                                          //     ovValueChange: (item) {
                                          //       talentCreateCardStepTwoProvider.selectEyeColor = item;
                                          //       talentCreateCardStepTwoProvider.updateUi();
                                          //     },
                                          //     dropDownList: talentCreateCardStepTwoProvider.eyeColorModel,
                                          //     selectItem: talentCreateCardStepTwoProvider.selectEyeColor,
                                          //     hintText: context.loc.hintEyeColor
                                          //   // hintText: context.loc.hint
                                          // ),
                                          //
                                          // SizedBox(
                                          //   height: 22.h,
                                          // ),
                                          // TalentBodyDropDownWidget(
                                          //     ovValueChange: (item) {
                                          //
                                          //       talentCreateCardStepTwoProvider.selectHairColor = item;
                                          //       talentCreateCardStepTwoProvider.updateUi();
                                          //
                                          //
                                          //     },
                                          //     dropDownList: talentCreateCardStepTwoProvider.hairColorModel,
                                          //     selectItem: talentCreateCardStepTwoProvider.selectHairColor,
                                          //     hintText: context.loc.hintHairColor),
                                          // SizedBox(
                                          //   height: 22.h,
                                          // ),
                                          //
                                          // TalentBodyDropDownWidget(
                                          //     ovValueChange: (item) {
                                          //       talentCreateCardStepTwoProvider.selectShirtSize = item;
                                          //       talentCreateCardStepTwoProvider.updateUi();
                                          //     },
                                          //     dropDownList: talentCreateCardStepTwoProvider.shirtSizeModel,
                                          //     selectItem: talentCreateCardStepTwoProvider.selectShirtSize,
                                          //     hintText: context.loc.hintShirtSize),
                                          // SizedBox(
                                          //   height: 22.h,
                                          // ),
                                          // TalentBodyDropDownWidget(
                                          //     ovValueChange: (item) {
                                          //
                                          //       talentCreateCardStepTwoProvider.selectPainsSize = item;
                                          //       talentCreateCardStepTwoProvider.updateUi();
                                          //
                                          //     },
                                          //     dropDownList: talentCreateCardStepTwoProvider.painsSizeModel,
                                          //     selectItem: talentCreateCardStepTwoProvider.selectPainsSize,
                                          //     hintText: context.loc.hintPantsSize),
                                          // SizedBox(
                                          //   height: 22.h,
                                          // ),
                                          // TalentBodyDropDownWidget(
                                          //     ovValueChange: (item) {
                                          //       talentCreateCardStepTwoProvider.selectShoeSize = item;
                                          //       talentCreateCardStepTwoProvider.updateUi();
                                          //     },
                                          //     dropDownList: talentCreateCardStepTwoProvider.shoeSizeModel,
                                          //     selectItem: talentCreateCardStepTwoProvider.selectShoeSize,
                                          //     hintText: context.loc.hintShoeSize),

                                          SizedBox(
                                            height: 22.h,
                                          ),



                                          SizedBox(
                                            height: 40.h,
                                          ),
                                        ]),
                                  )),
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

                                          if(_formKey.currentState!.validate()){
                                            if(talentCreateCardStepTwoProvider.talentBodyData.isEmpty){

                                              Common.showErrorSnackBar(context, context.loc.pleaseFillAllDetails);

                                            }else{
                                              Navigator.pushNamed(
                                                  context, RouteName.addYourPhotoScreen,
                                                  arguments: {
                                                    "talentCreateCardModel": talentCreateCardModel
                                                  });
                                            }

                                          }

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


