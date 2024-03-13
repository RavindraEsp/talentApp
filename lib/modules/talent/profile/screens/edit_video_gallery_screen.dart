import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/profile/providers/edit_video_gallery_screen_provider.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/strings_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';

class EditVideoGalleryScreen extends StatefulWidget {
  final int id;
  const EditVideoGalleryScreen({super.key, required this.id});

  @override
  State<EditVideoGalleryScreen> createState() => _EditVideoGalleryScreenState();
}

class _EditVideoGalleryScreenState extends State<EditVideoGalleryScreen> {
  List<XFile> selectedVideos = []; // List of selected Videos
  final picker = ImagePicker();

  Future getVideoFromGallery() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedVideos.add(pickedFile);
      setState(() {});
    }
  }

  Future getVideoFromCamera() async {
    XFile? pickedFile;
    pickedFile = await picker.pickVideo(source: ImageSource.camera);

    if (pickedFile != null) {
      selectedVideos.add(pickedFile);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: Consumer<EditVideoGalleryScreenProvider>(
          builder: (context, editVideoGalleryScreenProvider, child) {
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
            context.loc.titleUploadVideo,
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
              itemCount: selectedVideos.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index == 0
                    ? InkWell(
                        onTap: () {
                          showBottomSheetForSelectVideo();
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
                    : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorUtility.color6A3699,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                selectedVideos.removeAt(index - 1);
                                editVideoGalleryScreenProvider.updateUi();
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
                            ),
                            Center(
                              child: SizedBox(
                                height: 39.w,
                                width: 39.w,
                                child: Image.asset(
                                  ImageUtility.playOutLineIcon,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                  AppLogger.logD("Audio length ${selectedVideos.length}");
                  if (selectedVideos.isEmpty) {
                    Common.showErrorSnackBar(context, context.loc.pleaseSelectVideo);
                  }else{

                    Common.showLoadingDialog(context);
                    editVideoGalleryScreenProvider.updateTalentProfileData(
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
                        selectedVideos: selectedVideos);

                  }
                },
              )),
          SizedBox(
            height: 35.h,
          )
        ]);
      })),
    );
  }

  showBottomSheetForSelectVideo() {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Text(
                context.loc.titleUploadVideo,
                style: StyleUtility.kantumruyProMedium5457BETextStyle
                    .copyWith(fontSize: TextSizeUtility.textSize22.sp),
              ),
              SizedBox(
                height: 30.w,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  getVideoFromCamera();
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
                        context.loc.bottomTakeVideo,
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
                  getVideoFromGallery();
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
        );
      },
    );
  }
}
