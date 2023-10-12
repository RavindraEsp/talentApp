import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';

class AddYourAudioScreen extends StatefulWidget {
  const AddYourAudioScreen({super.key});

  @override
  State<AddYourAudioScreen> createState() => _AddYourAudioScreenState();
}

class _AddYourAudioScreenState extends State<AddYourAudioScreen> {
  List<FilePickerResult> selectedAudios = []; // List of selected image

  void _pickAudio() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );

    if (pickedFile != null) {
      selectedAudios.add(pickedFile);
      setState(() {});

      String? filePath = pickedFile.files.single.path;
      // Do something with the picked audio file path, such as playing or uploading it.
      AppLogger.logD("Picked audio file path: $filePath");
    } else {
      // User canceled the picker
      AppLogger.logD("User canceled the audio picking.");
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
                        title: Text(
                          context.loc.headerAddYourAudio,
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
                        itemCount: selectedAudios.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          return index == 0
                              ? Container(
                                  child: InkWell(
                                    onTap: () {
                                      //  getImagesFromGallery();
                                      _pickAudio();
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
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.w, right: 12.w),
                                        child: Container(
                                          alignment: Alignment.topRight,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: ColorUtility.color6A3699,
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: SizedBox(
                                            width: 14.w,
                                            child: Image.asset(
                                              ImageUtility.audioIcon,
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
                                      InkWell(
                                        onTap: () {
                                          selectedAudios.removeAt(index - 1);
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
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.w, right: 8.w, bottom: 5.w),
                                        child: Container(
                                            alignment: Alignment.bottomCenter,
                                            child: Image.asset(
                                                ImageUtility.dummyAudioImage)),
                                      )
                                    ],
                                  ));
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
                              Navigator.pushNamed(context, RouteName.addInfoScreen);
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
}
