import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/model/chatting/chatting_room_state.dart';
import 'package:rebootOffice/repository/chatting/chatting_repository.dart';
import 'package:rebootOffice/view/chatting_list/widget/popup_onboarding_chat_modal.dart';
import 'package:rebootOffice/view_model/root/root_view_model.dart';

class ChattingRoomListViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */
  late final RootViewModel _rootViewModel;
  late final ChattingRepository _chattingRepository;
  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final RxList<ChattingRoomState> _chattingRoomList =
      <ChattingRoomState>[].obs;
  /* ------------------------------------------------------ */
  /* ----------------- Public Fields ---------------------- */
  /* ------------------------------------------------------ */
  List<ChattingRoomState> get chattingRoomList => _chattingRoomList;

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection
    _rootViewModel = Get.find<RootViewModel>();
    _chattingRepository = Get.find<ChattingRepository>();
    // Initialize private fields
  }

  @override
  void onReady() async {
    super.onReady();
    fetchChattingRoomList();
  }

  Future<void> fetchChattingRoomList() async {
    _chattingRoomList.value = await _chattingRepository.readChattingRoomList();
  }

  void selectBottomBarIndex(int chatId) {
    _rootViewModel.fetchIndex(chatId);
  }

  // 팝업 온보딩 보여주는 함수
  void showBusinessCardPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const PopupOnboardingChatModal();
      },
    );
  }
}
