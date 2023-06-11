import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FontController extends GetxController {
  RxList<String> _fonts =
      <String>['PlayfairDisplay-Medium', 'PlayfairDisplay-Italic'].obs;
  List<String> get fonts => _fonts;
  RxString fontSelect = 'PlayfairDisplay-Medium'.obs;
  switchFont(int index) async {
    fontSelect.value = _fonts[index];
    update();
  }
}
