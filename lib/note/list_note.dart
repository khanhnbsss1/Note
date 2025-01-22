class ListNote {
  List<NoteDetail>? list;

  ListNote({this.list});

  Map<String, dynamic> toJson() {
    return {
      'list': list?.map((note) => note.toJson()).toList(),
    };
  }

  factory ListNote.fromJson(Map<String, dynamic> json) {
    return ListNote(
      list: (json['list'] as List<dynamic>?)
          ?.map((note) => NoteDetail.fromJson(note))
          .toList(),
    );
  }
}

class NoteDetail {
  String? title;
  DateTime? time;
  String? content;
  bool? done;

  NoteDetail({this.title, this.time, this.content, this.done}){
    done ??= false;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'time': time?.toIso8601String(),
      'content': content,
      'done': done,
    };
  }

  factory NoteDetail.fromJson(Map<String, dynamic> json) {
    return NoteDetail(
      title: json['title'] as String?,
      time: json['time'] != null ? DateTime.parse(json['time']) : null,
      content: json['content'] as String?,
      done: json['done'] as bool?,
    );
  }

  NoteDetail copyWith({
    String? title,
    DateTime? time,
    String? content,
    bool? done,
  }) {
    final NoteDetail note =  NoteDetail(
      title: title ?? this.title,
      time: time ?? this.time,
      content: content ?? this.content,
      done: done ?? this.done,
    );
    return note;
  }
}
