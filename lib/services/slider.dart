import 'dart:convert';

import 'package:newsapp/model/article.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/model/slider.dart';

class Slides {
  List<SliderModel> slides = [];
  Future<void> getSlides() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6a3bb6db4ad94444b91c8ba494f15f1c";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          SliderModel sliderModel = SliderModel(
            author: element["author"] ?? "Guest",
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          slides.add(sliderModel);
        }
      });
    }
  }
}
