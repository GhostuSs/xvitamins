import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:xvitamins/data/GDays/gdays.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

import '../../../data/goalday/goalday.dart';

class NoteScreen extends StatefulWidget {
  final String note;
  final bool? autofocus;
  final DateTime date;
  const NoteScreen({Key? key, required this.note, required this.date, this.autofocus,}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  late TextEditingController controller;
  bool changed = false;

  @override
  void initState() {
    controller=TextEditingController(text: widget.note ?? '');
    super.initState();
    // Add code after super
  }


  @override
  Widget build(BuildContext context) {
    print(controller.text);
    print(widget.date);
    return Scaffold(
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          children: [
            Expanded(child:
            TextFormField(
              controller: controller,
              onChanged: (s)=>changed==false ? setState(()=>changed=true) : null,
              autofocus: widget.autofocus ?? false,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),),
            if(changed)MainButton(
              onTap: () async {
                if(widget.note!=''){
                  print('s');
                  final boxs = Hive.box<GDays>('goals');
                  final value = boxs.values.first.days?.firstWhere((element) => element.note==widget.note);
                  boxs.values.first.days?.remove(value);
                  value?.note=controller.text;
                  boxs.values.first.days?.add(value!);
                  final box = boxs.values.first;
                  await boxs.clear();
                  await boxs.put('goals', box);
                }else{
                  final box = Hive.box<GDays>('goals');
                  box.values.first.days?.add(GoalDay(note:controller.text,day: widget.date));
                  await box.put('goals', box.values.first);
                }
                setState(()=>changed=false);
              },
              label: 'Save',
              mainType: true,
            ),
            SizedBox(height: 16.h,),
          ],
        ),
      ),
    );
  }
}
