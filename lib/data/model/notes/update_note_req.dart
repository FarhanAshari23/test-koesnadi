class UpdateNoteReq {
  final String title;
  final String content;
  String? code;

  UpdateNoteReq({
    required this.title,
    required this.content,
  });
}
