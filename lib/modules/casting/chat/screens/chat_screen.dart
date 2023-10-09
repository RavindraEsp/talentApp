import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  TextEditingController textEditingController = TextEditingController();
  late String senderMessage, receiverMessage;
  ScrollController scrollController = ScrollController();

  Future<void> scrollAnimation() async {
    return await Future.delayed(
        const Duration(milliseconds: 100),
        () => scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear));
  }

  List<MessageData> messageList = [
    MessageData(true, "Hello 1"),
    MessageData(true, "Hello How are You "),
    MessageData(false, "I am fine.Thank you"),
    MessageData(true, "Ok Good"),
  ];

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
                gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: ColorUtility.castHeaderGradientColor)),
            child: SafeArea(
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const BackButton(
                          color: Colors.white,
                        ),
                        Text(
                          "Nichaela Cohoen",
                          overflow: TextOverflow.ellipsis,
                          style: StyleUtility.kantumruyProSMedium18TextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize18.sp),
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
              child: ChatListView(
            scrollController: scrollController,
            messageList: messageList,
          )),
          Container(
            height: 50,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: ColorUtility.colorWhite,
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 6,
                    style: StyleUtility.inputTextStyle
                        .copyWith(fontSize: TextSizeUtility.textSize14.sp),
                    decoration: InputDecoration(
                      hintText: context.loc.hintSentAMessage,
                      hintStyle: StyleUtility.hintTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize14.sp),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Center(
                    child: SizedBox(
                      width: 21.w,
                      child: Image.asset(ImageUtility.cameraIcon),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Center(
                    child: SizedBox(
                      width: 13.w,
                      child: Image.asset(ImageUtility.micIcon),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      messageList
                          .add(MessageData(true, textEditingController.text));
                      textEditingController.clear();
                      scrollAnimation();
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: ColorUtility.color5457BE,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.r))),
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 5.sp, bottom: 5.sp, left: 10, right: 10),
                          child: Image.asset(ImageUtility.sendMsgIcon))),
                ),

                //
                // Container(
                //   margin: const EdgeInsets.only(
                //       left: 8.0, right: 8.0, bottom: 11.0),
                //   child: Container(
                //     color: Colors.grey,
                //     child: Padding(
                //       padding: const EdgeInsets.only(bottom: 5.0),
                //       child: GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             messageList.add(
                //                 MessageData(true, textEditingController.text));
                //             textEditingController.clear();
                //             scrollAnimation();
                //           });
                //         },
                //         onLongPress: () {
                //           setState(() {
                //             messageList.add(
                //                 MessageData(false, textEditingController.text));
                //             textEditingController.clear();
                //             scrollAnimation();
                //           });
                //         },
                //         child: const Icon(
                //           Icons.send,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatListView extends StatelessWidget {
  List<MessageData> messageList;

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
      itemCount: messageList.length,
      itemBuilder: (context, index) => (messageList[index].isSender)
          ? SenderRowView(senderMessage: messageList[index].message)
          : ReceiverRowView(receiverMessage: messageList[index].message),
    );
  }
}

class ReceiverRowView extends StatelessWidget {
  const ReceiverRowView({Key? key, required this.receiverMessage})
      : super(key: key);

  final String receiverMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 70.w, left: 5.w, top: 8.w, bottom: 2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 40.w,
            height: 40.w,
            child: Image.asset(ImageUtility.dummyProfileImage),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      receiverMessage,
                      style: StyleUtility.quicksandRegularBlackTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize14.sp),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text('8:55',
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
  const SenderRowView({Key? key, required this.senderMessage})
      : super(key: key);

  final String senderMessage;

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
                senderMessage,
                style: StyleUtility.quicksandRegularBlackTextStyle
                    .copyWith(fontSize: TextSizeUtility.textSize14.sp),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text('8:55',
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
