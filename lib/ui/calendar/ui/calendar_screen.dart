import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xvitamins/data/GDays/gdays.dart';
import 'package:xvitamins/data/goalday/goalday.dart';
import 'package:xvitamins/ui/current_day/ui/current_day.dart';
import 'package:xvitamins/ui/stat/ui/stat_screen.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: AppColors.gray2,
          width: 0.5.w,
        ))),
        child: SafeArea(
          minimum: EdgeInsets.only(
            top: 32.h,
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Month',
                    style: AppTypography.semibold.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.w,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.black,
                    size: 24.w,
                  )
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              TableCalendar(
                focusedDay: today,
                currentDay:today,
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (_,date,events)=>Center(
                    child: Container(constraints: BoxConstraints.expand(width: 36.w,height: 35.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: dayColorSelector(date),
                          )
                      ),),
                  )
                ),
                onDaySelected: (day, d) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CurrentDayScreen(
                      selected: day,
                      day: Hive.box<GDays>('goals')
                                  .values
                                  .first
                                  .days
                                  ?.any((element) => element.day == day) ==
                              true
                          ? Hive.box<GDays>('goals')
                              .values
                              .first
                              .days
                              ?.firstWhere((elem) => elem.day == day)
                          : GoalDay(day: day, note: ''),
                    ),
                  ),
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextStyle: AppTypography.semibold.copyWith(
                    fontSize: 18.w,
                    fontWeight: FontWeight.w600,
                  ),
                  leftChevronIcon: Icon(
                    Icons.arrow_back,
                    color: AppColors.black,
                    size: 20.w,
                  ),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward,
                    color: AppColors.black,
                    size: 20.w,
                  ),
                  formatButtonVisible: false,
                ),
                daysOfWeekHeight: 42.h,
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                  ),
                  disabledTextStyle: AppTypography.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.w,
                    color: AppColors.black,
                  ),
                  todayTextStyle: AppTypography.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.w,
                    color: AppColors.white,
                  ),
                  outsideTextStyle: AppTypography.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.w,
                    color: AppColors.gray2,
                  ),
                  defaultTextStyle: AppTypography.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.w,
                    color: AppColors.black,
                  ),
                  holidayTextStyle: AppTypography.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.w,
                    color: AppColors.black,
                  ),
                  rangeEndTextStyle: AppTypography.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.w,
                    color: AppColors.black,
                  ),
                  rangeStartTextStyle: AppTypography.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.w,
                    color: AppColors.black,
                  ),
                  weekendTextStyle: AppTypography.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.w,
                    color: AppColors.black,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: AppTypography.medium.copyWith(
                    fontSize: 18.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray2,
                  ),
                  dowTextFormatter: (date,locale)=>dayLabels(date),
                  weekendStyle: AppTypography.medium.copyWith(
                    fontSize: 18.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray2,
                  ),
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                firstDay: DateTime.now().subtract(
                  const Duration(days: 365),
                ),
                lastDay: DateTime.now().add(
                  const Duration(days: 365),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              MainButton(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StatScreen(),
                      )),
                  label: 'Monthly statistics'),
              const Spacer(),
              MainButton(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CurrentDayScreen(
                      selected: today,
                      day: Hive.box<GDays>('goals')
                                  .values
                                  .first
                                  .days
                                  ?.any((element) => element.day == today) ==
                              true
                          ? Hive.box<GDays>('goals')
                              .values
                              .first
                              .days
                              ?.firstWhere((elem) => elem.day == today)
                          : GoalDay(day: today, note: ''),
                    ),
                  ),
                ),
                label: 'Add fruit and Veg',
                mainType: true,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Color dayColorSelector(DateTime date){
    if(date.day==DateTime.now().day&&date.month==DateTime.now().month&&date.year==DateTime.now().year)return AppColors.blue;
    if(Hive.box<GDays>('goals').values.first.days?.where((element) => element.day?.day==date.day&&element.day?.month==date.month&&element.day?.year==date.year).isNotEmpty==true){
      final gday=Hive.box<GDays>('goals').values.first.days?.firstWhere((element) => element.day?.day==date.day&&element.day?.month==date.month&&element.day?.year==date.year);
      return gday?.completed==true ? AppColors.green : gday?.day?.isBefore(DateTime.now())==true ?  AppColors.red : gday?.note!=null&&gday?.note!='' ? AppColors.black : Colors.transparent;
    }
    return Colors.transparent;
  }

  String dayLabels(DateTime date){
    switch(date.day){
      case DateTime.monday:
        return 'Mo';
      case DateTime.tuesday:
        return 'Tu';
      case DateTime.wednesday:
        return 'We';
      case DateTime.thursday:
        return 'Th';
      case DateTime.friday:
        return 'Fr';
      case DateTime.saturday:
        return 'Sa';
      case DateTime.sunday:
        return 'Su';
      default: return "";
    }
  }
}
