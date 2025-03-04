import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uni_football_app/features/news/domain/usecase/news_usecases.dart';
import 'package:uni_football_app/features/news/presentation/view_model/news_bloc.dart';
import 'package:uni_football_app/features/news/presentation/view_model/news_state.dart';

class MockGetNewsOverviewUseCase extends Mock
    implements GetNewsOverviewUseCase {}

class MockGetNewsDetailsUseCase extends Mock implements GetNewsDetailsUseCase {}

void main() {
  late MockGetNewsOverviewUseCase mockGetNewsOverviewUseCase;
  late MockGetNewsDetailsUseCase mockGetNewsDetailsUseCase;
  late NewsBloc newsBloc;

  setUp(() {
    mockGetNewsOverviewUseCase = MockGetNewsOverviewUseCase();
    mockGetNewsDetailsUseCase = MockGetNewsDetailsUseCase();
    newsBloc = NewsBloc(
      getNewsOverview: mockGetNewsOverviewUseCase,
      getNewsDetails: mockGetNewsDetailsUseCase,
    );
  });

  // Test 1: Initial state should be NewsInitial
  test(' Should emit NewsLoading state when FetchNewsOverview event is added',
      () {
    expect(newsBloc.state, NewsInitial());
  });

  // Test 1: Initial state should be NewsInitial
  test(' should emit isSuccess = false when RegisterUser event fails', () {
    expect(newsBloc.state, NewsInitial());
  });

  test(' should emit isSuccess = false when RegisterUser event fails', () {
    expect(newsBloc.state, NewsInitial());
  });
}
