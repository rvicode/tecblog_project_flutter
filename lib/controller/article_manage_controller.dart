import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project111/components/api_constant.dart';
import 'package:project111/components/command.dart';
import 'package:project111/components/my_string.dart';
import 'package:project111/components/storage_const.dart';
import 'package:project111/models/article_info_model.dart';
import 'package:project111/models/article_model.dart';
import 'package:project111/services/dio_services.dart';
import 'package:project111/services/file_pick.dart';

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
        await DioServices().getMethod("${ApiUrlConstant.publishedByMe}1");

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

  storeArticle() async {
    loading.value = true;
    Map<String, dynamic> map = {
      ApiAeticleKeyConstant.title: articleInfoModel.value.title,
      ApiAeticleKeyConstant.content: articleInfoModel.value.content,
      ApiAeticleKeyConstant.catId: articleInfoModel.value.catId,
      ApiAeticleKeyConstant.tagList: [2,6],
      ApiAeticleKeyConstant.userId: GetStorage().read(StorageKey.userID),
      ApiAeticleKeyConstant.image:
          dio.MultipartFile.fromFile(filePickerController.file.value.path!),
      ApiAeticleKeyConstant.command: Command.store,
    };
    var response =
        await DioServices().postMethod(map, ApiUrlConstant.articlePost);
    log(response.data.toString());
    loading.value = false;
  }
}
