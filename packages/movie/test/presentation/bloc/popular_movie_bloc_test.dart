import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popular_movie/popular_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movie_bloc_test.mocks.dart';


@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovies mockPopularMovie;

  setUp(() {
    mockPopularMovie = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockPopularMovie);
  });

  test('initial state should be empty', () {
    expect(popularMovieBloc.state, PopularMovieInitial());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockPopularMovie.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(GetPopularMovieEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularMovieLoading(),
      GetPopularMovieState(testMovieList),
    ],
    verify: (bloc) {
      verify(mockPopularMovie.execute());
    },
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockPopularMovie.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(GetPopularMovieEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockPopularMovie.execute());
    },
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockPopularMovie.execute()).thenAnswer((_) async => const Right([]));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(GetPopularMovieEvent()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieEmpty(),
    ],
  );
}