import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/recomendation_movie/recomendation_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recomendation_tv_series_bloc_test.mocks.dart';


@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecomendationMovieBloc recomendationMovieBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recomendationMovieBloc = RecomendationMovieBloc(mockGetMovieRecommendations);
  });

  test('initial state should be empty', () {
    expect(recomendationMovieBloc.state, RecomendationMovieInitial());
  });

  blocTest<RecomendationMovieBloc, RecomendationMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testMovieList));
      return recomendationMovieBloc;
    },
    act: (bloc) => bloc.add(GetMovieRecomendationEvent(testId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecomendationMovieLoading(),
      GetRecomendationMovieState(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(testId));
    },
  );

  blocTest<RecomendationMovieBloc, RecomendationMovieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recomendationMovieBloc;
    },
    act: (bloc) => bloc.add(GetMovieRecomendationEvent(testId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecomendationMovieLoading(),
      RecomendationMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(testId));
    },
  );

  blocTest<RecomendationMovieBloc, RecomendationMovieState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetMovieRecommendations.execute(testId)).thenAnswer((_) async => const Right([]));
      return recomendationMovieBloc;
    },
    act: (bloc) => bloc.add(GetMovieRecomendationEvent(testId)),
    expect: () => [
      RecomendationMovieLoading(),
      RecomendationMovieEmpty(),
    ],
  );
}