import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xvitamins/data/GDays/gdays.dart';
import 'package:xvitamins/data/food/food_model.dart';
import 'package:xvitamins/ui/add_fruit/ui/add_fruit.dart';
import 'package:xvitamins/ui/current_day/ui/current_day.dart';
import 'package:xvitamins/ui/main/bloc/main_cubit.dart';
import 'package:xvitamins/ui/onboarding/ui/onboarding.dart';
import 'package:xvitamins/ui/stat/ui/stat_screen.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class CalendarScreen extends StatefulWidget {
  final DateTime? focusOn;
  final BuildContext ctx;
  const CalendarScreen({Key? key,this.focusOn, required this.ctx}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: BlocBuilder<MainCubit,MainState>(
      bloc: widget.ctx.read<MainCubit>(),
      builder: (cubit,state)=>Scaffold(
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
                  height: 15.h,
                ),
                TableCalendar(
                  focusedDay: widget.focusOn ?? today,
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
                        ctx: widget.ctx,
                        // day: Hive.box<GDays>('goals')
                        //             .values
                        //             .first
                        //             .days
                        //             ?.any((element) => element.day == day) ==
                        //         true
                        //     ? Hive.box<GDays>('goals')
                        //         .values
                        //         .first
                        //         .days
                        //         ?.firstWhere((elem) => elem.day == day)
                        //     : GoalDay(day: day, note: ''),
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
                    // dowTextFormatter: (date,locale)=> dayLabels(date),
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
                  height: 20.h,
                ),
                MainButton(
                    onTap: () => pushNewScreen(context, screen: Hive.box<bool>('premium').values.first==true ? const StatScreen() : const Onboarding(),withNavBar: Hive.box<bool>('premium').values.first==true ? true : false),
                    label: 'Monthly statistics'),
                const Spacer(),
                MainButton(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddScreen(
                        fromHome: true,
                        ctx: context,
                        day: today,
                        updateParent: () => setState(() {}),
                      ),
                    ),
                  ),
                  label: 'Add fruit and Veg',
                  mainType: true,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    ), onWillPop:()async=>false);
  }
  Color dayColorSelector(DateTime date){
    if(date.day==DateTime.now().day&&date.month==DateTime.now().month&&date.year==DateTime.now().year)return AppColors.blue;
    if(Hive.box<GDays>('goals').values.first.days?.where((element) => element.day?.day==date.day&&element.day?.month==date.month&&element.day?.year==date.year).isNotEmpty==true){
      final gday=Hive.box<GDays>('goals').values.first.days?.firstWhere((element) => element.day?.day==date.day&&element.day?.month==date.month&&element.day?.year==date.year);
      return gday?.completed==true&&checksum(gday?.food ?? []) ? AppColors.green : gday?.day?.isBefore(DateTime.now())==true ?  AppColors.red : gday?.note!=null ? AppColors.black : Colors.transparent;
    }
    return Colors.transparent;
  }

  bool checksum(List<Food> food){
    int sum =0;
    for(final data in food){
      sum+=data.gramms!;
    }
    if(sum>=Hive.box<int>('dailygoal').values.first){
      return true;
    }else{
      return false;
    }
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
      default: return "s";
    }
  }
}
