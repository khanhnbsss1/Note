import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import '../config/app_config.dart';
import '../main.dart';
import '../notification/notification_service.dart';
import '../service/local_database/shared_pref.dart';
import '../style/styles.dart';
import '../util/date_utils.dart';
import 'add_edit_note.dart';
import 'list_note.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with TickerProviderStateMixin {
  SharedPreferencesIml sharedPreferencesIml = GetIt.instance.get();
  late ListNote noteDetails;
  late OverlayEntry overlayEntry;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    overlayEntry = OverlayEntry(
      builder: (builder) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: _animation.value,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.shade500,
                      Colors.transparent,
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.center,
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Delete this item ?',
                      style: AppTextStyle.heading5.copyWith(
                        color: Colors.tealAccent,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    noteDetails = sharedPreferencesIml.listNote ?? ListNote(list: []);
    super.initState();
  }

  void insertOverLay() {
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay != null && !overlayEntry.mounted) {
      overlay.insert(overlayEntry);
      _controller.forward();
    }
  }

  void removeOverLay() {
    if (overlayEntry.mounted) {
      _controller.reverse().whenComplete(() {
        overlayEntry.remove();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            shrinkWrap: true,
            slivers: [
              buildAppBar(),
              buildContent(),
            ],
            physics: BouncingScrollPhysics(),
          ),
        ],
      ),
      floatingActionButton: buildButton(),
    );
  }

  Widget buildAppBar() {
    return SliverAppBar(
        automaticallyImplyLeading: true,
        pinned: false,
        stretch: false,
        floating: true,
        onStretchTrigger: () async {
          print('stretching');
        },
        expandedHeight: 150,
        stretchTriggerOffset: 150,
        forceElevated: true,
        backgroundColor: Colors.teal,
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: [
            StretchMode.fadeTitle,
          ],
          title: Text('All notes', style: AppTextStyle.commonText.copyWith(
            color: Colors.white,
          ),),
          centerTitle: true,
          collapseMode: CollapseMode.parallax,
          background: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.teal.shade800,
                Colors.transparent,
              ], begin: Alignment.bottomCenter, end: Alignment.center),
            ),
            position: DecorationPosition.foreground,
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPtQGhl1cdv9aZsiq_4RlmRaSiyxC-VSeLVw&s',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
  }

  Widget buildContent() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Stack(
            children: [
              (noteDetails.list != null) ? Padding(
                padding: EdgeInsets.only(bottom: 8.h, left: 8.w, right: 8.w, top: 8.h),
                child: LongPressDraggable(
                  onDragEnd: (_) {
                    removeOverLay();
                    if (overlayEntry.mounted) {
                      _deleteItem(index);
                    }
                  },
                  onDragUpdate: (detail) {
                    if (detail.globalPosition.dx >
                        MediaQuery.of(context).size.width * 3 / 4) {
                      insertOverLay();
                    }
                    if (detail.globalPosition.dx <
                        MediaQuery.of(context).size.width * 1 / 2) {
                      removeOverLay();
                    }
                  },
                  childWhenDragging: buildItem(note: noteDetails.list![index], index: index,),
                  feedback: buildItem(note: noteDetails.list![index], index: index, onDrag: true),
                  child: Hero(
                    tag: noteDetails.list![index].title ?? UniqueKey(),
                    child: buildItem(note: noteDetails.list![index],index: index),
                  ),
                ),
              )  : SizedBox(),
            ],
          );
        },
        childCount: (noteDetails.list != null) ? noteDetails.list!.length : 1,
      ),
    );
  }

  Widget buildButton() {
    return FloatingActionButton(
      backgroundColor: Colors.teal.shade500,
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => AddEditNote(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
          ),
        ).then((value) {
          if (value is NoteDetail) {
            setState(() {
              noteDetails.list!.insert(0, value);
            });
            sharedPreferencesIml.saveNote(noteDetails);
          }
        });
      },
      child: Icon(Icons.add),
    );
  }

  Widget buildItem({
    required NoteDetail note,
    required int index,
    bool? onDrag,
  }) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          NotificationService.showInstanceNotification(index, note.title??"_", note.content??"_", note.time!);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: onDrag??false ? 0.6 : 0.2),
                blurRadius: 5,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    note.title ?? "_",
                    style: AppTextStyle.heading5,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    note.content ?? "_",
                    style: AppTextStyle.commonText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        activeColor: Colors.teal,
                        value: note.done,
                        onChanged: (value) async {
                          setState(() {
                            note.done = value;
                          });
                          notes?.list?.replaceRange(index, index + 1, [
                            notes!.list![index].copyWith(
                              done: value,
                            ),
                          ]);
                          sharedPreferencesIml.saveNote(notes!);
                        },
                      ),
                      Text(
                        'Done',
                        style: AppTextStyle.commonText.copyWith(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset('assets/icon/ic_clock.svg'),
                      SizedBox(width: 8.w,),
                      Text(
                        DateUtilsFormat.toDateAPIString(
                          note.time ?? DateTime.now(),
                          format: AppConfigs.dateTimeDisplayFormat,
                        ),
                        style: AppTextStyle.commonText.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  borderRadius: BorderRadius.circular(32),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => AddEditNote(note: note,),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    ).then((value) {
                      if (value is NoteDetail) {
                        setState(() {
                          noteDetails.list!.replaceRange(index, index + 1, [value]);
                        });
                        sharedPreferencesIml.saveNote(noteDetails);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.edit_note_sharp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _deleteItem(int index) {
    noteDetails.list!.removeAt(index);
    sharedPreferencesIml.saveNote(noteDetails);
    setState(() {

    });
  }
}
