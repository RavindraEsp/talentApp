import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/createAudition/widgets/yes_no_checkbox.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/model/telent_user_profile_model.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/providers/see_telent_user_profile_screen_provider.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/constants.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/shared_preference.dart';
import 'package:talent_app/utilities/strings_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/chat_button.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/no_data_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';

class SeeUserProfileScreen extends StatefulWidget {
  final int telentUserId;
  final String roomId;

  const SeeUserProfileScreen({super.key, required this.telentUserId, required this.roomId});

  @override
  State<SeeUserProfileScreen> createState() => _SeeUserProfileScreenState();
}

class _SeeUserProfileScreenState extends State<SeeUserProfileScreen> {
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    AppLogger.logD("telentUserId ${widget.telentUserId}");
    AppLogger.logD("roomId ${widget.roomId}");

    Provider.of<SeeTelentUserProfileScreenProvider>(context, listen: false)
        .getTalentUserProfile(widget.telentUserId, onFailure: (message) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
      body: Consumer<SeeTelentUserProfileScreenProvider>(
          builder: (context, provider, child) {
        return provider.isLoading == true
            ? const CustomCircularLoaderWidget()
            : Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.r),
                            bottomRight: Radius.circular(40.r)),
                        gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: ColorUtility.castHeaderGradientColor)),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 18.w,
                            right: 18.w,
                            //  top: 24.h, bottom: 24.h
                            top: 14.h,
                            bottom: 14.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SettingButtonWidget(),
                            Row(
                              children: [
                                const BackButton(
                                  color: Colors.white,
                                ),
                                Text(
                                  provider.talantUserProfileModel?.data?.first
                                          .name ??
                                      "",
                                  style: StyleUtility
                                      .kantumruyProSMedium18TextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize18.sp),
                                ),
                              ],
                            ),
                            const MenuButtonWidget()
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Row(
                              children: [
                                Image.asset(
                                  ImageUtility.userIcon,
                                  width: 20.w,
                                  height: 20.w,
                                ),
                                SizedBox(
                                  width: 9.w,
                                ),
                                Expanded(
                                  child: Text(
                                    "${provider.talantUserProfileModel?.data?.first.name ?? ""} |"
                                    " ${provider.talantUserProfileModel?.data?.first.gender == 1 ? context.loc.male : provider.talantUserProfileModel?.data?.first.gender == 2 ? context.loc.female : context.loc.other}",

                                    style: StyleUtility
                                        .quicksandRegularBlackTextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize16.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 17.5.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Row(
                              children: [
                                Image.asset(
                                  ImageUtility.birthdayIcon,
                                  width: 20.w,
                                  height: 20.w,
                                ),
                                SizedBox(
                                  width: 9.w,
                                ),
                                Expanded(
                                  child: Text(
                                    provider.talantUserProfileModel?.data?.first
                                            .age ??
                                        "",
                                    style: StyleUtility
                                        .quicksandRegularBlackTextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize16.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 17.5.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Row(
                              children: [
                                Image.asset(
                                  ImageUtility.locationIcon,
                                  height: 26.w,
                                  color: ColorUtility.color5457BE,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Expanded(
                                  child: Text(
                                    provider.talantUserProfileModel?.data?.first
                                            .address ??
                                        "",
                                    style: StyleUtility
                                        .quicksandRegularBlackTextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize16.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 23.h,
                          ),
                          SizedBox(
                              height: 420.sp,
                              child: ProfileImageViewPagerWidget()),
                          SizedBox(
                            height: 23.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ChatButton(
                                    buttonText:
                                        "${context.loc.buttonChatWith} ${provider.talantUserProfileModel?.data?.first.username ?? ""}",
                                    icon: ImageUtility.messageNavIcon,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteName.chatScreen,
                                          arguments: {
                                            "userType": UserType.cast,
                                            "receiverId":widget.telentUserId,
                                           // "roomId":"${Preference().getUserId()}${widget.telentUserId}",
                                            "roomId":widget.roomId,
                                            "title":provider.talantUserProfileModel?.data?.first.username ?? ""
                                          });
                                    }),
                                SizedBox(
                                  height: 23.h,
                                ),
                                Text(
                                  context.loc.titleIntroText,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Text(
                                  provider.talantUserProfileModel?.data?.first
                                          .about ??
                                      "",
                                  style: StyleUtility
                                      .quicksandMediumBlackTextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Text(
                                  context.loc.titleGenre,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                Wrap(
                                  children: [
                                    for (var item in provider.lookingForList)
                                      Container(
                                          margin: EdgeInsets.only(
                                              right: 9.w, top: 12.h),
                                          padding: EdgeInsets.only(
                                              left: 20.sp,
                                              right: 20.sp,
                                              top: 9.sp,
                                              bottom: 12.sp),
                                          decoration: BoxDecoration(
                                              color: ColorUtility.colorWhite,
                                              borderRadius:
                                                  BorderRadius.circular(30.r),
                                              border: Border.all(
                                                  color: ColorUtility
                                                      .colorD3D6D6)),
                                          child: Text(
                                            item,
                                            style: StyleUtility
                                                .mulishRegularBlackTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize12.sp),
                                          ))
                                  ],
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Text(
                                  context.loc.titleBody,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                Wrap(
                                  children: [
                                    for (var item in provider.bodyList)
                                      Container(
                                          margin: EdgeInsets.only(
                                              right: 9.w, top: 12.h),
                                          padding: EdgeInsets.only(
                                              left: 20.sp,
                                              right: 20.sp,
                                              top: 9.sp,
                                              bottom: 12.sp),
                                          decoration: BoxDecoration(
                                              color: ColorUtility.colorWhite,
                                              borderRadius:
                                                  BorderRadius.circular(30.r),
                                              border: Border.all(
                                                  color: ColorUtility
                                                      .colorD3D6D6)),
                                          child: Text(
                                            item,
                                            style: StyleUtility
                                                .mulishRegularBlackTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize12.sp),
                                          ))
                                  ],
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Text(
                                  context.loc.titleVideos,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),

                                (provider.videoList.length ?? 0) == 0
                                    ? SizedBox(
                                        height: 100.h,
                                        child: const NoDataWidget())
                                    : SizedBox(
                                        height: 210.h,
                                        child: (provider.videoList.length ??
                                                    0) ==
                                                0
                                            ? const NoDataWidget()
                                            : ListView.builder(
                                                padding: EdgeInsets.zero,
                                                itemCount:
                                                    provider.videoList.length ??
                                                        0,
                                                // itemCount: 2,

                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        right: 15.w),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        // Image.asset(
                                                        //   ImageUtility
                                                        //       .dummyVideoThumbnailImage,
                                                        //   //  width: double.infinity,
                                                        //   height: 210.h,
                                                        //   fit: BoxFit.fill,
                                                        // ),

                                                        Container(
                                                          height: 210.h,
                                                          width: 300.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            color: Colors.black,
                                                          ),
                                                        ),

                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pushNamed(context,
                                                                RouteName.videoPlayerScreen,
                                                                arguments: {
                                                                  "videoFromApi":provider.videoList[index]
                                                                      .files ?? ""
                                                                });
                                                          },
                                                          child: Image.asset(
                                                            ImageUtility
                                                                .playCircleIcon,
                                                            width: 55.w,
                                                            height: 55.w,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                      ),



                                SizedBox(
                                  height: 30.h,
                                ),
                                Text(
                                  context.loc.titleAudioFiles,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                (provider.videoList.length ?? 0) == 0
                                    ? SizedBox(
                                    height: 100.h,
                                    child: const NoDataWidget())
                                    :
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: provider.audioList.length,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          margin: EdgeInsets.only(top: 16.h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.sp),
                                            border: Border.all(
                                                color:
                                                    ColorUtility.colorD6D6D8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 20.w,
                                                right: 14.w,
                                                top: 10.h,
                                                bottom: 10.h),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap:(){
                                                    Navigator.pushNamed(context,
                                                        RouteName.audioPlayerScreen,
                                                        arguments: {
                                                          "audioFromApi": provider.audioList[index]
                                                              .files ?? ""
                                                        });
                                                  },
                                                  child: Image.asset(
                                                    ImageUtility.playIcon,
                                                    width: 13.w,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 28.w,
                                                ),
                                                Expanded(
                                                    child: Image.asset(
                                                  ImageUtility.dummyAudioImage,
                                                  width: double.infinity,
                                                  fit: BoxFit.contain,
                                                )),
                                                SizedBox(
                                                  width: 22.w,
                                                ),
                                                // Text(
                                                //   "0:31",
                                                //   style: StyleUtility
                                                //       .quicksandMediumACACAFTextStyle
                                                //       .copyWith(
                                                //           fontSize:
                                                //               TextSizeUtility
                                                //                   .textSize13
                                                //                   .sp),
                                                // )
                                              ],
                                            ),
                                          ));
                                    }),
                                SizedBox(
                                  height: 35.h,
                                ),
                                Text(
                                  context.loc.titleAnyWorkExperience,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    YesNoCheckBoxWidget(
                                      title: context.loc.checkBoxYes,
                                      status:
                                          provider.isExperienceNeeded == true,
                                    ),
                                    SizedBox(
                                      width: 38.h,
                                    ),
                                    YesNoCheckBoxWidget(
                                      title: context.loc.checkBoxNo,
                                      status:
                                          provider.isExperienceNeeded == false,
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   height: 11.h,
                                // ),
                                // Text(
                                //   "I am an enthusiastic, self-motivated, reliable, responsible and hard working person.",
                                //   style: StyleUtility
                                //       .quicksandRegularBlackTextStyle
                                //       .copyWith(
                                //           fontSize:
                                //               TextSizeUtility.textSize16.sp),
                                // ),
                                SizedBox(
                                  height: 35.h,
                                ),
                                Text(
                                  context
                                      .loc.titleDidYouParticipatedRealityShow,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    YesNoCheckBoxWidget(
                                      title: context.loc.checkBoxYes,
                                      status: provider.isParticipate == true,
                                    ),
                                    SizedBox(
                                      width: 38.h,
                                    ),
                                    YesNoCheckBoxWidget(
                                      title: context.loc.checkBoxNo,
                                      status: provider.isParticipate == false,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 35.h,
                                ),
                                Text(
                                  context.loc.titleSocialMediaLinks,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 22.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: InkWell(
                                        onTap: () {


                                          if (provider
                                                      .talantUserProfileModel
                                                      ?.data
                                                      ?.first
                                                      .facebooklink ==
                                                  null ||
                                              provider
                                                      .talantUserProfileModel
                                                      ?.data
                                                      ?.first
                                                      .facebooklink ==
                                                  "") {
                                            Common.showErrorSnackBar(context, StringsUtility.noLinkAvailable);

                                          }
                                          Constant.launchUrlBrowser(
                                              provider
                                                      .talantUserProfileModel
                                                      ?.data
                                                      ?.first
                                                      .facebooklink ??
                                                  "");
                                        },
                                        child: Image.asset(
                                          ImageUtility.fbCircleIcon,
                                          width: 55.w,
                                          height: 55.w,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: InkWell(
                                        onTap: () {
                                          if (provider.talantUserProfileModel
                                                      ?.data?.first.instalink ==
                                                  null ||
                                              provider.talantUserProfileModel
                                                      ?.data?.first.instalink ==
                                                  "") {
                                            Common.showErrorSnackBar(
                                                context, StringsUtility.noLinkAvailable);
                                          }
                                          Constant.launchUrlBrowser(
                                              provider.talantUserProfileModel
                                                      ?.data?.first.instalink ??
                                                  "");
                                        },
                                        child: Image.asset(
                                          ImageUtility.instagramCircleIcon,
                                          width: 55.w,
                                          height: 55.w,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: InkWell(
                                        onTap: () {
                                          if (provider
                                                      .talantUserProfileModel
                                                      ?.data
                                                      ?.first
                                                      .youtubelink ==
                                                  null ||
                                              provider
                                                      .talantUserProfileModel
                                                      ?.data
                                                      ?.first
                                                      .youtubelink ==
                                                  "") {
                                            Common.showErrorSnackBar(
                                                context, StringsUtility.noLinkAvailable);
                                          }
                                          Constant.launchUrlBrowser(
                                              provider
                                                      .talantUserProfileModel
                                                      ?.data
                                                      ?.first
                                                      .youtubelink ??
                                                  "");
                                        },
                                        child: Image.asset(
                                          ImageUtility.youtubeCircleIcon,
                                          width: 55.w,
                                          height: 55.w,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: InkWell(
                                        onTap: () {
                                          if (provider
                                                      .talantUserProfileModel
                                                      ?.data
                                                      ?.first
                                                      .youtubelink ==
                                                  null ||
                                              provider
                                                      .talantUserProfileModel
                                                      ?.data
                                                      ?.first
                                                      .youtubelink ==
                                                  "") {
                                            Common.showErrorSnackBar(
                                                context, StringsUtility.noLinkAvailable);
                                          }
                                          Constant.launchUrlBrowser(
                                              provider
                                                      .talantUserProfileModel
                                                      ?.data
                                                      ?.first
                                                      .youtubelink ??
                                                  "");
                                        },
                                        child: Image.asset(
                                          ImageUtility.tiktokCircleIcon,
                                          width: 55.w,
                                          height: 55.w,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 35.h,
                                ),
                                Text(
                                  context.loc.titleNotes,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),

                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10.w,
                                      top: 16,
                                      bottom: 16,
                                      right: 10.w),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                        color: ColorUtility.colorD6D6D8),
                                  ),
                                  child: Text(
                                    provider.talantUserProfileModel?.data?.first
                                            .about ??
                                        "",
                                    style: StyleUtility.inputTextStyle.copyWith(
                                      fontSize: TextSizeUtility.textSize15.sp,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 22.h,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 35.h,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
      }),
    );
  }
}

class ProfileImageViewPagerWidget extends StatefulWidget {
  const ProfileImageViewPagerWidget({Key? key}) : super(key: key);

  @override
  State<ProfileImageViewPagerWidget> createState() =>
      _ProfileImageViewPagerWidgetState();
}

class _ProfileImageViewPagerWidgetState
    extends State<ProfileImageViewPagerWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;

  // final int _pageLength = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<SeeTelentUserProfileScreenProvider>(
        builder: (context, provider, child) {
      return provider.isLoading == true
          ? const CustomCircularLoaderWidget()
          : Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _activePage = page;
                    });
                  },
                  itemCount: provider.talantUserProfileModel?.data?.first
                          .imageFiles?.length ??
                      0,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(right: 20.w, left: 20.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(
                          height: 420.sp,
                          width: double.infinity,
                          color: Colors.grey.withOpacity(0.1),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 420.sp,
                                width: double.infinity,
                                child: CachedNetworkImage(
                                    width: 100.sp,
                                    height: 100.sp,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Center(
                                            child: Icon(
                                          Icons.error,
                                          size: 25.sp,
                                        )),
                                    imageUrl:
                                        "${Endpoints.imageBaseUrl}${provider.talantUserProfileModel?.data?.first.imageFiles?[index].files}"),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.w, right: 10.w, bottom: 10.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageUtility.popularIcon,
                                      width: 52.w,
                                    ),
                                    Text(
                                      context.loc.buttonPopular,
                                      style: StyleUtility
                                          .quicksandMediumWhiteTextStyle
                                          .copyWith(
                                              fontSize: TextSizeUtility
                                                  .textSize12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.only(top: 9.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                        provider.talantUserProfileModel?.data?.first.imageFiles
                                ?.length ??
                            0,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: InkWell(
                                onTap: () {
                                  _pageController.animateToPage(index,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn);
                                },
                                child: Container(
                                  height: 4.h,
                                  width: 68.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: _activePage == index
                                          ? ColorUtility.color3D2D82
                                          : ColorUtility.colorWhite),
                                ),
                              ),
                            )),
                  ),
                ),
              ],
            );
    }));
  }
}

class AppliedUserDetailWidget extends StatelessWidget {
  const AppliedUserDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(right: 20.w, left: 20.w),
      child: Container(
        height: 420.sp,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageUtility.dummyAppliedUserImage),
              fit: BoxFit.fill),
        ),
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageUtility.userIcon,
                  color: Colors.white,
                  width: 18.w,
                  //  height: 22.w,
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Text(
                        "Michaela Cohoen 25",
                        style: StyleUtility.quicksandBoldWhiteTextStyle
                            .copyWith(fontSize: TextSizeUtility.textSize18.sp),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  ImageUtility.locationIcon,
                  color: Colors.white,
                  width: 20.w,
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Text(
                        "Rehovot",
                        style: StyleUtility.quicksandMediumWhiteTextStyle
                            .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(
                      ImageUtility.backCircleIcon,
                      width: 52.w,
                    ),
                    Text(
                      context.loc.buttonBack,
                      style: StyleUtility.quicksandMediumWhiteTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize12.sp),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      ImageUtility.declineCircleIcon,
                      width: 52.w,
                    ),
                    Text(
                      context.loc.decline,
                      style: StyleUtility.quicksandMediumWhiteTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize12.sp),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Image.asset(
                        ImageUtility.verifyGreenIcon,
                        width: 52.w,
                      ),
                      Text(
                        context.loc.approve,
                        style: StyleUtility.quicksandMediumWhiteTextStyle
                            .copyWith(fontSize: TextSizeUtility.textSize12.sp),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Image.asset(
                      ImageUtility.nextCircleIcon,
                      width: 52.w,
                    ),
                    Text(
                      context.loc.buttonNext,
                      style: StyleUtility.quicksandMediumWhiteTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize12.sp),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
