import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_c9_sun_4pm/core/network_layer/api_manager.dart';
import 'package:news_app_c9_sun_4pm/models/articals_model.dart';
import 'package:news_app_c9_sun_4pm/pages/home/cubit/states.dart';

import '../../../models/source_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeIntialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;
  List<Source> sourceList = [];
  List<Articles> articalsList = [];

  changeIndexState(int index) {
    selectedIndex = index;
    emit(ChangeIndexState());
  }

  getSource(String categoryId) async {
    emit(HomeSourceLoadingState());
    try {
      var response = await ApiManager.fetchSources(categoryId);

      if (response.status == "ok") {
        sourceList = response.sources;
        emit(HomeSourceSuccessState(sourceList));
      } else {
        emit(HomeSourceErrorState());
      }
    } catch (e) {
      emit(HomeSourceErrorState());
    }
  }

  getArticals(String sourceId) async {
    emit(HomeArticalsLoadingState());
    try {
      var response = await ApiManager.fetchArticals(sourceId);

      if (response.status == "ok") {
        articalsList = response.articles ?? [];
        emit(HomeArticalsSuccessState());
      } else {
        emit(HomeArticalsErrorState());
      }
    } catch (e) {
      emit(HomeArticalsErrorState());
    }
  }
}
