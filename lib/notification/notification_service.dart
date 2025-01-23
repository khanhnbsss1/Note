import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import '../service/local_database/shared_pref.dart';

import 'package:timezone/timezone.dart' as tz;


class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher');

    final DarwinInitializationSettings iosInitializationSettings =
    DarwinInitializationSettings(
      notificationCategories: [
        DarwinNotificationCategory(
          'demoCategory',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('id_1', 'Action 1'),
            DarwinNotificationAction.plain(
              'id_2',
              'Action 2',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.destructive,
              },
            ),
            DarwinNotificationAction.plain(
              'id_3',
              'Action 3',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
            ),
          ],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
          },
        ),
      ],
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onBackgroundAction,
      onDidReceiveBackgroundNotificationResponse: _onBackgroundAction,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showZonedNotification(int id,
      String title,
      String content,
      DateTime time,) async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your channel id',
      title,
      channelDescription: 'Android notificaiton',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      actions: [
        AndroidNotificationAction(
          'Finished',
          'Finished',
          showsUserInterface: true,
        ),
        AndroidNotificationAction(
          'Unfinished',
          'Unfinished',
          showsUserInterface: true,
        ),
      ],
    );

    DarwinNotificationDetails iosNotificationDetail = DarwinNotificationDetails(
    );

    tz.TZDateTime tzDateTime = tz.TZDateTime.from(time, tz.local);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetail,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      content,
      tzDateTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      payload: '{"id": $id, "type": "instance", "otherInfo": "some value"}',
    );
  }
}

SharedPreferencesIml sharedPreferencesIml = GetIt.instance.get();

final notes = sharedPreferencesIml.listNote;

@pragma('vm:entry-point')
Future<void> _onBackgroundAction(NotificationResponse response) async {
  print('Action ID: ${response.actionId}');

  if (response.payload != null) {
    final Map<String, dynamic> payloadData = jsonDecode(response.payload!);
    print('Parsed Payload: $payloadData');

    if (response.actionId == 'Finished') {
      notes?.list?.replaceRange(response.id!, response.id! + 1, [
        notes!.list![response.id!].copyWith(
          done: true,
        ),
      ]);
      sharedPreferencesIml.saveNote(notes!);
    } else if (response.actionId == 'Unfinished') {
      notes?.list?.replaceRange(response.id!, response.id! + 1, [
        notes!.list![response.id!].copyWith(
          done: false,
        ),
      ]);
      sharedPreferencesIml.saveNote(notes!);
    }
  } else {
    print('No payload provided');
  }
}

