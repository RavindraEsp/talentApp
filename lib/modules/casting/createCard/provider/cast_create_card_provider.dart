import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/repository/auth_repository.dart';
import 'package:talent_app/utilities/shared_preference.dart';
import 'package:talent_app/utilities/style_utility.dart';

class CastCreateCardProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController govtIdController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  XFile? logoImage;
  XFile? profileImage;

  final ImagePicker picker = ImagePicker();

  Future getImageLogo() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    print('PickedFileLogo: ${image.toString()}');
    //  setState(() {
    logoImage = XFile(image!.path);
    // Navigator.pop(this.context);
    // });
    notifyListeners();
  }

  Future getImageProfile() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    print('PickedFileProfile: ${image.toString()}');

    profileImage = XFile(image!.path);

    notifyListeners();
  }

  List<DropdownMenuItem<int>> listItems = [
    DropdownMenuItem(
      value: 1,
      child: Text(
        "Male",
        style: StyleUtility.hintTextStyle,
      ),
    ),
    DropdownMenuItem(
      value: 2,
      child: Text(
        "Female",
        style: StyleUtility.hintTextStyle,
      ),
    )
  ];
  int? selectedValue;

   createCard({required ValueChanged<String> onSuccess,
     required ValueChanged<String> onFailure,}) async {
    dio.MultipartFile? multipartFileLogoImage;

    multipartFileLogoImage = await dio.MultipartFile.fromFile(
      logoImage!.path,
      filename: logoImage!.name,
    );

    dio.MultipartFile? multipartFileProfileImage;

    multipartFileProfileImage = await dio.MultipartFile.fromFile(
      profileImage!.path,
      filename: profileImage!.name,
    );

    AppLogger.logD("multi part image ${multipartFileLogoImage.filename}");
    AppLogger.logD("multi part logo ${multipartFileProfileImage.filename}");

    final Map<String, dynamic> rawData = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "gender": selectedValue,
      "companyName": companyNameController.text,
      "address": addressController.text,
      "profilePic": multipartFileProfileImage,
      "logoPic": multipartFileLogoImage,
      "GovtId":govtIdController.text
    };


    authRepository.updateCasterProfile(rawData).then((value) {
      if (value.success == true) {

        Preference.setProfileImage(value.data?.profilePic ?? "");
        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    }).onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call("Server Error");
    });


    // final res = await authRepository.updateCasterProfile(rawData);
    //
    // if (value.success == true) {
    //   onSuccess.call(value);
    // } else {
    //   onFailure.call(value.msg ?? "");
    // }


  }
}
