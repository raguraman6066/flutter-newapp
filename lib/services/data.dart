import 'package:newsapp/model/category.dart';
import 'package:newsapp/model/slider.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];
  CategoryModel category1 = CategoryModel(
    categoryName: "Business",
    categoryImage: "images/business.jpg",
  );
  categories.add(category1);
  CategoryModel category2 = CategoryModel(
    categoryName: "Entertainment",
    categoryImage: "images/entertainment.jpg",
  );
  categories.add(category2);
  CategoryModel category3 = CategoryModel(
    categoryName: "General",
    categoryImage: "images/general.jpg",
  );
  categories.add(category3);
  CategoryModel category4 = CategoryModel(
    categoryName: "Health",
    categoryImage: "images/health.jpg",
  );
  categories.add(category4);
  CategoryModel category5 = CategoryModel(
    categoryName: "Sports",
    categoryImage: "images/sport.jpg",
  );
  categories.add(category5);
  return categories;
}

// List<SliderModel> getSlider() {
//   List<SliderModel> sliderData = [];
//   SliderModel slider1 = SliderModel(
//     sliderName: "Bow To The Authority of SilenForce",
//     sliderImage: "images/business.jpg",
//   );
//   sliderData.add(slider1);
//   SliderModel slider2 = SliderModel(
//     sliderName: "Bow To The Authority of SilenForce",
//     sliderImage: "images/entertainment.jpg",
//   );
//   sliderData.add(slider2);
//   SliderModel slider3 = SliderModel(
//     sliderName: "Bow To The Authority of SilenForce",
//     sliderImage: "images/health.jpg",
//   );
//   sliderData.add(slider3);

//   return sliderData;
// }
