import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:project111/components/my_string.dart';
import 'package:project111/controller/article_manage_controller.dart';
import 'package:project111/view/screens/article_list_screen.dart';

class ArticleContentEditor extends StatelessWidget {
  ArticleContentEditor({Key? key}) : super(key: key);

  final HtmlEditorController controller = HtmlEditorController();
  var manageArticleController = Get.put(ArticleManageController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => controller.clearFocus(),
      child: Scaffold(
        appBar: appbar(textTheme, MyString.titleAppBarArticleContentEditor),
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HtmlEditor(
                controller: controller,
                htmlEditorOptions: HtmlEditorOptions(
                    hint: MyString.hintArticleContentEditor,
                    shouldEnsureVisible: true,
                    initialText: manageArticleController
                        .articleInfoModel.value.content!),
                callbacks: Callbacks(
                  onChangeContent: (p0) {
                    manageArticleController.articleInfoModel.update(
                      (val) {
                        val?.content = p0;
                      },
                    );
                    log(manageArticleController.articleInfoModel.value.content
                        .toString());
                  },
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
