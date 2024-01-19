import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/profile/providers/edit_audio_screen_provider.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/strings_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';

class EditAudioScreen extends StatefulWidget {
  final int id;

  const EditAudioScreen({super.key, required this.id});

  @override
  State<EditAudioScreen> createState() => _EditAudioScreenState();
}

class _EditAudioScreenState extends State<EditAudioScreen> {
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
      body: SafeArea(child: Consumer<EditAudioScreenProvider>(
          builder: (context, editAudioScreenProvider, child) {
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
            context.loc.titleUploadAudio,
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
              itemCount: selectedAudios.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index == 0
                    ? InkWell(
                      onTap: () {
                        _pickAudio();
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
                            Padding(
                              padding: EdgeInsets.only(top: 10.w, right: 12.w),
                              child: Container(
                                alignment: Alignment.topRight,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ColorUtility.color6A3699,
                                  borderRadius: BorderRadius.circular(10.r),
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
                                editAudioScreenProvider.updateUi();
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
            child: CustomButtonTopToBottomColor(
              width: double.infinity,
              buttonText: context.loc.buttonUpdate,
              onTap: () {
                AppLogger.logD("Audio length ${selectedAudios.length}");
                if (selectedAudios.isEmpty) {
                  Common.showErrorSnackBar(context, StringsUtility.uploadAudio);
                }else{

                  Common.showLoadingDialog(context);
                  editAudioScreenProvider.updateTalentProfileData(
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
                      selectedAudios: selectedAudios);

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
}
