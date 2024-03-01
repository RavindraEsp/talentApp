
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/chat/model/chat_msg_response_model.dart';
import 'package:talent_app/modules/casting/chat/provider/chat_screen_provider.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/network/end_points.dart';
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

class ChatScreen extends StatefulWidget {
  final UserType userType;
  final int receiverId; // when come from single then receiver anf come from group then groupId
  final String roomId;
  final String title;
  final ChatType chatType;

  const ChatScreen(
      {Key? key,
      required this.userType,
      required this.receiverId,
      required this.roomId,
      required this.title,
        required this.chatType})
      : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenProvider? chatScreenProvider;

  @override
  void initState() {
    super.initState();
    AppLogger.logD('Receiver id or grop id ${widget.receiverId}');
    AppLogger.logD('user id  ${Preference().getUserId()}');
    AppLogger.logD('roomCasterId   ${widget.roomId}');



      chatScreenProvider = Provider.of(context, listen: false);

      chatScreenProvider?.connectAndListenChatSocket(
          receiverId: widget.receiverId, roomId: widget.roomId,chatType: widget.chatType);




  }

  @override
  void dispose() {
    chatScreenProvider?.socket?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorF4F0EA,
      body: Column(
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
                    // colors: ColorUtility.castHeaderGradientColor
                    colors: widget.userType == UserType.cast
                        ? ColorUtility.castHeaderGradientColor
                        : ColorUtility.talentHeaderGradientColor)),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 18.w,
                    right: 18.w,
                    // top: 24.h, bottom: 24.h
                    top: 14.h,
                    bottom: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SettingButtonWidget(),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center, // Center the elements in the Row



                        children: [
                          const BackButton(
                            color: Colors.white,
                          ),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: 180.w
                            ),
                            child: Text(
                              widget.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: StyleUtility.kantumruyProSMedium18TextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize18.sp),
                             // textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
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
            child: Consumer<ChatScreenProvider>(
                builder: (context, provider, child) {
              return provider.loading == true
                  ? const CustomCircularLoaderWidget()
                  : Column(
                      children: [
                        Expanded(
                            child: ChatListView(
                          scrollController: provider.scrollController,
                          messageList:
                              provider.chatMsgResponseModel?.chatHistory,
                        )),


                        widget.chatType == ChatType.group && widget.userType == UserType.talent ?
                            Container(
                              width: double.infinity,
                              color:Colors.white,
                              alignment:Alignment.center,
                              padding:  EdgeInsets.symmetric(vertical: 20.h),
                              margin:  EdgeInsets.only(top: 8.h),
                              child:  Text("Only caster can send messages",style: StyleUtility.inputTextStyle.copyWith(
                                fontSize: TextSizeUtility.textSize14.sp,
                              ),),
                            ):
                        Container(
                          height: 50,
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: ColorUtility.colorWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: provider.textEditingController,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 6,
                                  style: StyleUtility.inputTextStyle.copyWith(
                                      fontSize: TextSizeUtility.textSize14.sp),
                                  decoration: InputDecoration(
                                    hintText: context.loc.hintSentAMessage,
                                    hintStyle: StyleUtility.hintTextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize14.sp),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),

                              // Container(
                              //   padding: EdgeInsets.only(left: 10.w, right: 10.w),
                              //   child: Center(
                              //     child: SizedBox(
                              //       width: 21.w,
                              //       child: Image.asset(ImageUtility.cameraIcon),
                              //     ),
                              //   ),
                              // ),
                              //
                              // Padding(
                              //   padding: EdgeInsets.only(left: 10.w, right: 10.w),
                              //   child: Center(
                              //     child: SizedBox(
                              //       width: 13.w,
                              //       child: Image.asset(ImageUtility.micIcon),
                              //     ),
                              //   ),
                              // ),
                              GestureDetector(
                                onTap: () {
                                  if (provider
                                      .textEditingController.text.trim().isNotEmpty) {
                                    provider.sendMessage(provider
                                        .textEditingController.text
                                        .trim());

                                      provider.textEditingController.clear();
                                      provider.scrollAnimation();

                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorUtility.color5457BE,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r))),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.sp,
                                            bottom: 5.sp,
                                            left: 10,
                                            right: 10),
                                        child: Image.asset(
                                            ImageUtility.sendMsgIcon))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            }),
          )
        ],
      ),
    );
  }
}

class ChatListView extends StatelessWidget {

  List<ChatHistory>? messageList;
  ScrollController scrollController;

  ChatListView({
    Key? key,
    required this.scrollController,
    required this.messageList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        itemCount: messageList?.length ?? 0,
        itemBuilder: (context, index) {
          return (messageList?[index].senderId == Preference().getUserId())
              ? SenderRowView(chatHistory: messageList?[index],)
              : ReceiverRowView(
            chatHistory: messageList?[index],
          );
        });
  }
}

class ReceiverRowView extends StatelessWidget {
  const ReceiverRowView({Key? key,
    required this.chatHistory
  })
      : super(key: key);


  final ChatHistory? chatHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 70.w, left: 5.w, top: 8.w, bottom: 2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [


          ClipOval(
            child: CachedNetworkImage(
                width: 40.w,
                height: 40.w,
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
                "${Endpoints.imageBaseUrl}${chatHistory?.profilePic ?? ""}"),
          ),


          SizedBox(
            width: 4.w,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(
                    left: 10.w, right: 10.w, top: 9.w, bottom: 9.w),
                decoration: BoxDecoration(
                    color: ColorUtility.colorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Column(
                //  crossAxisAlignment: CrossAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(

                  chatHistory?.message ?? "",
                      style: StyleUtility.quicksandRegularBlackTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize14.sp),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                       // '8:55',
                        CommonMethod.getTime(chatHistory?.datetime ?? ""),
                        style: StyleUtility.mulishRegularBlackTextStyle
                            .copyWith(fontSize: TextSizeUtility.textSize10.sp)),
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}

class SenderRowView extends StatelessWidget {
  const SenderRowView({Key? key, required this.chatHistory})
      : super(key: key);

  final ChatHistory? chatHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(left: 70.w, right: 5.w, top: 8.w, bottom: 2.w),
      child: Container(
          padding:
              EdgeInsets.only(left: 10.w, right: 10.w, top: 9.w, bottom: 9.w),
          decoration: BoxDecoration(
              color: ColorUtility.colorD0D1E0,
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                chatHistory?.message ?? "",
                style: StyleUtility.quicksandRegularBlackTextStyle
                    .copyWith(fontSize: TextSizeUtility.textSize14.sp),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                //  '8:55',

                CommonMethod.getTime(chatHistory?.datetime ?? ""),
                  style: StyleUtility.mulishRegularBlackTextStyle
                      .copyWith(fontSize: TextSizeUtility.textSize10.sp)),
            ],
          )),
      //
    );
  }
}

class MessageData {
  bool isSender;
  String message;

  MessageData(this.isSender, this.message);
}
