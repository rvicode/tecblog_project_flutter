import 'package:get/get.dart';
import 'package:project111/components/api_constant.dart';
import 'package:project111/models/article_detail_model.dart';
import 'package:project111/services/dio_services.dart';

class ArticleDetailController extends GetxController {
  Rx<ArticleDetailModel> articleDetailModel = ArticleDetailModel().obs;
  RxInt id = RxInt(0);
  RxBool loading = false.obs;

  getArticleDetail() async {
    loading.value = true;

    var userId = '';
    var response = await DioServices().getMethod(
        '${ApiConstant.baseUrl}article/get.php?command=info&id=$id&user_id=$userId');

    if (response.statusCode == 200) {
      articleDetailModel.value = ArticleDetailModel.fromJson(response.data);

      loading.value = false;
    }
  }
}
