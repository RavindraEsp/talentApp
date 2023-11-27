import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/commonModels/drop_down_model.dart';
import 'package:talent_app/network/model/response/profile/caster_profile_response_model.dart';
import 'package:talent_app/network/repository/auth_repository.dart';
import 'package:talent_app/utilities/shared_preference.dart';

class CastProfileProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  String? networkLogoImage;
  String? networkProfileImage;

  XFile? logoImage;
  XFile? profileImage;

  final ImagePicker picker = ImagePicker();

  CasterProfileResponseModel? casterProfileResponseModel;

 bool isLoading = true;


  DropDownModel? selectGender;
  List<DropDownModel> genderList = [
    DropDownModel("Male", "1"),
    DropDownModel("Female", "2")
  ];


  getProfileData({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
  }) {
    authRepository.getCasterProfile().then((value) {
      if (value.success == true) {
        onSuccess.call(value.msg ?? "");
        casterProfileResponseModel = value;
        setAutoFillValue();
        isLoading = false;
        notifyListeners();

      } else {
        onFailure.call(value.msg ?? "");
        isLoading = false;
        notifyListeners();


      }
    })
        .onError((error, stackTrace) {
      AppLogger.logD("error $error");
      onFailure.call("Server Error");
      isLoading = false;
      notifyListeners();


    });
  }

setAutoFillValue() {
    firstNameController.text = casterProfileResponseModel?.data?.firstName ?? "";
    lastNameController.text =  casterProfileResponseModel?.data?.lastName ?? "";
    idController.text = "";
    addressController.text =  casterProfileResponseModel?.data?.address ?? "";
    companyNameController.text =  casterProfileResponseModel?.data?.companyName ?? "";

    networkLogoImage = casterProfileResponseModel?.data?.logo ?? "";
    networkProfileImage = casterProfileResponseModel?.data?.profilePic ?? "";

    if(casterProfileResponseModel?.data?.gender.toString() == "1"){
      selectGender = DropDownModel("Male", "1");

    }else if(casterProfileResponseModel?.data?.gender == "2"){
      selectGender = DropDownModel("Female", "2");

    }

    selectGender = genderList.firstWhere(
            (gender) => gender.value.toString() == casterProfileResponseModel?.data?.gender.toString());


    notifyListeners();
  }


 updateProfile({required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,}) async {
    dio.MultipartFile? multipartFileLogoImage;


if(logoImage !=null){
  multipartFileLogoImage = await dio.MultipartFile.fromFile(
    logoImage!.path,
    filename: logoImage!.name,
  );

}
    dio.MultipartFile? multipartFileProfileImage;

   if(profileImage !=null){

     multipartFileProfileImage = await dio.MultipartFile.fromFile(
       profileImage!.path,
       filename: profileImage!.name,
     );
   }



    AppLogger.logD("multi part image ${multipartFileLogoImage?.filename}");
    AppLogger.logD("multi part logo ${multipartFileProfileImage?.filename}");

     Map<String, dynamic>? rawData;
    if(multipartFileProfileImage != null && multipartFileLogoImage != null){
       rawData = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "gender": selectGender?.value,
        "companyName": companyNameController.text,
        "address": addressController.text,
        "profilePic": multipartFileProfileImage,
        "logoPic": multipartFileLogoImage,
      };
    }else if(multipartFileProfileImage != null && multipartFileLogoImage == null){
      rawData = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "gender": selectGender?.value,
        "companyName": companyNameController.text,
        "address": addressController.text,
        "profilePic": multipartFileProfileImage,
      };
    }
    else if(multipartFileProfileImage == null && multipartFileLogoImage != null){
      rawData = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "gender": selectGender?.value,
        "companyName": companyNameController.text,
        "address": addressController.text,
        "logoPic": multipartFileLogoImage,
      };



    }else{
      rawData = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "gender": selectGender?.value,
        "companyName": companyNameController.text,
        "address": addressController.text,
        "logoPic": multipartFileLogoImage,
      };

    }


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

  Future getImageLogo() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    AppLogger.logD('PickedFileLogo: ${image.toString()}');
    logoImage = XFile(image!.path);

    notifyListeners();
  }

  Future getImageProfile() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    AppLogger.logD('PickedFileProfile: ${image.toString()}');
    profileImage = XFile(image!.path);
    notifyListeners();
  }

  updateUi(){
notifyListeners();

  }
}
