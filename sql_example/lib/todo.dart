class Todo {
  String? title; //제목
  String? content; //내용
  int? active; //완료여부
  int? id; //순번

  Todo({this.title, this.content, this.active, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'content' : content,
      'active' : active,
    };
  }
}