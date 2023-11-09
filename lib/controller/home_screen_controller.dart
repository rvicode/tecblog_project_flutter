import 'package:get/get.dart';
import 'package:project111/components/api_constant.dart';
import 'package:project111/models/article_model.dart';
import 'package:project111/models/podcast_model.dart';
import 'package:project111/models/poster_model.dart';
import 'package:project111/models/tags_model.dart';
import 'package:project111/services/dio_services.dart';

class HomeScreenController extends GetxController {
  Rx<PosterModel> poster = PosterModel().obs;
  RxList<ArticleModel> topVisitedList = RxList();
  RxList<TagsModel> tags = RxList();
  RxList<PodCastModel> topPodCast = RxList();
  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getHomeItems();
  }

  getHomeItems() async {
    loading.value = true;

    var response = await DioServices().getMethod(ApiConstant.getHomeItem);

    if (response.statusCode == 200) {
      response.data['tags'].forEach((element) {
        tags.add(TagsModel.fromJson(element));
      });
      response.data['top_podcasts'].forEach((element) {
        topPodCast.add(PodCastModel.fromJson(element));
      });

      response.data['top_visited'].forEach((elelment) {
        topVisitedList.add(ArticleModel.fromJson(elelment));
      });

      poster.value = PosterModel.fromJson(response.data['poster']);

      loading.value = false;
    }
  }
}
