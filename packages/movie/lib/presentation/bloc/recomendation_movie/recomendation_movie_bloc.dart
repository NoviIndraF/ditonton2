import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

part 'recomendation_movie_event.dart';
part 'recomendation_movie_state.dart';

class RecomendationMovieBloc
    extends Bloc<RecomendationMovieEvent, RecomendationMovieState> {
  final GetMovieRecommendations getMovieRecommendations;

  RecomendationMovieBloc(
    this.getMovieRecommendations,
  ) : super(RecomendationMovieInitial()) {
    on<GetMovieRecomendationEvent>((event, emit) async {
      emit(RecomendationMovieLoading());
      final result = await getMovieRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(RecomendationMovieError(failure.message));
        },
        (data) {
          data.isEmpty
              ? emit(RecomendationMovieEmpty())
              : emit(GetRecomendationMovieState(data));
        },
      );
    });
  }
}
