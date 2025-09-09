import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/model/show_category.dart';

class ShowCategorys {
  List<ShowCategoryModel> categories = [];
  Future<void> getCategories(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=6a3bb6db4ad94444b91c8ba494f15f1c";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ShowCategoryModel showCategory = ShowCategoryModel(
            author: element["author"] ?? "Guest",
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"] ?? "",
          );
          categories.add(showCategory);
        }
      });
    }
  }
}
