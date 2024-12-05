import 'package:get/get.dart';
import 'package:rebootOffice/model/statistics/attendance_state.dart';
import 'package:rebootOffice/model/statistics/period_state.dart';
import 'package:rebootOffice/model/statistics/task_state.dart';
import 'package:rebootOffice/model/statistics/user_status_state.dart';
import 'package:rebootOffice/provider/statistics/statistics_provider.dart';
import 'package:rebootOffice/repository/statistics/statistics_repository.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';

class StatisticsRepositoryImpl extends GetxService
    implements StatisticsRepository {
  late final StatisticsProvider _statisticsProvider;

  @override
  void onInit() {
    super.onInit();
    _statisticsProvider = Get.find<StatisticsProvider>();
  }

  @override
  Future<UserStatusState> readUserStatus() async {
    // " "  : ~~  이 앞은 항상 String 인데 뒤는 dynamic 이니까 Map<String, dynamic> 이렇게 써줘야함
    Map<String, dynamic> data;

    try {
      data = await _statisticsProvider.readUserStatus();
    } catch (e) {
      return UserStatusState.initial();
    }

    return UserStatusState.fromJson(data);
  }

  @override
  Future<PeriodState> readUserPeriod() async {
    Map<String, dynamic> data;

    try {
      data = await _statisticsProvider.readUserPeriod();
    } catch (e) {
      LogUtil.error("남은 기간 조회 실패 ,초기값으로 설정");
      return PeriodState.initial();
    }

    return PeriodState.fromJson(data);
  }

  @override
  Future<List<TaskState>> readUserTaskList(DateTime date) async {
    List<dynamic> data;

    try {
      data = await _statisticsProvider.readUserTaskList(date);
    } catch (e) {
      LogUtil.error("Task 설정 실패 ,초기값으로 설정");
      return TaskState.initial();
    }

    return data.map((e) => TaskState.fromJson(e)).toList();
  }

  @override
  Future<AttendanceState> readUserAttendanceList(int index) async {
    Map<String, dynamic> data;

    try {
      data = await _statisticsProvider.readUserAttendanceList(index);
      LogUtil.info("출석 데이터 조회 성공");
    } catch (e) {
      LogUtil.error(e);
      return AttendanceState.initial();
    }
    return AttendanceState.fromJson(data);
  }
}
