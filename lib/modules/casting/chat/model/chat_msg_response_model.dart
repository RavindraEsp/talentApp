class ChatMsgResponseModel {
  List<ChatHistory>? chatHistory;
  var room;
  List<Users>? users;

  ChatMsgResponseModel({this.chatHistory, this.room, this.users});

  ChatMsgResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['chatHistory'] != null) {
      chatHistory = <ChatHistory>[];
      json['chatHistory'].forEach((v) {
        chatHistory!.add(new ChatHistory.fromJson(v));
      });
    }
    room = json['room'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chatHistory != null) {
      data['chatHistory'] = this.chatHistory!.map((v) => v.toJson()).toList();
    }
    data['room'] = this.room;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatHistory {
  int? id;
  int? auditionId;
  int? senderId;
  int? receiverId;
  String? message;
  int? isRead;
  String? datetime;
  String? profilePic;

  ChatHistory(
      {this.id,
        this.auditionId,
        this.senderId,
        this.receiverId,
        this.message,
        this.isRead,
        this.datetime,
        this.profilePic
      });

  ChatHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    auditionId = json['auditionId'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    message = json['message'];
    isRead = json['isRead'];
    datetime = json['datetime'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['auditionId'] = this.auditionId;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['message'] = this.message;
    data['isRead'] = this.isRead;
    data['datetime'] = this.datetime;
    data['profilePic'] = this.profilePic;
    return data;
  }
}

class Users {
  String? id;
  var room;

  Users({this.id, this.room});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['room'] = this.room;
    return data;
  }
}
