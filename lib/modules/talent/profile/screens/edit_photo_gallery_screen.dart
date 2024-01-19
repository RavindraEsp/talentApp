import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/profile/providers/edit_photo_gallery_screen_provider.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/strings_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';

class EditPhotoGalleryScreen extends StatefulWidget {
  final int id;

  const EditPhotoGalleryScreen({super.key, required this.id});

  @override
  State<EditPhotoGalleryScreen> createState() => _EditPhotoGalleryScreenState();
}

class _EditPhotoGalleryScreenState extends State<EditPhotoGalleryScreen> {
  List<XFile> selectedImages = []; // List of selected image
  final picker = ImagePicker();

  Future getImagesFromGallery(EditPhotoGalleryScreenProvider editPhotoGalleryScreenProvider) async {
    final pickedFile = await picker.pickMultiImage();
    if (pickedFile.isNotEmpty) {
      selectedImages.addAll(pickedFile);
      editPhotoGalleryScreenProvider.updateUi();
    } else {}
  }

  Future getImageFromCamera(EditPhotoGalleryScreenProvider editPhotoGalleryScreenProvider) async {
    XFile? pickedFile;
    pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      selectedImages.add(pickedFile);
      editPhotoGalleryScreenProvider.updateUi();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: Consumer<EditPhotoGalleryScreenProvider>(
          builder: (context, editPhotoGalleryScreenProvider, child) {
        return Column(children: [
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
          Text(
            context.loc.titleUploadPhoto,
            style: StyleUtility.quicksandSemiBold5457BETextStyle
                .copyWith(fontSize: TextSizeUtility.textSize16.sp),
          ),
          SizedBox(
            height: 10.h,
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
                    ? InkWell(
                        onTap: () {
                          showBottomSheetForSelectImage(editPhotoGalleryScreenProvider);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
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
                      )
                    : Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.file(
                              File(selectedImages[index - 1].path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              selectedImages.removeAt(index - 1);
                              editPhotoGalleryScreenProvider.updateUi();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 2.w, left: 2.w),
                              child: SizedBox(
                                width: 32.w,
                                height: 32.w,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.5)),
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
            child: CustomButtonTopToBottomColor(
              width: double.infinity,
              buttonText: context.loc.buttonUpdate,
              onTap: () {
                AppLogger.logD("Image length ${selectedImages.length}");
                if (selectedImages.isEmpty) {
                  Common.showErrorSnackBar(context, StringsUtility.uploadImage);
                } else {
                  Common.showLoadingDialog(context);
                  editPhotoGalleryScreenProvider.updateTalentProfileData(
                      onSuccess: (message) {
                        Navigator.pop(context);
                        Navigator.pop(context, true);
                        Common.showSuccessToast(context, message);
                      },
                      onFailure: (message) {
                        if(Navigator.canPop(context)){
                          Navigator.pop(context);
                        }
                        Common.showErrorToast(context, message);
                      },
                      id: widget.id,
                      selectedImages: selectedImages);
                }
              },
            ),
          ),
          SizedBox(
            height: 35.h,
          )
        ]);
      })),
    );
  }

  showBottomSheetForSelectImage(EditPhotoGalleryScreenProvider editPhotoGalleryScreenProvider) {
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
                  topRight: Radius.circular(20.r),
                  topLeft: Radius.circular(20.r)),
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
                    getImageFromCamera(editPhotoGalleryScreenProvider);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, top: 10.w, bottom: 10.w),
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
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize18.sp),
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
                    getImagesFromGallery(editPhotoGalleryScreenProvider);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, top: 10.w, bottom: 10.w),
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
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize18.sp),
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
