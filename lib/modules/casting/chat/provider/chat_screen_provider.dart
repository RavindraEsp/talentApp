import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/chat/model/chat_msg_response_model.dart';
import 'package:talent_app/utilities/shared_preference.dart';

class ChatScreenProvider extends ChangeNotifier{

  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> scrollAnimation() async {
    return await Future.delayed(
        const Duration(milliseconds: 100),
            () => scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear));
  }


  Future<void> startScrollAnimation() async {
    return await Future.delayed(
        const Duration(milliseconds: 100),
            () => scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 1),
            curve: Curves.linear));
  }


  IO.Socket? socket;

  late int userId;


  ChatMsgResponseModel? chatMsgResponseModel;


  bool loading = true;

  late final int receiverId;
  late final String roomId;


  connectAndListenChatSocket({required int receiverId,required String roomId}) {

    this.receiverId = receiverId;
    this.roomId = roomId;

    userId = Preference().getUserId();

    try {
      // socket = IO.io(
      //     'https://fusiongrid.dev:8010',
      //     IO.OptionBuilder()
      //         .setTransports(['websocket'])
      //         .enableAutoConnect()
      //         .enableForceNewConnection()
      //         .enableReconnection()
      //         .build());
      //
      // socket?.onConnect((_) {
      //   AppLogger.logD('connect');
      //   socket?.emit('msg', 'test');
      // });
      // socket?.on('event', (data) => AppLogger.logD(data));
      // socket?.onDisconnect((_) => AppLogger.logD('disconnect'));
      // socket?.on('fromServer', (_) => AppLogger.logD(_));

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
          "receiverId": receiverId,
          "senderId": userId,
          "roomId": roomId,

          /// pass caster id
        };

        AppLogger.logD(data);

        socket?.emit('joinSingleRoom', jsonEncode(data));

        AppLogger.logD("join room call");
      });

      socket?.on("roomUsers", (data) {
        // get all msg

        AppLogger.logD("on roomUsers =>");
        chatMsgResponseModel = ChatMsgResponseModel.fromJson(data);

        loading = false;

        startScrollAnimation();
        AppLogger.logD(
            "chat msg length   ${chatMsgResponseModel?.chatHistory?.length}");

        final Map mapData = data as Map;


        AppLogger.logD("roomUsers data is in start $mapData");

       notifyListeners();

      });


      socket?.on("message", (data) {
        AppLogger.logD("on message =>");
        chatMsgResponseModel?.chatHistory?.add(ChatHistory(
            id: data["text"]["id"],
            auditionId: data["text"]["auditionId"],
            senderId: data["text"]["senderId"],
            receiverId: data["text"]["receiverId"],
            message: data["text"]["message"],
            isRead: data["text"]["isRead"],
            datetime: data["text"]["datetime"]));

        scrollAnimation();

        final Map mapData = data as Map;


        AppLogger.logD("message is ${data["text"]["message"]}");
        AppLogger.logD("message data is  ${mapData}");

        notifyListeners();
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

  sendMessage(String msg) {
    var data = jsonEncode({
      "senderId": userId,
      "receiverId": receiverId,
      "message": msg
    });
    AppLogger.logD("chatSingleMessage sent $data");
    socket?.emit(
        'chatSingleMessage',
        data);

  }


}