import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovie;

  PopularMovieBloc(this.getPopularMovie) : super(PopularMovieInitial()) {
    on<GetPopularMovieEvent>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await getPopularMovie.execute();

      result.fold(
        (failure) {
          emit(PopularMovieError(failure.message));
        },
        (data) {
          data.isEmpty
              ? emit(PopularMovieEmpty())
              : emit(GetPopularMovieState(data));
        },
      );
    });
  }
}
