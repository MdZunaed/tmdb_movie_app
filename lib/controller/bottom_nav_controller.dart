import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  changeIndex(int index) {
    _currentIndex = index;
    update();
  }

  backToHome() {
    _currentIndex = 0;
    update();
  }
}
