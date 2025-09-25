import 'package:get/get.dart';
import 'package:new_task/ui/controllers/login_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put( LoginController());
  }
}
