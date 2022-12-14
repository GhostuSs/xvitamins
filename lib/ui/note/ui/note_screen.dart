import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:xvitamins/data/GDays/gdays.dart';
import 'package:xvitamins/ui/current_day/ui/current_day.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

import '../../../data/goalday/goalday.dart';

class NoteScreen extends StatefulWidget {
  final String note;
  final bool? autofocus;
  final BuildContext ctx;
  final VoidCallback updateParent;
  final DateTime date;
  const NoteScreen({
    Key? key,
    required this.note,
    required this.date,
    this.autofocus, required this.updateParent, required this.ctx,
  }) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController controller;
  bool changed = false;

  @override
  void initState() {
    controller = TextEditingController(text: widget.note);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'Note',
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
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_)=>CurrentDayScreen(selected: widget.date,ctx: widget.ctx,))).then((value) => setState((){}));
            },
          ),
        ),
        body: SafeArea(
          minimum: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  onChanged: (s) =>
                      changed == false ? setState(() => changed = true) : null,
                  autofocus: widget.autofocus ?? false,
                  maxLength: 145,
                  maxLines: 5,
                  style: AppTypography.medium.copyWith(
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counter: SizedBox(height: 0,),
                  ),
                ),
              ),
              if (changed)
                MainButton(
                  onTap: () async {
                    if (Hive.box<GDays>('goals')
                                .values
                                .first
                                .days
                                ?.where((element) => element.day == widget.date)
                                .isNotEmpty ==
                            true) {
                      final box = Hive.box<GDays>('goals');
                      final gday =
                          GoalDay(note: controller.text, day: widget.date);
                      box.values.first.days?.removeWhere(
                          (element) => element.day == widget.date);
                      box.values.first.days!.add(gday);
                      await Hive.box<GDays>('goals').put('goals', box.values.first);
                    } else {
                      final box = Hive.box<GDays>('goals');
                      final gday =
                          GoalDay(note: controller.text, day: widget.date);
                      box.values.first.days!.add(gday);
                      await Hive.box<GDays>('goals').put('goals', box.values.first);
                    }
                    setState(() => changed = false);
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  label: 'Save',
                  mainType: true,
                ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
