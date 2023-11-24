
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/network/repository/auth_repository.dart';
import 'package:talent_app/utilities/style_utility.dart';

class CastCreateCardProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();



  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idController = TextEditingController();
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



  Future<void> createCard() async {



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

    AppLogger.logD("multi part ${multipartFileLogoImage.filename}");
    AppLogger.logD("multi part ${multipartFileProfileImage.contentType}");


    final Map<String, dynamic> rawData = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "gender": 1,
      "companyName": companyNameController.text,
      "address": addressController.text,
      "profilePic": multipartFileLogoImage,
      "logoPic": multipartFileLogoImage,

      // referralController.text
    };


  //  final  res = await authRepository.updateCasterProfile(rawData);



  }




}
