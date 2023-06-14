class ChatModel {
  final String msg;
  final bool isUser;
  final String msgType;

  ChatModel({required this.msg,required this.isUser,required this.msgType});
  factory ChatModel.fromJson(Map<String,dynamic> json)=>ChatModel(msg: json['msg'], isUser: json['isUser'], msgType: json['msgType']);
}