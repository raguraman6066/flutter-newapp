import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/model/show_category.dart';
import 'package:newsapp/pages/article.dart';
import 'package:newsapp/services/category.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  const CategoryNews({required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  bool isLoading = true;
  List<ShowCategoryModel> categoriesdata = [];
  getCategories() async {
    ShowCategorys news = ShowCategorys();
    await news.getCategories(widget.category);
    categoriesdata = news.categories;
    print("result slide $categoriesdata");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
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
                itemCount: categoriesdata.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ArticleView(blogUrl: categoriesdata[index].url),
                      ));
                    },
                    child: ShowCategory(
                        image: categoriesdata[index].urlToImage,
                        title: categoriesdata[index].title,
                        description: categoriesdata[index].description),
                  );
                },
              )),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String image, description, title;
  ShowCategory(
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
