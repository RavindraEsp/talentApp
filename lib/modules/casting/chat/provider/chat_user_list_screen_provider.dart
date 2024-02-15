import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/chat/model/chat_msg_response_model.dart';
import 'package:talent_app/modules/casting/chat/model/chat_user_list_resposne_model.dart';
import 'package:talent_app/utilities/shared_preference.dart';

class ChatUserListScreenProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  IO.Socket? socket;

  bool loading = true;

  ChatUserListResponseModel? chatUserListResponseModel;

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

        notifyListeners();
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
}
