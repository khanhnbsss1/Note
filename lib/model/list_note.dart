import '../pages/calendar/model/event.dart';

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
  PriorityType? priority;
  NotificationStatus? notificationStatus;

  NoteDetail({this.title, this.time, this.content, this.done, this.priority, this.notificationStatus,}){
    done ??= false;
    priority ??= PriorityType.high;
    notificationStatus ??= NotificationStatus.disable;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'time': time?.toIso8601String(),
      'content': content,
      'done': done,
      'priority': priority?.label,
      'notification_status': notificationStatus?.label,
    };
  }

  factory NoteDetail.fromJson(Map<String, dynamic> json) {
    return NoteDetail(
      title: json['title'] as String?,
      time: json['time'] != null ? DateTime.parse(json['time']) : null,
      content: json['content'] as String?,
      done: json['done'] as bool?,
      priority: json['priority'] == 'High' ? PriorityType.high : json['priority'] == 'Medium' ? PriorityType.medium : PriorityType.low,
      notificationStatus: json['notification_status'] == 'Enable' ? NotificationStatus.enable : NotificationStatus.disable,
    );
  }

  NoteDetail copyWith({
    String? title,
    DateTime? time,
    String? content,
    bool? done,
    PriorityType? priority,
    NotificationStatus? notificationStatus,
  }) {
    final NoteDetail note = NoteDetail(
      title: title ?? this.title,
      time: time ?? this.time,
      content: content ?? this.content,
      done: done ?? this.done,
      priority: priority ?? this.priority,
      notificationStatus: notificationStatus ?? this.notificationStatus,
    );
    return note;
  }
}

enum NotificationStatus {
  enable('Enable'),
  disable('Disable');

  final String? label;

  const NotificationStatus(this.label);
}
