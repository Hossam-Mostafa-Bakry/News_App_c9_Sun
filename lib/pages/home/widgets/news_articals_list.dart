import 'package:flutter/material.dart';
import 'package:news_app_c9_sun_4pm/core/network_layer/api_manager.dart';
import 'package:news_app_c9_sun_4pm/models/articals_model.dart';
import 'package:news_app_c9_sun_4pm/models/source_model.dart';

import 'news_artical_item.dart';

class NewsArticalsList extends StatelessWidget {
  Source sourc;

  NewsArticalsList({
    super.key,
    required this.sourc,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArticalsModel>(
      future: ApiManager.fetchArticals(sourc.id!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Articles> articalsList = snapshot.data?.articles ?? [];
        return ListView.builder(
          padding: EdgeInsets.all(20),
          itemBuilder: (context, index) =>
              NewsArticalItem(articles: articalsList[index]),
          itemCount: articalsList.length,
        );
      },
    );
  }
}
