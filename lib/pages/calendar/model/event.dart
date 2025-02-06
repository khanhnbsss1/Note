class Event {
  final DateTime? date;
  final String? title;
  final Priority? priority;

  const Event({
    this.date,
    this.title,
    this.priority,
  });
}

enum Priority {
  high('High'),
  medium('Medium'),
  low('Low');

  final String label;

  const Priority(this.label);
}

final events = {
    Event(date: DateTime(2025, 2, 1, 8), title: 'Meeting', priority: Priority.high),
    Event(date: DateTime(2025, 2, 2), title: 'Conference', priority: Priority.medium),
    Event(date: DateTime(2025, 2, 3), title: 'Workshop', priority: Priority.low),
    Event(date: DateTime(2025, 2, 4), title: 'Training', priority: Priority.high),
    Event(date: DateTime(2025, 2, 5), title: 'Webinar', priority: Priority.medium),
    Event(date: DateTime(2025, 2, 6), title: 'Team Building', priority: Priority.low),
    Event(date: DateTime(2025, 2, 7), title: 'Client Meeting', priority: Priority.medium),
    Event(date: DateTime(2025, 2, 10), title: 'Conference', priority: Priority.high),
    Event(date: DateTime(2025, 2, 10), title: 'Workshop', priority: Priority.low),
    Event(date: DateTime(2025, 2, 12), title: 'Seminar', priority: Priority.high),
    Event(date: DateTime(2025, 2, 15), title: 'Conference', priority: Priority.medium),
    Event(date: DateTime(2025, 2, 15), title: 'Workshop', priority: Priority.low),
    Event(date: DateTime(2025, 2, 17), title: 'Sales Meeting', priority: Priority.medium),
    Event(date: DateTime(2025, 2, 18), title: 'Webinar', priority: Priority.high),
    Event(date: DateTime(2025, 2, 20), title: 'Workshop', priority: Priority.low),
    Event(date: DateTime(2025, 2, 22), title: 'Product Launch', priority: Priority.high),
    Event(date: DateTime(2025, 2, 25), title: 'Networking Event', priority: Priority.medium),
    Event(date: DateTime(2025, 2, 27), title: 'Hackathon', priority: Priority.low),
    Event(date: DateTime(2025, 2, 28), title: 'Closing Ceremony', priority: Priority.high),
};
