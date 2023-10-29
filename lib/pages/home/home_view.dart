import 'package:flutter/material.dart';
import 'package:news_app_c9_sun_4pm/pages/home/widgets/category_item.dart';
import 'package:news_app_c9_sun_4pm/pages/home/widgets/custom_drawer.dart';
import 'package:news_app_c9_sun_4pm/pages/home/widgets/news_view.dart';

class HomeView extends StatefulWidget {
  static const String routeName = "home";

  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CategoryData? selectedCategory;

  List<CategoryData> categories = [
    CategoryData(
      categoryId: "sports",
      categoryTitle: "Sports",
      categoryImage: "assets/images/sports_icon.png",
      categoryBackgroundColor: const Color(0xFFC91C22),
    ),
    CategoryData(
      categoryId: "general",
      categoryTitle: "Politics",
      categoryImage: "assets/images/politics_icon.png",
      categoryBackgroundColor: const Color(0xFF003E90),
    ),
    CategoryData(
      categoryId: "health",
      categoryTitle: "Health",
      categoryImage: "assets/images/health_icon.png",
      categoryBackgroundColor: const Color(0xFFED1E79),
    ),
    CategoryData(
      categoryId: "business",
      categoryTitle: "Buisness",
      categoryImage: "assets/images/bussines_icon.png",
      categoryBackgroundColor: const Color(0xFFCF7E48),
    ),
    CategoryData(
      categoryId: "enviroment",
      categoryTitle: "Enviroment",
      categoryImage: "assets/images/environment_icon.png",
      categoryBackgroundColor: const Color(0xFF4882CF),
    ),
    CategoryData(
      categoryId: "science",
      categoryTitle: "Science",
      categoryImage: "assets/images/science_icon.png",
      categoryBackgroundColor: const Color(0xFFF2D352),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage("assets/images/pattern.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            selectedCategory == null
                ? "News App"
                : selectedCategory!.categoryTitle,
            style: theme.textTheme.titleLarge,
          ),
        ),
        drawer: CustomDrawer(
          onItemClicked: onCategoryDrawerClicked,
        ),
        body: selectedCategory == null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Pick your category \n of interest",
                      textAlign: TextAlign.start,
                      style: theme.textTheme.titleLarge!
                          .copyWith(color: Color(0xFF4F5A69)),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.all(20.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 9 / 11,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) => CategoryItem(
                          categoryData: categories[index],
                          index: index,
                          onItemClick: onItemClicked,
                        ),
                        itemCount: categories.length,
                      ),
                    )
                  ],
                ),
              )
            : NewsView(categoryData: selectedCategory!),
      ),
    );
  }

  onItemClicked(CategoryData categoryData) {
    print(categoryData.categoryId);
    selectedCategory = categoryData;
    setState(() {});
  }

  onCategoryDrawerClicked() {
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}

class CategoryData {
  final String categoryId;
  final String categoryTitle;
  final String categoryImage;
  final Color categoryBackgroundColor;

  const CategoryData({
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryImage,
    required this.categoryBackgroundColor,
  });
}
