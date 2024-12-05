import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/model/statistics/task_state.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view_model/statistics_detail/statistic_detail_view_model.dart';

import '../../utility/system/color_system.dart';
import '../../utility/system/font_system.dart';
import '../../widget/appbar/default_back_appbar.dart';

class StatisticsDetailScreen extends BaseScreen<StatisticsDetailViewModel> {
  const StatisticsDetailScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: DefaultBackAppBar(
          showBackButton: true,
          title: '업무일지',
          onBackPress: () => {Get.back()},
          centerTitle: true,
        ));
  }

  @override
  Widget buildBody(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateHeader(),
            Expanded(
              child: _buildTaskList(),
            ),
          ],
        ));
  }

  Widget _buildDateHeader() {
    final selectedDate = viewModel.selectedDate.value;
    final weekday = _getWeekdayString(selectedDate.weekday);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Text(
        '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일 $weekday',
        style: FontSystem.KR20M,
      ),
    );
  }

  String _getWeekdayString(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return '월요일';
      case DateTime.tuesday:
        return '화요일';
      case DateTime.wednesday:
        return '수요일';
      case DateTime.thursday:
        return '목요일';
      case DateTime.friday:
        return '금요일';
      case DateTime.saturday:
        return '토요일';
      case DateTime.sunday:
        return '일요일';
      default:
        return '';
    }
  }

  Widget _buildTaskList() {
    return ListView.builder(
        itemCount: viewModel.taskList.length,
        itemBuilder: (context, index) {
          bool isLastItem = index == viewModel.taskList.length - 1; // 마지막 항목 체크

          return _buildTaskDetail(viewModel.taskList[index], isLastItem);
        });
  }

  Widget _buildTaskDetail(TaskState task, bool isLastTask) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              CircleAvatar(radius: 8, backgroundColor: ColorSystem.blue),
              const SizedBox(
                width: 12,
              ),
              Text(
                task.chatType,
                style: FontSystem.KR20SB,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                task.createdAt,
                style: FontSystem.KR16R.copyWith(
                  color: ColorSystem.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: isLastTask
                  ? null
                  : Container(
                      width: 1.5,
                      height: 400,
                      color: ColorSystem.blue.shade300,
                    ),
            ),
            Column(
              children: [
                Container(
                  width: 229,
                  height: 309,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.network(
                    task.imageUrl,
                    width: 229,
                    height: 309,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 229,
                  child: Text(
                    task.content,
                    style: FontSystem.KR16SB,
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
