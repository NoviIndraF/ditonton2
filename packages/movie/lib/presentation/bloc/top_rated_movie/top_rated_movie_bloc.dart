import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovie;

  TopRatedMovieBloc(this.getTopRatedMovie) : super(TopRatedMovieInitial()) {
    on<GetTopRatedMovieEvent>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await getTopRatedMovie.execute();

      result.fold(
        (failure) {
          emit(TopRatedMovieError(failure.message));
        },
        (data) {
          data.isEmpty
              ? emit(TopRatedMovieEmpty())
              : emit(GetTopRatedMovieState(data));
        },
      );
    });
  }
}
