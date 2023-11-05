import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_c9_sun_4pm/pages/home/cubit/cubit.dart';
import 'package:news_app_c9_sun_4pm/pages/home/cubit/states.dart';
import 'package:news_app_c9_sun_4pm/pages/home/home_view.dart';
import 'package:news_app_c9_sun_4pm/pages/home/widgets/tab_bar_item.dart';

import 'news_artical_item.dart';

class NewsDetails extends StatefulWidget {
  CategoryData categoryData;

  NewsDetails({
    super.key,
    required this.categoryData,
  });

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit()..getSource(widget.categoryData.categoryId),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is HomeSourceSuccessState) {
            HomeCubit.get(context).getArticals(HomeCubit.get(context)
                .sourceList[HomeCubit.get(context).selectedIndex]
                .id);
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return DefaultTabController(
            length: cubit.sourceList.length,
            child: Column(
              children: [
                TabBar(
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                  indicator: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide.none,
                    ),
                  ),
                  isScrollable: true,
                  onTap: (int index) {
                    cubit.changeIndexState(index);
                    cubit.getArticals(cubit.sourceList[cubit.selectedIndex].id);
                  },
                  tabs: cubit.sourceList
                      .map((e) => TabBarItem(
                            title: e.name,
                            selected: cubit.selectedIndex ==
                                cubit.sourceList.indexOf(e),
                          ))
                      .toList(),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemBuilder: (context, index) =>
                        NewsArticalItem(articles: cubit.articalsList[index]),
                    itemCount: cubit.articalsList.length,
                  ),
                ),
              ],
            ),
          );
        },
        /*child: DefaultTabController(
            length: widget.sourceModel.sources.length,
            child: Column(
              children: [
                TabBar(
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                  indicator: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide.none,
                    ),
                  ),
                  isScrollable: true,
                  onTap: (int index) {
                    selectedIndex = index;
                    setState(() {});
                  },
                  tabs: widget.sourceModel.sources
                      .map((e) => TabBarItem(
                            title: e.name,
                            selected: selectedIndex ==
                                widget.sourceModel.sources.indexOf(e),
                          ))
                      .toList(),
                ),
                Expanded(
                    child: NewsArticalsList(
                        sourc: widget.sourceModel.sources[selectedIndex])),
              ],
            )),*/
      ),
    );
  }
}
