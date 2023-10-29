import 'package:flutter/material.dart';
import 'package:news_app_c9_sun_4pm/core/network_layer/api_manager.dart';
import 'package:news_app_c9_sun_4pm/models/source_model.dart';
import 'package:news_app_c9_sun_4pm/pages/home/home_view.dart';
import 'package:news_app_c9_sun_4pm/pages/home/widgets/news_details.dart';

class NewsView extends StatefulWidget {
  final CategoryData categoryData;

  const NewsView({
    super.key,
    required this.categoryData,
  });

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceModel>(
      future: ApiManager.fetchSources(widget.categoryData.categoryId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        SourceModel sourceModel = snapshot.data!;
        return NewsDetails(
          sourceModel: sourceModel,
        );
      },
    );
  }
}
