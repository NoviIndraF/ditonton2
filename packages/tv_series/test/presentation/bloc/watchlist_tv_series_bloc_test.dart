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

      group(
        'get watchlist status test cases',
            () {
          blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
            'should be true when the watchlist status is also true',
            build: () {
              when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
                  .thenAnswer((_) async => true);
              return watchlistBloc;
            },
            act: (bloc) =>
                bloc.add(GetTvSeriesWatchlistStatusEvent(testTvSeriesDetail.id!)),
            expect: () => [
              WatchlistTvSeriesLoading(),
              GetTvSeriesWatchlistStatusState(true),
            ],
            verify: (bloc) {
              verify(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id));
              return GetTvSeriesWatchlistStatusEvent(testTvSeriesDetail.id!).props;
            },
          );

          blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
            'should be false when the watchlist status is also false',
            build: () {
              when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
                  .thenAnswer((_) async => false);
              return watchlistBloc;
            },
            act: (bloc) =>
                bloc.add(GetTvSeriesWatchlistStatusEvent(testTvSeriesDetail.id!)),
            expect: () => [
              WatchlistTvSeriesLoading(),
              GetTvSeriesWatchlistStatusState(false),
            ],
            verify: (bloc) {
              verify(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id));
              return GetTvSeriesWatchlistStatusEvent(testTvSeriesDetail.id!).props;
            },
          );
        },
      );

      group('add and remove watchlist test cases', () {
        blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
          'should update watchlist status when adding watchlist succeeded',
          build: () {
            when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
                .thenAnswer((_) async => const Right(ADD_SUCCESS));
            return watchlistBloc;
          },
          act: (bloc) => bloc.add(SaveWatchlistTvSeriesEvent(testTvSeriesDetail)),
          expect: () => [
            WatchlistTvSeriesLoading(),
            SavedWatchlistTvSeriesState(ADD_SUCCESS),
          ],
          verify: (bloc) {
            verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
            return SaveWatchlistTvSeriesEvent(testTvSeriesDetail).props;
          },
        );

        blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
          'should throw failure message status when adding watchlist failed',
          build: () {
            when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
                    (_) async =>
                    Left(DatabaseFailure('can\'t add data to watchlist')));
            return watchlistBloc;
          },
          act: (bloc) => bloc.add(SaveWatchlistTvSeriesEvent(testTvSeriesDetail)),
          expect: () => [
            WatchlistTvSeriesLoading(),
            WatchlistTvSeriesError('can\'t add data to watchlist'),
          ],
          verify: (bloc) {
            verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
            return SaveWatchlistTvSeriesEvent(testTvSeriesDetail).props;
          },
        );

        blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
          'should update watchlist status when removing watchlist succeeded',
          build: () {
            when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
                .thenAnswer((_) async => const Right(REMOVE_SUCCESS));
            return watchlistBloc;
          },
          act: (bloc) => bloc.add(RemoveWatchlistTvSeriesEvent(testTvSeriesDetail)),
          expect: () => [
            WatchlistTvSeriesLoading(),
            RemovedWatchlistTvSeriesState(REMOVE_SUCCESS),
          ],
          verify: (bloc) {
            verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
            return RemoveWatchlistTvSeriesEvent(testTvSeriesDetail).props;
          },
        );

        blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
          'should throw failure message status when removing watchlist failed',
          build: () {
            when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
                    (_) async =>
                    Left(DatabaseFailure('can\'t add data to watchlist')));
            return watchlistBloc;
          },
          act: (bloc) => bloc.add(RemoveWatchlistTvSeriesEvent(testTvSeriesDetail)),
          expect: () => [
            WatchlistTvSeriesLoading(),
            WatchlistTvSeriesError('can\'t add data to watchlist'),
          ],
          verify: (bloc) {
            verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
            return RemoveWatchlistTvSeriesEvent(testTvSeriesDetail).props;
          },
        );
      });
    },
  );
}