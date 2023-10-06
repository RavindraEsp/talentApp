import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';



class MyChatApp extends StatefulWidget {
  const MyChatApp({Key? key}) : super(key: key);

  @override
  MyChatAppState createState() => MyChatAppState();
}

class MyChatAppState extends State<MyChatApp> {
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
    MessageData(false, "Hello fd fd d dfd d"),
    MessageData(true, "Hello fdf df dfdf df "),
    MessageData(true, "Hello dfd dfdf dfdfd"),
    MessageData(false, "Hellod fdf dfd df f last"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                          "Chat",
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
            // height: 50,
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xFF333D56),
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 12.0),
                  child: Transform.rotate(
                      angle: 45,
                      child: const Icon(
                        Icons.attach_file_sharp,
                        color: Colors.white,
                      )),
                ),
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 6,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 11.0),
                  child: Transform.rotate(
                    angle: -3.14 / 5,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            messageList.add(
                                MessageData(true, textEditingController.text));
                            textEditingController.clear();
                            scrollAnimation();
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            messageList.add(
                                MessageData(false, textEditingController.text));
                            textEditingController.clear();
                            scrollAnimation();
                          });
                        },
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageData {
  bool isSender;
  String message;

  MessageData(this.isSender, this.message);
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Flexible(
          flex: 13,
          fit: FlexFit.tight,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, top: 1.0, bottom: 9.0),
            child: CircleAvatar(
              backgroundColor: Color(0xFF90C953),
              child: Text('X',
                  style: TextStyle(
                    color: Colors.black,
                  )),
            ),
          ),
        ),
        Flexible(
          flex: 72,
          fit: FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 5.0, right: 8.0, top: 8.0, bottom: 2.0),
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 9.0, bottom: 9.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xFF87D4E6),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text(
                      receiverMessage,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                child: const Text(
                  '8:55 AM, Today',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 7.0,
                  ),
                ),
              ),
            ],
          ),
          //
        ),
        Flexible(
          flex: 15,
          fit: FlexFit.tight,
          child: Container(
            width: 50.0,
          ),
        ),
      ],
    );
  }
}

class SenderRowView extends StatelessWidget {
  const SenderRowView({Key? key, required this.senderMessage})
      : super(key: key);

  final String senderMessage;

  @override
  Widget build(BuildContext context) {
    return


      Container(
        alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(
          left: 50.0, right: 5.0, top: 8.0, bottom: 2.0),
      child: Container(

        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 9.0, bottom: 9.0),
        decoration: const BoxDecoration(
            color: ColorUtility.colorD0D1E0,
           ),
        child:

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              senderMessage,
              textAlign: TextAlign.left,
            ),
            Container(
              child: const Text(
                '8:55',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 7.0,
                ),
              ),
            ),
          ],
        )

      ),
      //
    );


  }
}
