import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class NoteScreen extends StatefulWidget {
  final String note;
  const NoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  late TextEditingController controller;

  @override
  void initState() {
    controller=TextEditingController(text: widget.note ?? '');
    super.initState();
    // Add code after super
  }


  @override
  Widget build(BuildContext context) {
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
            TextFormField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(

              ),
            ),
            const Spacer(),
            MainButton(
              onTap: () {},
              label: 'Save',
              mainType: true,
            )
          ],
        ),
      ),
    );
  }
}
