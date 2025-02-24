import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:note/config/app_color.dart';
import 'package:note/pages/add_edit_node/binding/add_edit_node_binding.dart';
import 'package:note/pages/list_notes/controller/list_notes_controller.dart';

import '../../../../config/app_config.dart';
import '../../../../style/styles.dart';
import '../../../../util/date_utils.dart';
import '../../../generated/l10n.dart';
import '../../../model/list_note.dart';
import '../../add_edit_node/view/add_edit_note.dart';

class ListNotePage extends StatefulWidget {
  const ListNotePage({super.key});

  @override
  State<ListNotePage> createState() => _ListNotePageState();
}

class _ListNotePageState extends State<ListNotePage> {
  final controller = Get.find<ListNotesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          // buildAppBar(),
          Obx(
                () => SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: DropdownMenu<TypeList>(
                    initialSelection: controller.listType.value,
                    dropdownMenuEntries: TypeList.values
                        .map((e) => DropdownMenuEntry<TypeList>(
                        value: e, label: e.label!))
                        .toList(),
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor().textColor,
                            )
                        )
                    ),
                    onSelected: (value) {
                      if (value != null) {
                        controller.changeTypeList(value);
                      }
                    },
                    label: Text(
                      S.current.ordered_by,
                      style: AppTextStyle.heading5.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColor().textColor,
                      ),
                    ),
                    textStyle: AppTextStyle.heading5.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColor().textColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Obx(
                () => buildContent(),
          )
        ],
        physics: BouncingScrollPhysics(),
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
      backgroundColor: AppColor().textColor,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [
          StretchMode.fadeTitle,
        ],
        title: Text(
          S.current.all_notes,
          style: AppTextStyle.commonText.copyWith(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        collapseMode: CollapseMode.parallax,
        background: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColor().textColor,
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
              (controller.shownNotes.value.list != null)
                  ? Padding(
                padding: EdgeInsets.only(
                    bottom: 8.h, left: 8.w, right: 8.w, top: 8.h),
                child: LongPressDraggable(
                  childWhenDragging: buildItem(
                    note: controller.shownNotes.value.list![index],
                    index: index,
                  ),
                  feedback: buildItem(
                      note: controller.shownNotes.value.list![index],
                      index: index,
                      onDrag: true),
                  child: Hero(
                    tag: controller.shownNotes.value.list![index].time ??
                        DateTime.now(),
                    child: buildItem(
                        note: controller.shownNotes.value.list![index],
                        index: index),
                  ),
                ),
              )
                  : SizedBox(),
            ],
          );
        },
        childCount: (controller.shownNotes.value.list != null)
            ? controller.shownNotes.value.list!.length
            : 1,
      ),
    );
  }

  Widget buildButton() {
    return FloatingActionButton(
      backgroundColor: AppColor().primaryDark,
      onPressed: () {
        Get.to(() => AddEditNote(),
            binding: AddEditNodeBinding(), transition: Transition.zoom)!
            .then((value) {
          if (value is NoteDetail) {
            controller.addNote(value);
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
          controller.notify(index, note);
          // NotificationService.showZonedNotification(
          //     index, note.title ?? "_", note.content ?? "_", note.time!);
          // FlutterBackgroundService().invoke(ServiceKey.pushNotification, note.toJson());
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColor().primaryLight,
            border: Border.all(
              color: AppColor().textColor,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color:
                Colors.black.withValues(alpha: onDrag ?? false ? 0.6 : 0.2),
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
                        activeColor: AppColor().accentBlue,
                        value: note.done,
                        onChanged: (value) async {
                          controller.onNoteDone(index, value);
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
                      SizedBox(
                        width: 8.w,
                      ),
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        controller.notify(index, note);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        note.notificationStatus == NotificationStatus.enable
                            ? Icon(Icons.notifications_active)
                            : Icon(Icons.notifications_none),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        Get.to(
                                () => AddEditNote(
                              note: note,
                            ),
                            binding: AddEditNodeBinding(),
                            transition: Transition.zoom)!
                            .then((value) {
                          if (value is NoteDetail) {
                            controller.editNote(index, value);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.edit_note_sharp),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        controller.deleteItem(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.remove_circle_outline_sharp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
