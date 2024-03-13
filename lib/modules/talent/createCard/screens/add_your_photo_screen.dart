import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/createCard/models/talent_create_card_model.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/strings_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';

class AddYourPhotoScreen extends StatefulWidget {
  final TalentCreateCardModel talentCreateCardModel;
  const AddYourPhotoScreen({super.key, required this.talentCreateCardModel});

  @override
  State<AddYourPhotoScreen> createState() => _AddYourPhotoScreenState();
}

class _AddYourPhotoScreenState extends State<AddYourPhotoScreen> {
  List<XFile> selectedImages = []; // List of selected image
  final picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AppLogger.logD("talentCreateCardModel ${widget.talentCreateCardModel.toJson()}");
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
                  child: Column(children: [
                    Container(
                      //  margin: EdgeInsets.only(left: 24.w, top: 12.h),
                      margin: EdgeInsets.only(left: 24.w, top: 22.h),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        centerTitle: true,
                        iconTheme: const IconThemeData(color: Colors.white),

                        title: Text(
                          context.loc.headerAddYourPhoto,
                          style: StyleUtility.headerTextStyle.copyWith(
                              fontSize: TextSizeUtility.textSize18.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      context.loc.titleUploadMultimediaFiles,
                      style: StyleUtility.quicksandSemiBold5457BETextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.only(
                            top: 25.h, bottom: 25.h, left: 20.w, right: 20.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 18.w,
                            childAspectRatio: 0.90),
                        itemCount: selectedImages.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          return index == 0
                              ? Container(
                                  child: InkWell(
                                    onTap: () {
                                      showBottomSheetForSelectImage();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        border: Border.all(
                                          color: ColorUtility.colorD6D6D8,
                                        ),
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          height: 30.w,
                                          width: 30.w,
                                          child: Image.asset(
                                            ImageUtility.addIcon,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.file(
                                        File(selectedImages[index - 1].path),
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        // height: 200,
                                        width: double.infinity,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        selectedImages.removeAt(index - 1);
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 2.w, left: 2.w),
                                        child: SizedBox(
                                          width: 32.w,
                                          height: 32.w,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.all(10.sp),
                                            child: Image.asset(
                                              ImageUtility.crossIcon,
                                              color: ColorUtility.colorWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                            onTap: () {

                              AppLogger.logD("Image le ${selectedImages.length}");
                              if(selectedImages.isEmpty){
                                Common.showErrorSnackBar(context, context.loc.pleaseSelectImage);
                              }else{
                                // Navigator.pushNamed(
                                //     context, RouteName.addYourVideoScreen);
                                Navigator.pushNamed(
                                    context, RouteName.addInfoScreen,arguments: {
                                      "talentCreateCardModel":widget.talentCreateCardModel,
                                      "selectedImages":selectedImages,
                                });
                              }

                            },
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    )
                  ]))),
        ],
      ),
    );
  }

  Future getImagesFromGallery() async {
    final pickedFile = await picker.pickMultiImage();
    if (pickedFile.isNotEmpty) {
      selectedImages.addAll(pickedFile);
      setState(() {});
    } else {}
  }

  Future getImageFromCamera() async {
    XFile? pickedFile;
    pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      selectedImages.add(pickedFile);
      setState(() {});
    }
  }

  showBottomSheetForSelectImage() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r)),
      ),
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          // height: 300.sp,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r)),
              color: Colors.white,

            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  context.loc.titleUploadPhoto,
                  style: StyleUtility.kantumruyProMedium5457BETextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize22.sp),
                ),
                SizedBox(
                  height: 30.w,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    getImageFromCamera();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 10.w, bottom: 10.w),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          ImageUtility.cameraIcon,
                          width: 28.w,
                          height: 28.w,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          context.loc.bottomSheetTakePhoto,
                          style: StyleUtility.quicksandRegularBlackTextStyle
                              .copyWith(fontSize: TextSizeUtility.textSize18.sp),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    getImagesFromGallery();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 10.w, bottom: 10.w),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          ImageUtility.cameraIcon,
                          width: 28.w,
                          height: 28.w,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          context.loc.bottomChooseFromGallery,
                          style: StyleUtility.quicksandRegularBlackTextStyle
                              .copyWith(fontSize: TextSizeUtility.textSize18.sp),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
