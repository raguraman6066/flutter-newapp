import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/model/slider.dart';
import 'package:newsapp/pages/article.dart';
import 'package:newsapp/services/news.dart';

import '../services/slider.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<ArticleModel> articles = [];
  List<SliderModel> slidesdata = [];
  bool isLoading = true;
  getArticles() async {
    News news = News();
    await news.getNews();
    articles = news.news;
    print("result $articles");
    setState(() {
      isLoading = false;
    });
  }

  getSlides() async {
    Slides news = Slides();
    await news.getSlides();
    slidesdata = news.slides;
    print("result slide $slidesdata");
    setState(() {
      isLoading = false;
    });
  }

  int activeIndex = 0;
  @override
  void initState() {
    getSlides();
    getArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.news + " News",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 7),
              child: ListView.builder(
                itemCount: widget.news == "Breaking"
                    ? slidesdata.length
                    : articles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ArticleView(
                            blogUrl: widget.news == "Breaking"
                                ? slidesdata[index].url
                                : articles[index].url),
                      ));
                    },
                    child: AllNewsSection(
                        image: widget.news == "Breaking"
                            ? slidesdata[index].urlToImage
                            : articles[index].urlToImage,
                        title: widget.news == "Breaking"
                            ? slidesdata[index].title
                            : articles[index].title,
                        description: widget.news == "Breaking"
                            ? slidesdata[index].description
                            : articles[index].description),
                  );
                },
              )),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String image, description, title;
  AllNewsSection(
      {required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image ?? "",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Image.asset(
                "images/general.jpg", // fallback image
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(description),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
