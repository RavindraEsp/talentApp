import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/talent/profile/model/talent_body_response_model.dart';
import 'package:talent_app/modules/talent/profile/providers/edit_talent_body_screen_provider.dart';
import 'package:talent_app/utilities/color_utility.dart';
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
  // EyeColorArr? selectEyeColor;
  // EyeColorArr? selectHairColor;
  //
  // EyeColorArr? selectShirtSize;
  // EyeColorArr? selectPansSize;
  // EyeColorArr? selectShoeSize;

  // DropDownModel? selectHeight;
  // DropDownModel? selectWeight;



  // List<DropDownModel> eyeColorList = [
  //   DropDownModel("Red", "1"),
  //   DropDownModel("Green", "1")
  // ];
  // List<DropDownModel> hairColorList = [
  //   DropDownModel("White", "1"),
  //   DropDownModel("Black", "1")
  // ];
  // List<DropDownModel> heightList = [
  //   DropDownModel("5 Meter", "5"),
  //   DropDownModel("4 Meter", "4")
  // ];
  // List<DropDownModel> weightList = [
  //   DropDownModel("50 Kg", "50"),
  //   DropDownModel("40 Kg", "40")
  // ];
  // List<DropDownModel> shirtSizeList = [
  //   DropDownModel("L", "1"),
  //   DropDownModel("XL", "2")
  // ];
  // List<DropDownModel> pansSizeList = [
  //   DropDownModel("Pants 1", "1"),
  //   DropDownModel("Pants 2", "2")
  // ];
  // List<DropDownModel> shoeSizeList = [
  //   DropDownModel("7", "7"),
  //   DropDownModel("8", "8")
  // ];

  @override
  void initState() {
    super.initState();
    Provider.of<EditTalentBodyScreenProvider>(context, listen: false)
        .fetchTalentBody(
            onSuccess: (talentBodyResponseModel) {
             // setAutofillValue(talentBodyResponseModel);
            },
            onFailure: (message) {
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


                        TalentEditBodyDropDownWidget(
                            ovValueChange: (item) {
                             editTalentBodyScreenProvider.selectEyeColor = item;
                              setState(() {});
                            },
                            dropDownList: editTalentBodyScreenProvider.talentBodyResponseModel.data?.eyeColorArr,
                            selectItem: editTalentBodyScreenProvider.selectEyeColor,
                            hintText: context.loc.hintEyeColor),




                        SizedBox(
                            height: 22.h,
                          ),







                        TalentEditBodyDropDownWidget(
                              ovValueChange: (item) {
                                editTalentBodyScreenProvider.selectHairColor = item;
                                setState(() {});
                              },
                              dropDownList: editTalentBodyScreenProvider.talentBodyResponseModel.data?.hairColorArr,
                              selectItem: editTalentBodyScreenProvider.selectHairColor,
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


                          // CustomDropDownWidget(
                          //     ovValueChange: (item) {
                          //       selectShirtSize = item;
                          //       setState(() {});
                          //     },
                          //     dropDownList: shirtSizeList,
                          //     selectItem: selectShirtSize,
                          //     hintText: context.loc.hintShirtSize),
                          //

                        TalentEditBodyDropDownWidget(
                            ovValueChange: (item) {
                              editTalentBodyScreenProvider.selectShirtSize = item;
                              setState(() {});
                            },
                            dropDownList: editTalentBodyScreenProvider.talentBodyResponseModel.data?.shirtSizeArr,
                            selectItem: editTalentBodyScreenProvider.selectShirtSize,
                            hintText: context.loc.hintShirtSize),





                        SizedBox(
                            height: 22.h,
                          ),
                        TalentEditBodyDropDownWidget(
                              ovValueChange: (item) {
                                editTalentBodyScreenProvider.selectPansSize = item;
                                setState(() {});
                              },
                              dropDownList: editTalentBodyScreenProvider.talentBodyResponseModel.data?.pantSizeArr,
                              selectItem: editTalentBodyScreenProvider.selectPansSize,
                              hintText: context.loc.hintPantsSize),
                          SizedBox(
                            height: 22.h,
                          ),
                        TalentEditBodyDropDownWidget(
                              ovValueChange: (item) {
                                editTalentBodyScreenProvider.selectShoeSize = item;
                                setState(() {});
                              },
                              dropDownList: editTalentBodyScreenProvider.talentBodyResponseModel.data?.shoeSizeArr,
                              selectItem: editTalentBodyScreenProvider.selectShoeSize,
                              hintText: context.loc.hintShoeSize),
                          SizedBox(
                            height: 40.h,
                          ),
                          CustomButtonTopToBottomColor(
                            buttonText: context.loc.buttonUpdate,
                            buttonType: ButtonType.blue,
                            onTap: () async {

                              editTalentBodyScreenProvider.setTalentBodyArrayData();

                              Common.showLoadingDialog(context);
                              editTalentBodyScreenProvider.updateTalentProfileData(
                                id: widget.id,
                                  onSuccess: (message){

                                    Navigator.pop(context);
                                    Navigator.pop(context,true);
                                    Common.showSuccessToast(context, message);

                              }, onFailure: (message){
                                if(Navigator.canPop(context)){
                                  Navigator.pop(context);
                                }
                                Common.showErrorSnackBar(context, message);
                              }, );
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





class TalentEditBodyDropDownWidget extends StatelessWidget {
  const TalentEditBodyDropDownWidget({
    super.key,
    required this.ovValueChange,
    required this.dropDownList,
    required this.selectItem,
    required this.hintText,
  });

  final ValueChanged<EyeColorArr> ovValueChange;

  final List<EyeColorArr>? dropDownList;
  final EyeColorArr? selectItem;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: ColorUtility.colorD6D6D8,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<EyeColorArr>(
          value: selectItem,
          items: dropDownList?.map((EyeColorArr items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items.option ?? "",
                style: StyleUtility.inputTextStyle
                    .copyWith(fontSize: TextSizeUtility.textSize15.sp),
              ),
            );
          }).toList(),
          isExpanded: true,
          icon: SizedBox(
            height: 10.h,
            child: Image.asset(ImageUtility.dropDownArrowIcon),
          ),
          underline: Container(
            color: ColorUtility.colorD6D6D8,
          ),
          hint: Text(
            hintText,
            style: StyleUtility.hintTextStyle
                .copyWith(fontSize: TextSizeUtility.textSize15.sp),
          ),
          onChanged: (EyeColorArr? value) {
            // setState(() {
            //   selectHeight = value!;
            //   print(value);
            // });

            ovValueChange.call(value!);
          },
        ),
      ),
    );
  }
}
