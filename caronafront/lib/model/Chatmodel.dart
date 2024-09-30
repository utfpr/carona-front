class Chat {
  Chat(
      {required this.id,
      required this.msg,
      required this.authorid,
      required this.chatid,
      required this.author,
      this.date=null});
  String msg;
  int id;
  String author;
  int authorid;
  int chatid;
  String? date;
}
