import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/domain/usecase/get_on_the_airing_tv_series.dart';
import 'package:tv_series/domain/usecase/get_top_rated_tv_series.dart';
import 'package:tv_series/presentation/bloc/on_airing_tv_series/on_the_airing_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_the_airing_today_tv_series_bloc_test.mocks.dart';


@GenerateMocks([GetOnTheAiringTvSeries])
void main() {
  late OnTheAiringTvSeriesBloc onTheAiringTvSeriesBloc;
  late MockGetOnTheAiringTvSeries mockOnTheAiringTvSeries;

  setUp(() {
    mockOnTheAiringTvSeries = MockGetOnTheAiringTvSeries();
    onTheAiringTvSeriesBloc = OnTheAiringTvSeriesBloc(mockOnTheAiringTvSeries);
  });

  test('initial state should be empty', () {
    expect(onTheAiringTvSeriesBloc.state, OnTheAiringTvSeriesInitial());
  });

  blocTest<OnTheAiringTvSeriesBloc, OnTheAiringTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockOnTheAiringTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return onTheAiringTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetOnTheAiringTvSeriesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      OnTheAiringTvSeriesLoading(),
      GetOnTheAiringTvSeriesState(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockOnTheAiringTvSeries.execute());
    },
  );

  blocTest<OnTheAiringTvSeriesBloc, OnTheAiringTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockOnTheAiringTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return onTheAiringTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetOnTheAiringTvSeriesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      OnTheAiringTvSeriesLoading(),
      OnTheAiringTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockOnTheAiringTvSeries.execute());
    },
  );

  blocTest<OnTheAiringTvSeriesBloc, OnTheAiringTvSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockOnTheAiringTvSeries.execute()).thenAnswer((_) async => const Right([]));
      return onTheAiringTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetOnTheAiringTvSeriesEvent()),
    expect: () => [
      OnTheAiringTvSeriesLoading(),
      OnTheAiringTvSeriesEmpty(),
    ],
  );
}