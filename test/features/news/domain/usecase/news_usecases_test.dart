import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uni_football_app/features/news/domain/entity/news_entity.dart';
import 'package:uni_football_app/features/news/domain/repository/news_repository.dart';
import 'package:uni_football_app/features/news/domain/usecase/news_usecases.dart';

// Mock Repository
class MockNewsRepository extends Mock implements INewsRepository {}

void main() {
  late MockNewsRepository mockNewsRepository;
  late GetNewsOverviewUseCase getNewsOverviewUseCase;
  late GetNewsDetailsUseCase getNewsDetailsUseCase;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    getNewsOverviewUseCase = GetNewsOverviewUseCase(mockNewsRepository);
    getNewsDetailsUseCase = GetNewsDetailsUseCase(mockNewsRepository);
  });

  // 1. GetNewsOverviewUseCase - Success Test
  test(
      'should return a list of news entities when news overview fetch is successful',
      () async {
    // Arrange: Mocking the repository to return a successful response
    final newsList = [
      NewsEntity(
        newsId: '1',
        title: 'News Title',
        body: 'This is the body of the news.',
        newsImage: 'image_url',
        author: 'Author Name',
        datePublished: DateTime.now(),
      ),
    ];
    when(() => mockNewsRepository.getNewsOverview())
        .thenAnswer((_) async => Right(newsList));

    // Act: Call the use case
    final result = await getNewsOverviewUseCase();

    // Assert: Check that the result is the expected list of news entities
    expect(result, Right(newsList));
    verify(() => mockNewsRepository
        .getNewsOverview()); // Verifying repository interaction
  });

  // 3. GetNewsDetailsUseCase - Success Test
  test('should return news details when news details fetch is successful',
      () async {
    // Arrange: Mocking the repository to return a successful response
    final newsDetail = NewsEntity(
      newsId: '1',
      title: 'News Details',
      body: 'This is the detailed body of the news.',
      newsImage: 'image_url',
      author: 'Author Name',
      datePublished: DateTime.now(),
    );
    when(() => mockNewsRepository.getNewsDetails(any()))
        .thenAnswer((_) async => Right(newsDetail));

    // Act: Call the use case
    final result = await getNewsDetailsUseCase('1');

    // Assert: Check that the result is the expected news entity
    expect(result, Right(newsDetail));
    verify(() => mockNewsRepository
        .getNewsDetails('1')); // Verifying repository interaction
  });
}
