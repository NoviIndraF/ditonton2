import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/domain/usecase/get_top_rated_tv_series.dart';
import 'package:tv_series/domain/usecase/get_tv_series_recommendations.dart';
import 'package:tv_series/presentation/bloc/recomendation_tv_series/recomendation_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recomendation_tv_series_bloc_test.mocks.dart';


@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late RecomendationTvSeriesBloc recomendationTvSeriesBloc;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    recomendationTvSeriesBloc = RecomendationTvSeriesBloc(mockGetTvSeriesRecommendations);
  });

  test('initial state should be empty', () {
    expect(recomendationTvSeriesBloc.state, RecomendationTvSeriesInitial());
  });

  blocTest<RecomendationTvSeriesBloc, RecomendationTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return recomendationTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTvSeriesRecomendationEvent(testId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecomendationTvSeriesLoading(),
      GetRecomendationTvSeriesState(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(testId));
    },
  );

  blocTest<RecomendationTvSeriesBloc, RecomendationTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recomendationTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTvSeriesRecomendationEvent(testId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecomendationTvSeriesLoading(),
      RecomendationTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(testId));
    },
  );

  blocTest<RecomendationTvSeriesBloc, RecomendationTvSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(testId)).thenAnswer((_) async => const Right([]));
      return recomendationTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTvSeriesRecomendationEvent(testId)),
    expect: () => [
      RecomendationTvSeriesLoading(),
      RecomendationTvSeriesEmpty(),
    ],
  );
}