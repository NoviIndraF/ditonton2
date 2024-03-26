import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
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
          when(mockGetWatchlistMovie.execute()).thenAnswer(
                  (_) async =>  Left(ServerFailure('Server Failure')));
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
    },
  );
}