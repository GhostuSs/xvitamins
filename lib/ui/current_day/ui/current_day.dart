import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:xvitamins/data/GDays/gdays.dart';
import 'package:xvitamins/data/food/food_model.dart';
import 'package:xvitamins/data/goalday/goalday.dart';
import 'package:xvitamins/ui/current_day/uikit/note_widget.dart';
import 'package:xvitamins/ui/note/ui/note_screen.dart';
import 'package:xvitamins/uikit/dialog.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

import '../../add_fruit/ui/add_fruit.dart';
import '../../calendar/ui/calendar_screen.dart';

class CurrentDayScreen extends StatefulWidget {
  final DateTime selected;
  // final GoalDay? day;
  const CurrentDayScreen({
    Key? key,
    required this.selected,
    // this.day,
  }) : super(key: key);

  @override
  State<CurrentDayScreen> createState() => _CurrentDayScreenState();
}

class _CurrentDayScreenState extends State<CurrentDayScreen> {
  late List<Map<String, dynamic>> chartData;
  int sum = 0;
  @override
  void initState() {
    setChartData();
    super.initState();
    if (Hive.box<GDays>('goals')
            .values
            .first
            .days
            ?.where((element) => element.day == widget.selected)
            .isNotEmpty ==
        true) {
      if ((Hive.box<GDays>('goals')
              .values
              .first
              .days
              ?.firstWhere((element) => element.day == widget.selected)
              .day
              ?.isBefore(DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day)) ==
          true)&&Hive.box<GDays>('goals')
          .values
          .first
          .days
          ?.firstWhere((element) => element.day == widget.selected)
          .seen!=true) {
        Future.delayed(Duration.zero).then((value) => showDialog(
              context: context,
              builder: (_) => Dialog(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: CustomDialog(
                  label: 'Goal not met',
                  emojy: sum < Hive.box<int>('dailygoal').values.first &&
                          Hive.box<GDays>('goals')
                                  .values
                                  .first
                                  .days
                                  ?.firstWhere((element) =>
                                      element.day == widget.selected)
                                  .day
                                  ?.isBefore(DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day)) ==
                              true
                      ? 'assets/images/notmet.png'
                      : 'assets/images/met.png',
                  actions: const ['OK'],
                  onYes: () async {
                    final gday = Hive.box<GDays>('goals')
                        .values
                        .first
                        .days
                        ?.firstWhere(
                            (element) => element.day == widget.selected);
                    gday?.seen = true;
                    Hive.box<GDays>('goals').values.first.days?.remove(gday);
                    Hive.box<GDays>('goals').values.first.days?.add(gday!);
                    final newData = Hive.box<GDays>('goals').values.first;
                    // await Hive.box<GDays>('goals').clear();
                    await Hive.box<GDays>('goals').put('goals', newData);
                    Navigator.pop(_);
                  },
                ),
              ),
            ));
      }
    } else {
      if (widget.selected.isBefore(DateUtils.dateOnly(DateTime.now())) ==
          true) {
        Future.delayed(Duration.zero).then((value) => showDialog(
              context: context,
              builder: (_) => Dialog(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: CustomDialog(
                  label: 'Goal not met',
                  emojy: 'assets/images/notmet.png',
                  actions: const ['OK'],
                  onYes: () async {
                    final GoalDay day = GoalDay(seen: true,day: widget.selected);
                    final newData = Hive.box<GDays>('goals').values.first;
                    newData.days?.add(day);
                    await Hive.box<GDays>('goals').put('goals',newData);
                    Navigator.pop(_);
                  },
                ),
              ),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    GoalDay? gday = Hive.box<GDays>('goals')
                .values
                .first
                .days
                ?.where((element) => element.day == widget.selected)
                .isNotEmpty ==
            true
        ? Hive.box<GDays>('goals')
            .values
            .first
            .days
            ?.firstWhere((element) => element.day == widget.selected)
        : GoalDay(day: widget.selected);
    updateChartData();
    return WillPopScope(child: Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: AppColors.gray2,
                width: 0.5.w,
              ))),
      child: Scaffold(
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
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => CalendarScreen(focusOn: widget.selected,))),
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
                      decoration: const BoxDecoration(
                        color: Color(0xFFD1FFFC),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 180.w,
                      height: 180.w,
                      child: DChartPie(
                        data: chartData,
                        animate: false,
                        labelPosition: PieLabelPosition.auto,
                        showLabelLine: false,
                        labelPadding: 0,
                        strokeWidth: 0,
                        labelColor: Colors.transparent,
                        fillColor: (pieData, index) =>
                        sum < Hive.box<int>('dailygoal').values.first &&
                            pieData['domain'] == 'left'
                            ? AppColors.emptyGoals
                            : colorSelector(index: index),
                        donutWidth: 20,
                      ),
                    ),
                    sum < Hive.box<int>('dailygoal').values.first
                        ? widget.selected
                        .isAfter(DateUtils.dateOnly(DateTime.now()))
                        ? Text(
                      '$sum/${Hive.box<int>('dailygoal').values.first}',
                      style: AppTypography.bold.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.w,
                        color: AppColors.black,
                      ),
                    )
                        : Icon(
                      Icons.clear,
                      color: AppColors.red,
                      size: 80.r,
                    )
                        : Icon(
                      Icons.check,
                      color: AppColors.green,
                      size: 80.r,
                    ),
                  ],
                ),
                Container(
                  constraints: BoxConstraints.expand(height: 50.h),
                  child: chartData.length == 1
                      ? Center(
                    child: FoodWidget(
                      data: chartData.first,
                      chartData: chartData,
                      sum: sum,
                      onTap: () {},
                    ),
                  )
                      : ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (final data in chartData)
                        FoodWidget(
                          data: data,
                          chartData: chartData,
                          sum: sum,
                          onTap: () async => data['domain'].contains('left')==false ? showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: CustomDialog(
                                label:
                                'Do you really want to delete this item?',
                                emojy: 'assets/images/reallywant.png',
                                actions: const ['Yes', 'No'],
                                onYes: () async => await delete(
                                    Hive.box<GDays>('goals')
                                        .values
                                        .first
                                        .days!
                                        .firstWhere((element) =>
                                    element.day ==
                                        widget.selected)
                                        .food!
                                        .firstWhere((element) =>
                                    element.name?.trim() ==
                                        data['domain']
                                            .split('   ')
                                            .first
                                            .trim()))
                                    .then((value){
                                  Navigator.pop(_);
                                  setState(() {});
                                }),
                              ),
                            ),
                          ) : null,
                        )
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                if (gday?.note != '' && gday?.note != null)
                  NoteWidget(
                    note: gday?.note! ?? '',
                  ),
                const Spacer(),
                MainButton(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddScreen(
                        day: widget.selected,
                        updateParent: () => setState(() {}),
                      ),
                    ),
                  ),
                  label: chartData.length>1 ? 'Edit Fruit and Veg':'Add Fruit and Veg',
                  mainType: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                gday?.note == '' || gday?.note == null
                    ? MainButton(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NoteScreen(
                        note: gday?.note ?? '',
                        autofocus: true,
                        updateParent: () => setState(() {}),
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
                            note: gday?.note ?? '',
                            updateParent: () => setState(() {}),
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
                        builder: (_) => Dialog(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: CustomDialog(
                              label:
                              'Do you really want to delete this note?',
                              emojy: 'assets/images/reallywant.png',
                              actions: const ['Yes', 'No'],
                              onYes: () async => await deleteNote()
                                  .then((value) => Navigator.pop(_))),
                        ),
                      ).then((value) => setState(() {})),
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
      ),
    ), onWillPop: ()async=>false);
  }

  Future<void> delete(Food data) async {
    Hive.box<GDays>('goals')
        .values
        .first
        .days
        ?.where((element) => element.day == widget.selected)
        .first
        .food
        ?.remove(data);
    final newData = Hive.box<GDays>('goals').values.first;
    await Hive.box<GDays>('goals').clear();
    await Hive.box<GDays>('goals').put('goals', newData);
  }
  void setChartData(){
    if (Hive.box<GDays>('goals').values.first.days?.isNotEmpty == true &&
        Hive.box<GDays>('goals')
            .values
            .first
            .days
            ?.where((element) => element.day == widget.selected)
            .isNotEmpty ==
            true) {
      final list = (Hive.box<GDays>('goals')
          .values
          .first
          .days
          ?.firstWhere((element) => element.day == widget.selected)
          .food ??
          []);
      final data = List.generate(
          list.length,
              (index) => {
            "domain": " ${list[index].name}   $index",
            "measure": list[index].gramms
          });
      for (int i = 0; i < data.length; i++) {
        sum += data[i]['measure'] as int;
      }
      data.sort((a, b) => (b['measure'] as int).compareTo(a['measure'] as int));
      if (Hive.box<int>('dailygoal').values.first - sum > 0) {
        data.add({
          "domain": "left",
          "measure": Hive.box<int>('dailygoal').values.first - sum
        });
      }
      chartData = data;
    } else {
      if (sum == 0) {
        chartData = [
          {"domain": 'left', "measure": Hive.box<int>('dailygoal').values.first}
        ];
      }
    }
  }

  void updateChartData(){
    sum=0;
    if (Hive.box<GDays>('goals').values.first.days?.isNotEmpty == true &&
        Hive.box<GDays>('goals')
            .values
            .first
            .days
            ?.where((element) => element.day == widget.selected)
            .isNotEmpty ==
            true) {
      final list = (Hive.box<GDays>('goals')
          .values
          .first
          .days
          ?.firstWhere((element) => element.day == widget.selected)
          .food ??
          []);
      List<Map<String,dynamic>> data = List.generate(
          list.length,
              (index) => {
            "domain": " ${list[index].name}   $index",
            "measure": list[index].gramms
          });
      for (int i = 0; i < data.length; i++) {
        sum += data[i]['measure'] as int;
      }
      data.sort((a, b) => (b['measure'] as int).compareTo(a['measure'] as int));
      if (Hive.box<int>('dailygoal').values.first - sum >= 0) {
        data.add({
          "domain": "left",
          "measure": Hive.box<int>('dailygoal').values.first - sum
        });
      }
      chartData.clear();
      chartData = data;
    } else {
      if (sum == 0) {
        chartData = [
          {"domain": 'left', "measure": Hive.box<int>('dailygoal').values.first}
        ];
      }
    }
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

  Future<void> deleteNote() async {
    final box = Hive.box<GDays>('goals');
    box.values.first.days
        ?.firstWhere((element) => element.day == widget.selected)
        .note = '';
    await box.put('goals', box.values.first);
    setState(() {});
  }
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
      break;
  }
  return color;
}

class FoodWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final List<Map<String, dynamic>> chartData;
  final int sum;
  final VoidCallback onTap;
  const FoodWidget({
    Key? key,
    required this.data,
    required this.chartData,
    required this.sum,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.h,
        right: 16.w,
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: data['domain'] == 'left'
                    ? AppColors.emptyGoals
                    : colorSelector(index: chartData.indexOf(data)),
              ),
              child: Center(
                child: Text(
                  '${((data['measure'] / (sum <= Hive.box<int>('dailygoal').values.first ? Hive.box<int>('dailygoal').values.first : sum)) * 100).round()}%',
                  style: AppTypography.bold.copyWith(
                    fontSize: 10.w,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                data['domain'].split('   ').first +
                    ' (' +
                    data['measure'].toString() +
                    "g)",
                style: AppTypography.medium.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.w,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
