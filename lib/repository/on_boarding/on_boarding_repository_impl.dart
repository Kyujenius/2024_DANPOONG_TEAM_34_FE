import 'package:get/get.dart';
import 'package:rebootOffice/provider/on_boarding/on_boarding_provider.dart';
import 'package:rebootOffice/repository/on_boarding/on_boarding_repository.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';

class OnBoardingRepositoryImpl extends GetxService
    implements OnBoardingRepository {
  late final OnBoardingProvider _onBoardingProvider;

  @override
  void onInit() {
    super.onInit();
    _onBoardingProvider = Get.find<OnBoardingProvider>();
  }

  @override
  Future<Response> sendOnBoardingData(String name, String nameEn, String gender,
      String birthday, String motivate) async {
    LogUtil.debug('OnboardingRepository: 시작');
    return await _onBoardingProvider.sendOnBoardingData(
        name, nameEn, gender, birthday, motivate);
  }
}
