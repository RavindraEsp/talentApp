import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/casting/chat/provider/chat_user_list_screen_provider.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/no_data_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';
import 'package:talent_app/widgets/textField/search_text_field.dart';

class ChatUserListScreen extends StatefulWidget {
  final UserType userType;

  const ChatUserListScreen({super.key, required this.userType});

  @override
  State<ChatUserListScreen> createState() => _ChatUserListScreenState();
}

class _ChatUserListScreenState extends State<ChatUserListScreen> {


  ChatUserListScreenProvider? chatUserListScreenProvider;


  @override
  void initState() {


    chatUserListScreenProvider = Provider.of<ChatUserListScreenProvider>(context,listen: false);
    chatUserListScreenProvider?.connectAndListenChatSocket();

  }

  @override
  void dispose() {
    chatUserListScreenProvider?.socket?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r)),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: widget.userType == UserType.cast
                        ? ColorUtility.castHeaderGradientColor
                        : ColorUtility.talentHeaderGradientColor)),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 18.w, right: 18.w, top: 24.h, bottom: 24.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SettingButtonWidget(),
                    Row(
                      children: [
                        // const BackButton(
                        //   color: Colors.white,
                        // ),
                        Text(
                          context.loc.headerChats,
                          style: StyleUtility.kantumruyProSMedium18TextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize18.sp),
                        ),
                      ],
                    ),
                    widget.userType == UserType.cast
                        ? const MenuButtonWidget()
                        : const TalentMenuButtonWidget()
                  ],
                ),
              ),
            ),
          ),


          Consumer<ChatUserListScreenProvider>(
            builder: (context, provider,child) {
              return Expanded(
                child: provider.loading == true ? const CustomCircularLoaderWidget():


                (provider.chatUserListResponseModel?.userList?.length ?? 0) != 0 ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, top: 18.h, bottom: 16.h),
                      child: Text(
                        context.loc.headerChats,
                        style: StyleUtility.kantumruyProSemiBold5457BETextStyle
                            .copyWith(fontSize: TextSizeUtility.textSize26.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: SearchTextField(
                          controller: provider.searchController, hintText: "Search Candidate"),
                    ),
                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 20.h, bottom: 35.h),
                          itemCount: provider.chatUserListResponseModel?.userList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {


                                provider.socket?.disconnect();

                                Map data;

                                if(provider.chatUserListResponseModel?.userList?[index].groupId == 0){ // single chat
                                  data = {
                                    "userType": widget.userType,
                                    "receiverId": provider.chatUserListResponseModel?.userList?[index].apponentId,
                                    "roomId": provider.chatUserListResponseModel?.userList?[index].roomId,
                                    "title": provider.chatUserListResponseModel?.userList?[index].userName,
                                    "title": provider.chatUserListResponseModel?.userList?[index].userName,
                                  };
                                }else{
                                  data = {
                                    "userType": widget.userType,
                                    "receiverId": provider.chatUserListResponseModel?.userList?[index].groupId,
                                    "roomId": provider.chatUserListResponseModel?.userList?[index].roomId,
                                    "title": provider.chatUserListResponseModel?.userList?[index].userName,
                                    "chatType": ChatType.group,
                                  };
                                }


                                Navigator.pushNamed(context, RouteName.chatScreen,
                                    arguments: data).then((value) => provider.connectAndListenChatSocket());

                                    // arguments: {
                                    //
                                    //   "userType": widget.userType,
                                    //   "receiverId": provider.chatUserListResponseModel?.userList?[index].apponentId,
                                    //   "roomId": provider.chatUserListResponseModel?.userList?[index].roomId,
                                    //   "title": provider.chatUserListResponseModel?.userList?[index].userName,
                                    //
                                    // }).then((value) => provider.connectAndListenChatSocket());
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 20.w,
                                  right: 20.w,
                                ),
                                child: Column(
                                  children: [
                                    index == 0
                                        ? Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: ColorUtility.colorD6D6D8)
                                        : const SizedBox(),
                                    Container(
                                      padding: EdgeInsets.only(top: 17.h, bottom: 20.h),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          // Image.asset(
                                          //   ImageUtility.dummyProfileImage,
                                          //   width: 55.w,
                                          //   height: 55.w,
                                          // ),


                                          ClipOval(
                                            child: CachedNetworkImage(
                                                width: 55.sp,
                                                height: 55.sp,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                const Center(child: CircularProgressIndicator()),
                                                errorWidget: (context, url, error) => Container(
                                                    color: Colors.grey,
                                                    child: Center(
                                                        child: Icon(
                                                          Icons.error,
                                                          size: 25.sp,
                                                        ))),
                                                imageUrl:
                                                "${Endpoints.imageBaseUrl}${provider.chatUserListResponseModel?.userList?[index].userProfile ?? ""}"),
                                          ),


                                          SizedBox(
                                            width: 12.w,
                                          ),
                                          Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                         // "Michaela Cohoen",
                                                          provider.chatUserListResponseModel?.userList?[index].userName ?? "",
                                                          style: StyleUtility
                                                              .quicksandBoldBlackTextStyle
                                                              .copyWith(
                                                              fontSize: TextSizeUtility
                                                                  .textSize18.sp),
                                                        ),
                                                      ),
                                                      Text(
                                                       // "Yesterday",

                                                        CommonMethod.getDateTime(provider.chatUserListResponseModel?.userList?[index].datetime ?? "")
                                                        ,
                                                        style: StyleUtility
                                                            .quicksandRegular787E84TextStyle
                                                            .copyWith(
                                                            fontSize: TextSizeUtility
                                                                .textSize14.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(

                                                        child: Text(
                                                         // "Hi, I’m glad you applied to the audition See you there",
                                                          provider.chatUserListResponseModel?.userList?[index].message ?? "",
                                                          style: StyleUtility
                                                              .quicksandRegular787E84TextStyle
                                                              .copyWith(
                                                              fontSize: TextSizeUtility
                                                                  .textSize14.sp),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      (provider.chatUserListResponseModel?.userList?[index].msgCount ?? "") != ""
                                                          && (provider.chatUserListResponseModel?.userList?[index].msgCount ?? "") != "0"
                                                          ?
                                                      Container(
                                                        padding: EdgeInsets.all(10.sp),

                                                        decoration: const BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: ColorUtility.color5457BE
                                                        ),
                                                        child: Center(child:Text(
                                                          provider.chatUserListResponseModel?.userList?[index].msgCount ?? "",
                                                          style: StyleUtility
                                                              .quicksandMediumWhiteTextStyle.copyWith(
                                                            fontSize: TextSizeUtility.textSize14.sp
                                                          )
                                                              .copyWith(
                                                              fontSize: TextSizeUtility
                                                                  .textSize14.sp),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),),
                                                      ):const SizedBox()
                                                    ],
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: ColorUtility.colorD6D6D8),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ):const NoDataWidget(
                ),
              );
            }
          )

        ],
      ),
    );
  }
}
