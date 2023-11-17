import 'package:get/get.dart';
import 'package:project111/components/api_constant.dart';
import 'package:project111/models/article_detail_model.dart';
import 'package:project111/models/article_model.dart';
import 'package:project111/models/tags_model.dart';
import 'package:project111/services/dio_services.dart';
import 'package:project111/view/screens/article_detail_screen.dart';

class ArticleDetailController extends GetxController {
  Rx<ArticleDetailModel> articleDetailModel = ArticleDetailModel().obs;
  RxList<ArticleModel> relatedList = RxList();
  RxInt id = RxInt(0);
  RxBool loading = false.obs;
  RxList<TagsModel> tagList = RxList();

  getArticleDetail(var id) async {
    articleDetailModel = ArticleDetailModel().obs;
    loading.value = true;

    var userId = '';
    var response = await DioServices().getMethod(
        '${ApiConstant.baseUrl}article/get.php?command=info&id=$id&user_id=$userId');

    if (response.statusCode == 200) {
      articleDetailModel.value = ArticleDetailModel.fromJson(response.data);
    Get.back();
    Get.to(ArticleDetailScreen());
    loading.value = false;
    }

    tagList.clear();
    response.data['tags'].forEach((element) {
      tagList.add(TagsModel.fromJson(element));
    });

    relatedList.clear();
    response.data['related'].forEach((element) {
      relatedList.add(ArticleModel.fromJson(element));
    });
  }
}
