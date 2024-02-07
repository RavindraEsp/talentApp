import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/talent/profile/providers/edit_talent_body_screen_provider.dart';
import 'package:talent_app/modules/talent/profile/widgets/talent_edit_body_dropdown_widget.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';

class EditTalentBodyScreen extends StatefulWidget {
  final int id;

  const EditTalentBodyScreen({super.key, required this.id});

  @override
  State<EditTalentBodyScreen> createState() => _EditTalentBodyScreenState();
}

class _EditTalentBodyScreenState extends State<EditTalentBodyScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<EditTalentBodyScreenProvider>(context, listen: false)
        .fetchTalentBody(onSuccess: (talentBodyResponseModel) {
    }, onFailure: (message) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
              child: Column(children: [
            Container(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Image.asset(
                    ImageUtility.crossIcon,
                    height: 20.w,
                    width: 20.w,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(child: Consumer<EditTalentBodyScreenProvider>(
                builder: (context, editTalentBodyScreenProvider, child) {
              return editTalentBodyScreenProvider.isLoading == true
                  ? const Center(
                      child: CustomCircularLoaderWidget(),
                    )
                  : ListView(
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


                        ListView.builder(
                            itemCount: editTalentBodyScreenProvider.talentBodyEditResponseModel.data?.bodyDetail?.length ?? 0,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context,index){

                              return Column(
                                children: [

                                  SizedBox(
                                    height: 22.h,
                                  ),

                                  // TalentBodyDropDownWidget(
                                  //     ovValueChange: (item) {
                                  //       talentCreateCardStepTwoProvider.talentDataResponseModel?.data?.bodyDetail?[index].selectDropDown = item;
                                  //       talentCreateCardStepTwoProvider.updateUi();
                                  //     },
                                  //     dropDownList: talentCreateCardStepTwoProvider.talentDataResponseModel?.data?.bodyDetail?[index].bodyData,
                                  //     selectItem: talentCreateCardStepTwoProvider.talentDataResponseModel?.data?.bodyDetail?[index].selectDropDown,
                                  //     hintText: talentCreateCardStepTwoProvider.talentDataResponseModel?.data?.bodyDetail?[index].name ?? ""
                                  //   // hintText: context.loc.hint
                                  // ),

                                  TalentEditBodyDropDownWidget(
                                      ovValueChange: (item) {
                                        editTalentBodyScreenProvider.talentBodyEditResponseModel.data?.bodyDetail?[index].selectDropDown = item;
                                        editTalentBodyScreenProvider.updateUi();
                                      },
                                      dropDownList: editTalentBodyScreenProvider.talentBodyEditResponseModel.data?.bodyDetail?[index].bodyData,
                                      selectItem:editTalentBodyScreenProvider.talentBodyEditResponseModel.data?.bodyDetail?[index].selectDropDown,
                                      hintText: editTalentBodyScreenProvider.talentBodyEditResponseModel.data?.bodyDetail?[index].name ?? ""),



                                ],
                              );


                            }),




                        //
                        //
                        //
                        // TalentEditBodyDropDownWidget(
                        //       ovValueChange: (item) {
                        //         editTalentBodyScreenProvider.selectEyeColor =
                        //             item;
                        //         editTalentBodyScreenProvider.updateUi();
                        //       },
                        //       dropDownList: editTalentBodyScreenProvider
                        //           .talentBodyResponseModel.data?.eyeColorArr,
                        //       selectItem:
                        //           editTalentBodyScreenProvider.selectEyeColor,
                        //       hintText: context.loc.hintEyeColor),
                        //
                        //   SizedBox(
                        //     height: 22.h,
                        //   ),
                        //
                        //   TalentEditBodyDropDownWidget(
                        //       ovValueChange: (item) {
                        //         editTalentBodyScreenProvider.selectHairColor =
                        //             item;
                        //         editTalentBodyScreenProvider.updateUi();
                        //       },
                        //       dropDownList: editTalentBodyScreenProvider
                        //           .talentBodyResponseModel.data?.hairColorArr,
                        //       selectItem:
                        //           editTalentBodyScreenProvider.selectHairColor,
                        //       hintText: context.loc.hintHairColor),
                        //   SizedBox(
                        //     height: 22.h,
                        //   ),
                        //
                        //   TalentEditBodyDropDownWidget(
                        //       ovValueChange: (item) {
                        //         editTalentBodyScreenProvider.selectShirtSize =
                        //             item;
                        //         editTalentBodyScreenProvider.updateUi();
                        //       },
                        //       dropDownList: editTalentBodyScreenProvider
                        //           .talentBodyResponseModel.data?.shirtSizeArr,
                        //       selectItem:
                        //           editTalentBodyScreenProvider.selectShirtSize,
                        //       hintText: context.loc.hintShirtSize),
                        //
                        //   SizedBox(
                        //     height: 22.h,
                        //   ),
                        //   TalentEditBodyDropDownWidget(
                        //       ovValueChange: (item) {
                        //         editTalentBodyScreenProvider.selectPansSize =
                        //             item;
                        //         editTalentBodyScreenProvider.updateUi();
                        //       },
                        //       dropDownList: editTalentBodyScreenProvider
                        //           .talentBodyResponseModel.data?.pantSizeArr,
                        //       selectItem:
                        //           editTalentBodyScreenProvider.selectPansSize,
                        //       hintText: context.loc.hintPantsSize),
                        //   SizedBox(
                        //     height: 22.h,
                        //   ),
                        //   TalentEditBodyDropDownWidget(
                        //       ovValueChange: (item) {
                        //         editTalentBodyScreenProvider.selectShoeSize =
                        //             item;
                        //         editTalentBodyScreenProvider.updateUi();
                        //       },
                        //       dropDownList: editTalentBodyScreenProvider
                        //           .talentBodyResponseModel.data?.shoeSizeArr,
                        //       selectItem:
                        //           editTalentBodyScreenProvider.selectShoeSize,
                        //       hintText: context.loc.hintShoeSize),
                          SizedBox(
                            height: 40.h,
                          ),
                          CustomButtonTopToBottomColor(
                            buttonText: context.loc.buttonUpdate,
                            buttonType: ButtonType.blue,
                            onTap: () async {
                              editTalentBodyScreenProvider
                                  .setTalentBodyArrayData();

                              Common.showLoadingDialog(context);
                              editTalentBodyScreenProvider
                                  .updateTalentProfileData(
                                id: widget.id,
                                onSuccess: (message) {
                                  Navigator.pop(context);
                                  Navigator.pop(context, true);
                                  Common.showSuccessToast(context, message);
                                },
                                onFailure: (message) {
                                  if (Navigator.canPop(context)) {
                                    Navigator.pop(context);
                                  }
                                  Common.showErrorSnackBar(context, message);
                                },
                              );
                              //  editTalentBodyScreenProvider.u
                            },
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                        ]);
            })),
          ])),
        ],
      ),
    );
  }
}
