import 'package:get/get.dart';
import 'package:project111/controller/article_contorller.dart';
import 'package:project111/controller/article_detail_contorller.dart';
import 'package:project111/controller/register_controller.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.put(ArticleController());
    Get.lazyPut(() => ArticleDetailController());
  }
}

class ArticleManageBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.put(ArticleManageBinding());
    
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.put(RegisterController());
  }
}
