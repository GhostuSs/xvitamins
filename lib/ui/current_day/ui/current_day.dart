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

  late List<Map<String,dynamic>> chartData;
  int sum=0;
  @override
  void initState() {
    if(Hive.box<GDays>('goals').values.first.days?.isNotEmpty==true) {
    final list = (Hive.box<GDays>('goals').values.first.days?.firstWhere((element) => element.day==widget.selected).food ?? []);
    final data = List.generate(list.length, (index) => {"domain":list[index].name,"measure":list[index].gramms});
    for(int i=0;i<data.length;i++){
      sum+=data[i]['measure'] as int;
    }
    if(400-sum>0)data.add({"domain":"left","measure":400- sum});
    chartData=data;
    }else{
      chartData=[
       {"domain":'left',"measure":400}
      ];
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                    decoration: const BoxDecoration(
                      color: Color(0xFFD1FFFC),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 180.w,
                    height: 180.w,
                    child: DChartPie(
                      data:
                        chartData
                      ,
                      labelPosition: PieLabelPosition.inside,
                      showLabelLine: false,
                      labelPadding: 0,
                      labelColor: Colors.transparent,
                      fillColor: (pieData, index) =>
                          sum==0 ? AppColors.emptyGoals : colorSelector(index: index),
                      donutWidth: 20,
                    ),
                  ),
                  Text(
                    '${400-sum}/400',
                    style: AppTypography.bold.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.w,
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
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>AddScreen())),
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
    final box = Hive.box<GDays>('goals');
    final gday = GoalDay(note:'',day: widget.selected);
    box.values.first.days?.firstWhere((element) => element.day==widget.selected).note='';
    await box.put('goals', box.values.first);
    setState(() {});
  }
}
