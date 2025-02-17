// news_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_football_app/features/news/domain/usecase/news_usecases.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsOverviewUseCase getNewsOverview;
  final GetNewsDetailsUseCase getNewsDetails;

  NewsBloc({required this.getNewsOverview, required this.getNewsDetails}) : super(NewsInitial()) {
    on<FetchNewsOverview>(onFetchNewsOverview);
    on<FetchNewsDetails>(onFetchNewsDetails);
  }

  Future<void> onFetchNewsOverview(FetchNewsOverview event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await getNewsOverview();
    result.fold(
      (failure) => emit(NewsError(failure.message)),
      (newsList) => emit(NewsOverviewLoaded(newsList)),
    );
  }

  Future<void> onFetchNewsDetails(FetchNewsDetails event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await getNewsDetails(event.newsId);
    result.fold(
      (failure) => emit(NewsError(failure.message)),
      (news) => emit(NewsDetailsLoaded(news)),
    );
  }
}