import '../../../models/source_model.dart';

abstract class HomeStates {}

class HomeIntialState extends HomeStates {}

class HomeSourceLoadingState extends HomeStates {}

class HomeSourceSuccessState extends HomeStates {
  final List<Source> sourcesList;

  HomeSourceSuccessState(this.sourcesList);
}

class HomeSourceErrorState extends HomeStates {}

class HomeArticalsLoadingState extends HomeStates {}

class HomeArticalsSuccessState extends HomeStates {}

class HomeArticalsErrorState extends HomeStates {}

class ChangeIndexState extends HomeStates {}
