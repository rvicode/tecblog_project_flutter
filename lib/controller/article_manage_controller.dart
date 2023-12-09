import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project111/components/api_constant.dart';
import 'package:project111/components/storage_const.dart';
import 'package:project111/models/article_model.dart';
import 'package:project111/services/dio_services.dart';

class ArticleManageController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getArticleManaged();
  }

  getArticleManaged() async {
    loading.value = true;
    // var response = await DioServices().getMethod(
    //     ApiConstant.publishedByMe + GetStorage().read(StorageKey.userID));
    var response =
        await DioServices().getMethod(ApiConstant.publishedByMe + "1");

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
    }
    loading.value = false;
  }
}
