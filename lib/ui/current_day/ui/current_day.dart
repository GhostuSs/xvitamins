import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:xvitamins/data/GDays/gdays.dart';
import 'package:xvitamins/data/goalday/goalday.dart';
import 'package:xvitamins/ui/current_day/uikit/note_widget.dart';
import 'package:xvitamins/ui/note/ui/note_screen.dart';
import 'package:xvitamins/uikit/dialog.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class CurrentDayScreen extends StatefulWidget {
  final DateTime selected;
  final GoalDay? day;
  const CurrentDayScreen({
    Key? key,
    required this.selected,
    this.day,
  }) : super(key: key);

  @override
  State<CurrentDayScreen> createState() => _CurrentDayScreenState();
}

class _CurrentDayScreenState extends State<CurrentDayScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.day?.day);
    print(widget.day?.note);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          parseDate(widget.selected),
          style: AppTypography.semibold.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20.w,
            color: AppColors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 8.h,
                ),
                child: Text(
                  (widget.selected.day == DateTime.now().day &&
                          widget.selected.month == DateTime.now().month)
                      ? 'Goal for today'
                      : 'Goal',
                  style: AppTypography.semibold.copyWith(
                    fontSize: 24.w,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 145.w,
                    height: 145.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFD1FFFC),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 180.w,
                    height: 180.w,
                    child: DChartPie(
                      data: [
                        {'domain': 'Flutter', 'measure': 28},
                        {'domain': 'React Native', 'measure': 27},
                        {'domain': 'Ionic', 'measure': 20},
                        {'domain': 'Cordova', 'measure': 15},
                      ],
                      labelPosition: PieLabelPosition.inside,
                      showLabelLine: false,
                      labelPadding: 0,
                      labelColor: Colors.transparent,
                      fillColor: (pieData, index) =>
                          colorSelector(index: index),
                      donutWidth: 20,
                    ),
                  ),
                  Text(
                    '0/400',
                    style: AppTypography.bold.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.w,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              if (widget.day?.note != '' && widget.day?.note != null)
                NoteWidget(
                  note: widget.day?.note! ?? '',
                ),
              const Spacer(),
              MainButton(
                onTap: () {},
                label: 'Add Fruit and Veg',
                mainType: true,
              ),
              SizedBox(
                height: 10.h,
              ),
              widget.day?.note == '' || widget.day?.note == null
                  ? MainButton(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NoteScreen(
                            note: widget.day?.note ?? '',
                            date: widget.selected,
                          ),
                        ),
                      ),
                      label: 'Add Note',
                      mainType: true,
                    )
                  : Row(
                      children: [
                        MainButton(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NoteScreen(
                                note: widget.day?.note ?? '',
                                date: widget.selected,
                                autofocus: true,
                              ),
                            ),
                          ),
                          label: 'Edit Note',
                          width: 155.w,
                          mainType: true,
                        ),
                        const Spacer(),
                        MainButton(
                          onTap: () async => showDialog(
                            context: context,
                            builder: (_) =>Dialog(
                              clipBehavior: Clip.hardEdge,
                              child: CustomDialog(
                                  label:
                                  'Do you really want to delete this note?',
                                  emojy: '🤨',
                                  actions: const ['Yes', 'No'],
                                  onYes: () async => await deleteNote()),
                            ),
                          ),
                          label: 'Delete Note',
                          width: 155.w,
                          customColor: AppColors.red,
                          mainType: true,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  ///Convert datetime to day+month
  String parseDate(DateTime date) {
    String returnableDate = "${date.day} ";
    switch (date.month) {
      case 1:
        {
          returnableDate += 'January';
        }
        break;
      case 2:
        {
          returnableDate += 'February';
        }
        break;
      case 3:
        {
          returnableDate += 'March';
        }
        break;
      case 4:
        {
          returnableDate += 'April';
        }
        break;
      case 5:
        {
          returnableDate += 'May';
        }
        break;
      case 6:
        {
          returnableDate += 'June';
        }
        break;
      case 7:
        {
          returnableDate += 'July';
        }
        break;
      case 8:
        {
          returnableDate += 'August';
        }
        break;
      case 9:
        {
          returnableDate += 'September';
        }
        break;
      case 10:
        {
          returnableDate += 'October';
        }
        break;
      case 11:
        {
          returnableDate += 'November';
        }
        break;
      case 12:
        {
          returnableDate += 'December';
        }
    }
    return returnableDate;
  }

  Color colorSelector({index}) {
    Color color = AppColors.gray3;
    switch (index) {
      case 0:
        color = AppColors.blue;
        break;
      case 1:
        color = AppColors.green;
        break;
      case 2:
        color = AppColors.yellow;
        break;
      case 3:
        color = AppColors.purple;
        break;
      case 4:
        color = AppColors.orange;
        break;
      case 5:
        color = AppColors.red;
        break;
      case 6:
        color = AppColors.pink;
        break;
      case 7:
        color = AppColors.darkBlue;
        break;
      case 8:
        color = AppColors.turquoise;
        break;
      case 9:
        color = AppColors.lightGreen;
    }
    ;
    return color;
  }

  Future<void> deleteNote() async {
    if (widget.day?.note != '') {
      print('s');
      final boxs = Hive.box<GDays>('goals');
      final value = boxs.values.first.days
          ?.firstWhere((element) => element.note == widget.day?.note);
      boxs.values.first.days?.remove(value);
      value?.note = '';
      boxs.values.first.days?.add(value!);
      final box = boxs.values.first;
      await boxs.clear();
      await boxs.put('goals', box);
    } else {
      final box = Hive.box<GDays>('goals');
      box.values.first.days?.add(GoalDay(note: '', day: widget.selected));
      await box.put('goals', box.values.first);
    }
    setState(() {});
  }
}
