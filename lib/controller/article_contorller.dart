import 'package:get/get.dart';
import 'package:project111/components/api_constant.dart';
import 'package:project111/models/article_model.dart';
import 'package:project111/services/dio_services.dart';

class ArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getList();
  }

  getList() async {
    articleList = RxList();
    loading.value = true;

    var response = await DioServices().getMethod(ApiUrlConstant.getArticleList);

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });

      loading.value = false;
    }
  }

  getArticleListWithId(String id) async {
    articleList.clear();
    loading.value = true;

    var response = await DioServices().getMethod(
        '${ApiUrlConstant.baseUrl}article/get.php?command=get_articles_with_tag_id&tag_id=$id&user_id=');

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }
}
