// Json Api Model

/// id : 52
/// projectName : "prerna"
/// chatId : "56478093081"
/// sendId : "22275"
/// deleteId : "000222"
/// time : "00:78"
/// message : "parth is my husband"

class Jsonmodel {
  Jsonmodel({
    num? id,
    String? projectName,
    String? chatId,
    String? sendId,
    String? deleteId,
    String? time,
    String? message,
  }) {
    _id = id;
    _projectName = projectName;
    _chatId = chatId;
    _sendId = sendId;
    _deleteId = deleteId;
    _time = time;
    _message = message;
  }

  Jsonmodel.fromJson(dynamic json) {
    _id = json['id'];
    _projectName = json['projectName'];
    _chatId = json['chatId'];
    _sendId = json['sendId'];
    _deleteId = json['deleteId'];
    _time = json['time'];
    _message = json['message'];
  }

  num? _id;
  String? _projectName;
  String? _chatId;
  String? _sendId;
  String? _deleteId;
  String? _time;
  String? _message;

  Jsonmodel copyWith({
    num? id,
    String? projectName,
    String? chatId,
    String? sendId,
    String? deleteId,
    String? time,
    String? message,
  }) =>
      Jsonmodel(
        id: id ?? _id,
        projectName: projectName ?? _projectName,
        chatId: chatId ?? _chatId,
        sendId: sendId ?? _sendId,
        deleteId: deleteId ?? _deleteId,
        time: time ?? _time,
        message: message ?? _message,
      );

  num? get id => _id;

  String? get projectName => _projectName;

  String? get chatId => _chatId;

  String? get sendId => _sendId;

  String? get deleteId => _deleteId;

  String? get time => _time;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['projectName'] = _projectName;
    map['chatId'] = _chatId;
    map['sendId'] = _sendId;
    map['deleteId'] = _deleteId;
    map['time'] = _time;
    map['message'] = _message;
    return map;
  }
}
