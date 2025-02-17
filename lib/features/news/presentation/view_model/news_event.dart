// news_event.dart
import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
  @override
  List<Object> get props => [];
}

class FetchNewsOverview extends NewsEvent {}

class FetchNewsDetails extends NewsEvent {
  final String newsId;
  const FetchNewsDetails(this.newsId);
  @override
  List<Object> get props => [newsId];
}
