import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_reted_tv_series_bloc_test.mocks.dart';



@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockTopRatedMovie;

  setUp(() {
    mockTopRatedMovie = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(mockTopRatedMovie);
  });

  test('initial state should be empty', () {
    expect(topRatedMovieBloc.state, TopRatedMovieInitial());
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockTopRatedMovie.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMovieEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedMovieLoading(),
      GetTopRatedMovieState(testMovieList),
    ],
    verify: (bloc) {
      verify(mockTopRatedMovie.execute());
    },
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockTopRatedMovie.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMovieEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockTopRatedMovie.execute());
    },
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockTopRatedMovie.execute()).thenAnswer((_) async => const Right([]));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMovieEvent()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieEmpty(),
    ],
  );
}