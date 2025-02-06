import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/add_edit_node/binding/add_edit_node_binding.dart';
import '../pages/add_edit_node/view/add_edit_note.dart';
import '../pages/calendar/binding/calender_binding.dart';
import '../pages/calendar/view/calendar.dart';
import '../pages/list_notes/binding/list_notes_binding.dart';
import '../pages/list_notes/view/list_notes.dart';
import '../pages/profile/binding/profile_binding.dart';
import '../pages/profile/view/profile_page.dart';

class AppRoute {
  static final routes = [
    GetPage(
        name: '/addEditNote',
        page: () => AddEditNote(),
        binding: AddEditNodeBinding()),
    GetPage(
        name: '/calendarPage',
        page: () => CalendarPage(),
        binding: CalenderBinding()),
    GetPage(
        name: '/listPage',
        page: () => ListNotes(),
        binding: ListNotesBinding()),
    GetPage(
        name: '/profile',
        page: () => ProfilePage(),
        binding: ProfileBinding())
  ];
}