import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
import 'add_your_audio_screen.dart';

class AddYourVideoScreen extends StatefulWidget {
  const AddYourVideoScreen({super.key});

  @override
  State<AddYourVideoScreen> createState() => _AddYourVideoScreenState();
}

class _AddYourVideoScreenState extends State<AddYourVideoScreen> {
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
                          context.loc.headerAddYourVideo,
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
                        itemCount: selectedVideos.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          return index == 0
                              ? Container(
                                  child: InkWell(
                                    onTap: () {
                                      showBottomSheetForSelectVideo();
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
                              Navigator.pushNamed(
                                  context, RouteName.addYourAudioScreen);
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
