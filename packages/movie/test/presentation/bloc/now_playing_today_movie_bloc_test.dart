import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/now_playing/nov_playing_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_today_movie_bloc_test.mocks.dart';


@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMovieBloc onNowPlayingMovieBloc;
  late MockGetNowPlayingMovies mockNowPlayingMovie;

  setUp(() {
    mockNowPlayingMovie = MockGetNowPlayingMovies();
    onNowPlayingMovieBloc = NowPlayingMovieBloc(mockNowPlayingMovie);
  });

  test('initial state should be empty', () {
    expect(onNowPlayingMovieBloc.state, NowPlayingMovieInitial());
  });

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockNowPlayingMovie.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return onNowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingMovieEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      NowPlayingMovieLoading(),
      GetNowPlayingMovieState(testMovieList),
    ],
    verify: (bloc) {
      verify(mockNowPlayingMovie.execute());
    },
  );

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockNowPlayingMovie.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return onNowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingMovieEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      NowPlayingMovieLoading(),
      NowPlayingMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockNowPlayingMovie.execute());
    },
  );

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockNowPlayingMovie.execute()).thenAnswer((_) async => const Right([]));
      return onNowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingMovieEvent()),
    expect: () => [
      NowPlayingMovieLoading(),
      NowPlayingMovieEmpty(),
    ],
  );
}