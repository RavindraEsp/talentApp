import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/models/audition_property_model.dart';
import 'package:talent_app/modules/casting/createAudition/widgets/yes_no_checkbox.dart';
import 'package:talent_app/modules/talent/commonModels/drop_down_model.dart';
import 'package:talent_app/modules/talent/createCard/models/talent_create_card_model.dart';
import 'package:talent_app/modules/talent/createCard/provider/add_info_provider.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/shared_preference.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/congratulation_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
import 'package:talent_app/widgets/checkBox/category_select_widget.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/custom_drop_down_widget.dart';
import 'package:talent_app/widgets/textField/simple_text_field.dart';

class AddInfoScreen extends StatefulWidget {
  final TalentCreateCardModel talentCreateCardModel;
  final List<XFile> selectedImages;

  const AddInfoScreen(
      {super.key,
      required this.talentCreateCardModel,
      required this.selectedImages});

  @override
  State<AddInfoScreen> createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  List<AuditionPropertyModel>? categoryModel;

  bool? anyWorkExprienceExperience;
  bool? participateRealityShow;

  TextEditingController aboutYouController = TextEditingController();
  TextEditingController instagramLinkController = TextEditingController();
  TextEditingController facebookLinkController = TextEditingController();
  TextEditingController tikTokLinkController = TextEditingController();

  TextEditingController youtubeLinkController = TextEditingController();
  TextEditingController representedByController = TextEditingController();

  TalentCreateCardModel? talentCreateCardModel;

  List<DropDownModel> educationCourseList = [
    DropDownModel("First", "1"),
    DropDownModel("Second", "2")
  ];

  DropDownModel? selectCourse;

