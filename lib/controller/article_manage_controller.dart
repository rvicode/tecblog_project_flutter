import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project111/components/api_constant.dart';
import 'package:project111/components/my_string.dart';
import 'package:project111/models/article_info_model.dart';
import 'package:project111/models/article_model.dart';
import 'package:project111/services/dio_services.dart';

class ArticleManageController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxBool loading = false.obs;
  TextEditingController titleTextEditingController = TextEditingController();
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel(
    MyString.titltArrticle,
    MyString.editOrginalTextArticle,
    "",
  ).obs;

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
        await DioServices().getMethod("${ApiConstant.publishedByMe}1");

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
    }
    loading.value = false;
  }

  updateTitle() {
    articleInfoModel.update((val) {
      val!.title = titleTextEditingController.text;
    });
  }
}
