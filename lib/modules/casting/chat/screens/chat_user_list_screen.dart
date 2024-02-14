import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/chat/model/chat_user_list_resposne_model.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/shared_preference.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';
import 'package:talent_app/widgets/textField/search_text_field.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatUserListScreen extends StatefulWidget {
  final UserType userType;

  const ChatUserListScreen({super.key, required this.userType});

  @override
  State<ChatUserListScreen> createState() => _ChatUserListScreenState();
}

class _ChatUserListScreenState extends State<ChatUserListScreen> {
  TextEditingController searchController = TextEditingController();

  IO.Socket? socket;

  bool loading = true;

  ChatUserListResponseModel? chatUserListResponseModel;

  @override
  void initState() {

    Future.delayed(Duration(seconds: 1)).then((value){
      connectAndListenChatSocket();
    });

  }

  @override
  void dispose() {
    socket?.disconnect();
    super.dispose();
  }

  connectAndListenChatSocket() {
    int userId = Preference().getUserId();

    AppLogger.logD("User id $userId");

    try {
      socket = IO.io(
          'https://espsofttech.in:7272',
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .enableAutoConnect()
              .enableForceNewConnection()
              .enableReconnection()
              .build());

      socket?.onConnect((_) {
        AppLogger.logD('connect');

        final Map<String, dynamic> data = {
          "userId": userId,
        };

        AppLogger.logD(data);

        socket?.emit('joinAllRoom', jsonEncode(data));

        AppLogger.logD("joinAllRoom call");
      });

      socket?.on("roomUsersAll$userId", (data) {
        // get all msg

        AppLogger.logD("on roomUsersAll =>");

        chatUserListResponseModel = ChatUserListResponseModel.fromJson(data);
        AppLogger.logD(
            "userList length   ${chatUserListResponseModel?.userList?.length}");

        loading = false;

        final Map mapData = data as Map;

        AppLogger.logD("roomUsersAll data is in start $mapData");

         setState(() {});
      });

      socket?.on("allroommessage$userId", (data) {
        // get all msg

        AppLogger.logD("on allroommessage$userId =>");

        chatUserListResponseModel = ChatUserListResponseModel.fromJson(data);
        AppLogger.logD(
            "userList length   ${chatUserListResponseModel?.userList?.length}");

        loading = false;

        final Map mapData = data as Map;

        AppLogger.logD("allroommessage$userId data is in $mapData");

        setState(() {});
      });




      socket?.onDisconnect((_) => AppLogger.logD('disconnect'));
      socket?.on('fromServer', (_) => AppLogger.logD(_));

      socket?.onConnectError((data) {
        AppLogger.logD("Error 1 onConnectError");
        AppLogger.logD("data is  2 $data");
      });

      socket?.onConnectTimeout((data) {
        AppLogger.logD("Error 2 onConnectTimeout");
      });

      socket?.onConnecting((data) {
        AppLogger.logD("Error 3 onConnecting");
      });

      socket?.onError((data) {
        AppLogger.logD("Error 4 onError");
        AppLogger.logD("data is 4 $data");
      });
    } catch (e) {
      AppLogger.logD(e.toString());
    }
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


          Expanded(
            child: loading == true ? const CustomCircularLoaderWidget():Column(
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
                      controller: searchController, hintText: "Search Candidate"),
                ),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 20.h, bottom: 35.h),
                      itemCount: chatUserListResponseModel?.userList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.chatScreen,
                                arguments: {
                                  // "userType":widget.userType,
                                  // "receiverId":0,
                                  // "roomCasterId":0,
                                  // "title":"List user",

                                  // "userType": widget.userType,
                                  // "receiverId": 22,
                                  // "roomId": "2242",
                                  // "title": "List user",

                                  "userType": widget.userType,
                                  "receiverId": chatUserListResponseModel?.userList?[index].apponentId,
                                  "roomId": chatUserListResponseModel?.userList?[index].roomId,
                                  "title": "List user",



                                  //  {receiverId: 42, senderId: 22, roomCasterId: 22}
                                });
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
                                            "${Endpoints.imageBaseUrl}${chatUserListResponseModel?.userList?[index].userProfile ?? ""}"),
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
                                                      chatUserListResponseModel?.userList?[index].userName ?? "",
                                                      style: StyleUtility
                                                          .quicksandBoldBlackTextStyle
                                                          .copyWith(
                                                          fontSize: TextSizeUtility
                                                              .textSize18.sp),
                                                    ),
                                                  ),
                                                  Text(
                                                   // "Yesterday",

                                                    CommonMethod.getDateTime(chatUserListResponseModel?.userList?[index].datetime ?? "")
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
                                                      chatUserListResponseModel?.userList?[index].message ?? "",
                                                      style: StyleUtility
                                                          .quicksandRegular787E84TextStyle
                                                          .copyWith(
                                                          fontSize: TextSizeUtility
                                                              .textSize14.sp),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  // (chatUserListResponseModel?.userList?[index].msgCount ?? "") != "" ?
                                                  // Container(
                                                  //   padding: EdgeInsets.all(10.sp),
                                                  //
                                                  //   decoration: const BoxDecoration(
                                                  //     shape: BoxShape.circle,
                                                  //     color: ColorUtility.color5457BE
                                                  //   ),
                                                  //   child: Center(child:Text(
                                                  //     // "Hi, I’m glad you applied to the audition See you there",
                                                  //     chatUserListResponseModel?.userList?[index].msgCount ?? "",
                                                  //     style: StyleUtility
                                                  //         .quicksandMediumWhiteTextStyle.copyWith(
                                                  //       fontSize: TextSizeUtility.textSize14.sp
                                                  //     )
                                                  //         .copyWith(
                                                  //         fontSize: TextSizeUtility
                                                  //             .textSize14.sp),
                                                  //     maxLines: 1,
                                                  //     overflow: TextOverflow.ellipsis,
                                                  //   ),),
                                                  // ):const SizedBox()
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
            ),
          )

        ],
      ),
    );
  }
}
