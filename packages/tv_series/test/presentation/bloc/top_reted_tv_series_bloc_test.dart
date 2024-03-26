import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/domain/usecase/get_top_rated_tv_series.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_reted_tv_series_bloc_test.mocks.dart';


@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedTvSeries mockTopRatedTvSeries;

  setUp(() {
    mockTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockTopRatedTvSeries);
  });

  test('initial state should be empty', () {
    expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesInitial());
  });

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTvSeriesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedTvSeriesLoading(),
      GetTopRatedTvSeriesState(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockTopRatedTvSeries.execute());
    },
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTvSeriesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockTopRatedTvSeries.execute());
    },
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockTopRatedTvSeries.execute()).thenAnswer((_) async => const Right([]));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTvSeriesEvent()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesEmpty(),
    ],
  );
}