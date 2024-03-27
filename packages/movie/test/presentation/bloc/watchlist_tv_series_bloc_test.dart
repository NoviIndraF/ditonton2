import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovie;
  late MockGetWatchListStatus mockGetWatchListStatusMovie;
  late MockSaveWatchlist mockSaveWatchlistMovie;
  late MockRemoveWatchlist mockRemoveWatchlistMovie;
  late WatchlistMovieBloc watchlistBloc;

  setUp(() {
    mockGetWatchListStatusMovie = MockGetWatchListStatus();
    mockGetWatchlistMovie = MockGetWatchlistMovies();
    mockSaveWatchlistMovie = MockSaveWatchlist();
    mockRemoveWatchlistMovie = MockRemoveWatchlist();
    watchlistBloc = WatchlistMovieBloc(
      mockGetWatchListStatusMovie,
      mockGetWatchlistMovie,
      mockRemoveWatchlistMovie,
      mockSaveWatchlistMovie,
    );
  });

  test('initial state should be initial state', () {
    expect(watchlistBloc.state, WatchlistMovieInitial());
  });

  group(
    'this test for get watchlist tv series, ',
    () {
      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should emit [Loading, HasData] when watchlist data is gotten succesfully',
        build: () {
          when(mockGetWatchlistMovie.execute())
              .thenAnswer((_) async => Right([testWatchlistMovie]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(GetWatchlistMovieEvent()),
        expect: () => [
          WatchlistMovieLoading(),
          GetWatchlistMovieState([testWatchlistMovie]),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovie.execute());
          return GetWatchlistMovieEvent().props;
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should emit [Loading, Error] when watchlist data is unsuccessful',
        build: () {
          when(mockGetWatchlistMovie.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(GetWatchlistMovieEvent()),
        expect: () => [
          WatchlistMovieLoading(),
          WatchlistMovieError('Server Failure'),
        ],
        verify: (bloc) => WatchlistMovieLoading(),
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should emit [Loading, Empty] when get watchlist data is empty',
        build: () {
          when(mockGetWatchlistMovie.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(GetWatchlistMovieEvent()),
        expect: () => [
          WatchlistMovieLoading(),
          WatchlistMovieEmpty(),
        ],
      );

      group(
        'get watchlist status test cases',
        () {
          blocTest<WatchlistMovieBloc, WatchlistMovieState>(
            'should be true when the watchlist status is also true',
            build: () {
              when(mockGetWatchListStatusMovie.execute(testMovieDetail.id))
                  .thenAnswer((_) async => true);
              return watchlistBloc;
            },
            act: (bloc) =>
                bloc.add(GetMovieWatchlistStatusEvent(testMovieDetail.id)),
            expect: () => [
              WatchlistMovieLoading(),
              GetMovieWatchlistStatusState(true),
            ],
            verify: (bloc) {
              verify(mockGetWatchListStatusMovie.execute(testMovieDetail.id));
              return GetMovieWatchlistStatusEvent(testMovieDetail.id).props;
            },
          );

          blocTest<WatchlistMovieBloc, WatchlistMovieState>(
            'should be false when the watchlist status is also false',
            build: () {
              when(mockGetWatchListStatusMovie.execute(testMovieDetail.id))
                  .thenAnswer((_) async => false);
              return watchlistBloc;
            },
            act: (bloc) =>
                bloc.add(GetMovieWatchlistStatusEvent(testMovieDetail.id)),
            expect: () => [
              WatchlistMovieLoading(),
              GetMovieWatchlistStatusState(false),
            ],
            verify: (bloc) {
              verify(mockGetWatchListStatusMovie.execute(testMovieDetail.id));
              return GetMovieWatchlistStatusEvent(testMovieDetail.id).props;
            },
          );
        },
      );

      group('add and remove watchlist test cases', () {
        blocTest<WatchlistMovieBloc, WatchlistMovieState>(
          'should update watchlist status when adding watchlist succeeded',
          build: () {
            when(mockSaveWatchlistMovie.execute(testMovieDetail))
                .thenAnswer((_) async => const Right(ADD_SUCCESS));
            return watchlistBloc;
          },
          act: (bloc) => bloc.add(SaveWatchlistMovieEvent(testMovieDetail)),
          expect: () => [
            WatchlistMovieLoading(),
            SavedWatchlistMovieState(ADD_SUCCESS),
          ],
          verify: (bloc) {
            verify(mockSaveWatchlistMovie.execute(testMovieDetail));
            return SaveWatchlistMovieEvent(testMovieDetail).props;
          },
        );

        blocTest<WatchlistMovieBloc, WatchlistMovieState>(
          'should throw failure message status when adding watchlist failed',
          build: () {
            when(mockSaveWatchlistMovie.execute(testMovieDetail)).thenAnswer(
                (_) async =>
                    Left(DatabaseFailure('can\'t add data to watchlist')));
            return watchlistBloc;
          },
          act: (bloc) => bloc.add(SaveWatchlistMovieEvent(testMovieDetail)),
          expect: () => [
            WatchlistMovieLoading(),
            WatchlistMovieError('can\'t add data to watchlist'),
          ],
          verify: (bloc) {
            verify(mockSaveWatchlistMovie.execute(testMovieDetail));
            return SaveWatchlistMovieEvent(testMovieDetail).props;
          },
        );

        blocTest<WatchlistMovieBloc, WatchlistMovieState>(
          'should update watchlist status when removing watchlist succeeded',
          build: () {
            when(mockRemoveWatchlistMovie.execute(testMovieDetail))
                .thenAnswer((_) async => const Right(REMOVE_SUCCESS));
            return watchlistBloc;
          },
          act: (bloc) => bloc.add(RemoveWatchlistMovieEvent(testMovieDetail)),
          expect: () => [
            WatchlistMovieLoading(),
            RemovedWatchlistMovieState(REMOVE_SUCCESS),
          ],
          verify: (bloc) {
            verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
            return RemoveWatchlistMovieEvent(testMovieDetail).props;
          },
        );

        blocTest<WatchlistMovieBloc, WatchlistMovieState>(
          'should throw failure message status when removing watchlist failed',
          build: () {
            when(mockRemoveWatchlistMovie.execute(testMovieDetail)).thenAnswer(
                (_) async =>
                    Left(DatabaseFailure('can\'t add data to watchlist')));
            return watchlistBloc;
          },
          act: (bloc) => bloc.add(RemoveWatchlistMovieEvent(testMovieDetail)),
          expect: () => [
            WatchlistMovieLoading(),
            WatchlistMovieError('can\'t add data to watchlist'),
          ],
          verify: (bloc) {
            verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
            return RemoveWatchlistMovieEvent(testMovieDetail).props;
          },
        );
      });
    },
  );
}