  @override
  void initState() {
    super.initState();

    categoryModel = [
      AuditionPropertyModel("Modeling", false),
      AuditionPropertyModel("Kid Artist", false),
      AuditionPropertyModel("Acting", false),
      AuditionPropertyModel("Network Star", false),
      AuditionPropertyModel("Singing", false),
      AuditionPropertyModel("Other Artist", false)
    ];

    talentCreateCardModel = widget.talentCreateCardModel;

    Provider.of<AddInfoProvider>(context, listen: false).getTalentData(
        onFailure: (msg) {
      Navigator.pop(context);
      Common.showErrorToast(context, msg);
    });

    AppLogger.logD("Images ${widget.selectedImages}");
    AppLogger.logD("Model ${widget.talentCreateCardModel.toJson()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
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
                  child: Consumer<AddInfoProvider>(
                      builder: (context, addInfoProvider, child) {
                    return addInfoProvider.isLoading == true
                        ? const CustomCircularLoaderWidget()
                        : Column(children: [
                            Container(
                              //  margin: EdgeInsets.only(left: 24.w, top: 12.h),
                              margin: EdgeInsets.only(left: 24.w, top: 22.h),
                              child: AppBar(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                centerTitle: true,
                                iconTheme:
                                    const IconThemeData(color: Colors.white),
                                title: Text(
                                  context.loc.headerAddInfo,
                                  style: StyleUtility.headerTextStyle.copyWith(
                                      fontSize: TextSizeUtility.textSize18.sp),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 25.h),
                                          Text(
                                            context.loc
                                                .titleYouCanChooseMoreThenOneCategory,
                                            style: StyleUtility
                                                .quicksandSemiBold5457BETextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize16.sp),
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),

                                          Wrap(
                                            children: [
                                              for (var item in addInfoProvider
                                                  .lookingForModel!)
                                                // LookingForWidget(
                                                //     onTap: () {
                                                //       item.isSelect = !item.isSelect;
                                                //       createAuditionProvider.updateUi();
                                                //     },
                                                //     item: item),

                                                CategorySelectWidget(
                                                    title: item.name ?? "",
                                                    status:
                                                        item.isSelect == true,
                                                    onTap: () {
                                                      item.isSelect =
                                                          !item.isSelect;
                                                      addInfoProvider
                                                          .updateUi();
                                                    }),
                                            ],
                                          ),

                                          // Row(
                                          //   children: [
                                          //     Expanded(
                                          //       child: CategorySelectWidget(
                                          //           title: categoryModel?[0]
                                          //                   .title ??
                                          //               "",
                                          //           status: categoryModel?[0]
                                          //                   .isSelect ==
                                          //               true,
                                          //           onTap: () {
                                          //             categoryModel?[0]
                                          //                     .isSelect =
                                          //                 !categoryModel![0]
                                          //                     .isSelect;
                                          //             setState(() {});
                                          //           }),
                                          //     ),
                                          //     Expanded(
                                          //       child: CategorySelectWidget(
                                          //           title: categoryModel?[1]
                                          //                   .title ??
                                          //               "",
                                          //           status: categoryModel?[1]
                                          //                   .isSelect ==
                                          //               true,
                                          //           onTap: () {
                                          //             categoryModel?[1]
                                          //                     .isSelect =
                                          //                 !categoryModel![1]
                                          //                     .isSelect;
                                          //             setState(() {});
                                          //           }),
                                          //     ),
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //   height: 20.h,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Expanded(
                                          //       child: CategorySelectWidget(
                                          //           title: categoryModel?[2]
                                          //                   .title ??
                                          //               "",
                                          //           status: categoryModel?[2]
                                          //                   .isSelect ==
                                          //               true,
                                          //           onTap: () {
                                          //             categoryModel?[2]
                                          //                     .isSelect =
                                          //                 !categoryModel![2]
                                          //                     .isSelect;
                                          //             setState(() {});
                                          //           }),
                                          //     ),
                                          //     Expanded(
                                          //       child: CategorySelectWidget(
                                          //           title: categoryModel?[3]
                                          //                   .title ??
                                          //               "",
                                          //           status: categoryModel?[3]
                                          //                   .isSelect ==
                                          //               true,
                                          //           onTap: () {
                                          //             categoryModel?[3]
                                          //                     .isSelect =
                                          //                 !categoryModel![3]
                                          //                     .isSelect;
                                          //             setState(() {});
                                          //           }),
                                          //     ),
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //   height: 20.h,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     Expanded(
                                          //       child: CategorySelectWidget(
                                          //           title: categoryModel?[4]
                                          //                   .title ??
                                          //               "",
                                          //           status: categoryModel?[4]
                                          //                   .isSelect ==
                                          //               true,
                                          //           onTap: () {
                                          //             categoryModel?[4]
                                          //                     .isSelect =
                                          //                 !categoryModel![4]
                                          //                     .isSelect;
                                          //             setState(() {});
                                          //           }),
                                          //     ),
                                          //     Expanded(
                                          //       child: CategorySelectWidget(
                                          //           title: categoryModel?[5]
                                          //                   .title ??
                                          //               "",
                                          //           status: categoryModel?[5]
                                          //                   .isSelect ==
                                          //               true,
                                          //           onTap: () {
                                          //             categoryModel?[5]
                                          //                     .isSelect =
                                          //                 !categoryModel![5]
                                          //                     .isSelect;
                                          //             setState(() {});
                                          //           }),
                                          //     ),
                                          //   ],
                                          // ),
                                          SizedBox(
                                            height: 36.h,
                                          ),
                                          CustomDropDownWidget(
                                              ovValueChange: (item) {
                                                selectCourse = item;
                                                setState(() {});
                                              },
                                              dropDownList: educationCourseList,
                                              selectItem: selectCourse,
                                              hintText: context
                                                  .loc.hintEducationAndCourses),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          SimpleTextField(
                                            controller: representedByController,
                                            hintText:
                                                context.loc.hintRepresentedBy,
                                          ),
                                          SizedBox(
                                            height: 32.h,
                                          ),
                                          Text(
                                            context.loc.titleAnyWorkExperience,
                                            style: StyleUtility
                                                .quicksandSemiBold5457BETextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize16.sp),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              YesNoCheckBoxWidget(
                                                  title:
                                                      context.loc.checkBoxYes,
                                                  status: anyWorkExprienceExperience ==
                                                      true,
                                                  onTap: () {
                                                    anyWorkExprienceExperience = true;
                                                    setState(() {});
                                                  }),
                                              SizedBox(
                                                width: 38.h,
                                              ),
                                              YesNoCheckBoxWidget(
                                                  title: context.loc.checkBoxNo,
                                                  status: anyWorkExprienceExperience ==
                                                      false,
                                                  onTap: () {
                                                    anyWorkExprienceExperience = false;
                                                    setState(() {});
                                                  }),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 27.h,
                                          ),
                                          Text(
                                            context.loc
                                                .titleDidYouParticipatedRealityShow,
                                            style: StyleUtility
                                                .quicksandSemiBold5457BETextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize16.sp),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              YesNoCheckBoxWidget(
                                                  title:
                                                      context.loc.checkBoxYes,
                                                  status:
                                                      participateRealityShow ==
                                                          true,
                                                  onTap: () {
                                                    participateRealityShow =
                                                        true;
                                                    setState(() {});
                                                  }),
                                              SizedBox(
                                                width: 38.h,
                                              ),
                                              YesNoCheckBoxWidget(
                                                  title: context.loc.checkBoxNo,
                                                  status:
                                                      participateRealityShow ==
                                                          false,
                                                  onTap: () {
                                                    participateRealityShow =
                                                        false;
                                                    setState(() {});
                                                  }),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 27.h,
                                          ),
                                          Text(
                                            context.loc.titleTellUsAboutYou,
                                            style: StyleUtility
                                                .quicksandBold5457BETextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize16.sp),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          SimpleTextField(
                                            controller: aboutYouController,
                                            hintText: context.loc
                                                .hintWriteAFewWordsAboutYourself,
                                            maxLine: 4,
                                          ),
                                          SizedBox(
                                            height: 27.h,
                                          ),
                                          Text(
                                            context.loc
                                                .titleAddYourSocialMediaLinks,
                                            style: StyleUtility
                                                .quicksandBold5457BETextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize16.sp),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          SimpleTextField(
                                            controller: instagramLinkController,
                                            hintText: context.loc
                                                .hintAddInstagramProfileLink,
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          SimpleTextField(
                                            controller: facebookLinkController,
                                            hintText: context
                                                .loc.hintAddFacebookProfileLink,
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          SimpleTextField(
                                            controller: tikTokLinkController,
                                            hintText: context
                                                .loc.hintAddTikTokProfileLink,
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          SimpleTextField(
                                            controller: youtubeLinkController,
                                            hintText: context
                                                .loc.hintYouTubeProfileLink,
                                          ),
                                          SizedBox(
                                            height: 35.h,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: CustomOutlineButton(
                                                      buttonText: context
                                                          .loc.buttonBack,
                                                      onTap: () {},
                                                      buttonColor: ColorUtility
                                                          .color5457BE)),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Expanded(
                                                child: CustomButton(
                                                  buttonText:
                                                      context.loc.buttonNext,
                                                  onTap: () {
                                                    addInfoProvider.setCategoryValue();


                                                    talentCreateCardModel?.careerModel = addInfoProvider.selectedLookingForIds;
                                                    talentCreateCardModel?.instalink = instagramLinkController.text;
                                                    talentCreateCardModel?.about = aboutYouController.text;
                                                    talentCreateCardModel?.facebooklink = facebookLinkController.text;
                                                    talentCreateCardModel?.tiktoklink = tikTokLinkController.text;
                                                    talentCreateCardModel?.youtubelink = youtubeLinkController.text;
                                                    talentCreateCardModel?.experience = anyWorkExprienceExperience == true ? "1" :"0";
                                                    talentCreateCardModel?.participated = participateRealityShow == true ? "1" :"0";

                                                    AppLogger.logD("TalentCreateCardModel ${talentCreateCardModel?.toJson()}");



                                                    addInfoProvider.createTalentCard(onSuccess: (msg){},
                                                        onFailure: (message){
                                                      Common.showErrorSnackBar(context, message);

                                                        },
                                                        talentCreateCardModel: talentCreateCardModel,
                                                        selectedImages: widget.selectedImages);
                                                    // showCongratulationDialog(
                                                    //     context: context,
                                                    //     onButtonTap: () {
                                                    //
                                                    //       Navigator
                                                    //           .pushNamedAndRemoveUntil(
                                                    //               context,
                                                    //               RouteName
                                                    //                   .talentBottomBarScreen,
                                                    //               arguments: {
                                                    //                 "selectIndex":
                                                    //                     0
                                                    //               },
                                                    //               (route) =>
                                                    //                   false);
                                                    //     });
                                                  },
                                                  buttonType: ButtonType.blue,
                                                ),
                                              )
                                            ],
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
                          ]);
                  }))),
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
