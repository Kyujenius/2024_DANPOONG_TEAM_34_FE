import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/model/home/week_state.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/view/home/widget/report_button.dart';
import 'package:rebootOffice/view/home/widget/week_calendar.dart';
import 'package:rebootOffice/view_model/home/home_view_model.dart';

import 'week_selector.dart';

class WeekCalendarCard extends StatefulWidget {
  final WeekState weekState;
  final VoidCallback onWeekSelect;
  final VoidCallback onReportTap;

  const WeekCalendarCard({
    super.key,
    required this.weekState,
    required this.onWeekSelect,
    required this.onReportTap,
  });

  @override
  State<WeekCalendarCard> createState() => _WeekCalendarCardState();
}

class _WeekCalendarCardState extends State<WeekCalendarCard> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeViewModel>();

    final now = widget.weekState.currentTime;
    final weekNumber = ((now.day - 1) ~/ 7) + 1;

    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: ColorSystem.grey.shade200, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WeekSelector(
              year: now.year,
              month: now.month,
              weekNumber: weekNumber,
              onTap: widget.onWeekSelect,
            ),
            const SizedBox(height: 16),
            WeekCalendarView(
              weekState: widget.weekState,
              selectedDate: controller.selectedDate.value,
              onDateSelected: controller.updateSelectedDate,
            ),
            const SizedBox(height: 16),
            ReportButton(
                isSelected: controller.selectedDate.value != null,
                onTap: () {
                  // 날짜 선택해야만 업무일지 볼 수 있음
                  if (controller.selectedDate.value != null) {
                    widget.onReportTap();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
