class ChatUserListResponseModel {
  List<UserList>? userList;
  List<Users>? users;

  ChatUserListResponseModel({this.userList, this.users});

  ChatUserListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['userList'] != null) {
      userList = <UserList>[];
      json['userList'].forEach((v) {
        userList!.add(new UserList.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userList != null) {
      data['userList'] = this.userList!.map((v) => v.toJson()).toList();
    }
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserList {
  int? id;
  int? groupId;
  int? senderId;
  int? apponentId;
  String? roomId;
  int? receiverId;
  String? datetime;
  int? isRead;
  String? message;
  String? userName;
  String? userProfile;
  String? msgCount;

  UserList(
      {this.id,
        this.groupId,
        this.senderId,
        this.apponentId,
        this.roomId,
        this.receiverId,
        this.datetime,
        this.isRead,
        this.message,
        this.userName,
        this.userProfile,
        this.msgCount});

  UserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['groupId'];
    senderId = json['senderId'];
    apponentId = json['apponentId'];
    roomId = json['roomId'];
    receiverId = json['receiverId'];
    datetime = json['datetime'];
    isRead = json['isRead'];
    message = json['message'];
    userName = json['userName'];
    userProfile = json['userProfile'];
    msgCount = json['msgCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groupId'] = this.groupId;
    data['senderId'] = this.senderId;
    data['apponentId'] = this.apponentId;
    data['roomId'] = this.roomId;
    data['receiverId'] = this.receiverId;
    data['datetime'] = this.datetime;
    data['isRead'] = this.isRead;
    data['message'] = this.message;
    data['userName'] = this.userName;
    data['userProfile'] = this.userProfile;
    data['msgCount'] = this.msgCount;
    return data;
  }
}

class Users {
  String? id;

  Users({this.id});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
