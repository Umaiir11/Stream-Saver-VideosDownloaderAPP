import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DashboardController extends GetxController {
  RxInt? pageIndex = 1.obs;

  void changePage(int index) {
    pageIndex?.value = index;
  }
}