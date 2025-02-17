// news_state.dart
import 'package:equatable/equatable.dart';
import 'package:uni_football_app/features/news/domain/entity/news_entity.dart';

abstract class NewsState extends Equatable {
  const NewsState();
  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsOverviewLoaded extends NewsState {
  final List<NewsEntity> newsList;
  const NewsOverviewLoaded(this.newsList);
  @override
  List<Object> get props => [newsList];
}

class NewsDetailsLoaded extends NewsState {
  final NewsEntity news;
  const NewsDetailsLoaded(this.news);
  @override
  List<Object> get props => [news];
}

class NewsError extends NewsState {
  final String message;
  const NewsError(this.message);
  @override
  List<Object> get props => [message];
}
