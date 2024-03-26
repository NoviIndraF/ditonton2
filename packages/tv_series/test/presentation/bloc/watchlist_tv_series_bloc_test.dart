import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_watchlist_status_tv_series.dart';
import 'package:tv_series/domain/usecase/get_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecase/remove_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecase/save_watchlist_tv_series.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeries,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {

  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late WatchlistTvSeriesBloc watchlistBloc;

  setUp(() {
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    watchlistBloc = WatchlistTvSeriesBloc(
      mockGetWatchListStatusTvSeries,
      mockGetWatchlistTvSeries,
      mockRemoveWatchlistTvSeries,
      mockSaveWatchlistTvSeries,
    );
  });

  test('initial state should be initial state', () {
    expect(watchlistBloc.state, WatchlistTvSeriesInitial());
  });

  group(
    'this test for get watchlist tv series, ',
        () {
      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should emit [Loading, HasData] when watchlist data is gotten succesfully',
        build: () {
          when(mockGetWatchlistTvSeries.execute())
              .thenAnswer((_) async => Right([testWatchlistTvSeries]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(GetWatchlistTvSeriesEvent()),
        expect: () => [
          WatchlistTvSeriesLoading(),
          GetWatchlistTvSeriesState([testWatchlistTvSeries]),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTvSeries.execute());
          return GetWatchlistTvSeriesEvent().props;
        },
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should emit [Loading, Error] when watchlist data is unsuccessful',
        build: () {
          when(mockGetWatchlistTvSeries.execute()).thenAnswer(
                  (_) async =>  Left(ServerFailure('Server Failure')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(GetWatchlistTvSeriesEvent()),
        expect: () => [
          WatchlistTvSeriesLoading(),
          WatchlistTvSeriesError('Server Failure'),
        ],
        verify: (bloc) => WatchlistTvSeriesLoading(),
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should emit [Loading, Empty] when get watchlist data is empty',
        build: () {
          when(mockGetWatchlistTvSeries.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(GetWatchlistTvSeriesEvent()),
        expect: () => [
          WatchlistTvSeriesLoading(),
          WatchlistTvSeriesEmpty(),
        ],
      );
    },
  );
}