part of 'recomendation_movie_bloc.dart';

abstract class RecomendationMovieEvent extends Equatable {
  const RecomendationMovieEvent();

  @override
  List<Object> get props => [];
}

class GetMovieRecomendationEvent extends RecomendationMovieEvent {
  int id;
  GetMovieRecomendationEvent(this.id);

  @override
  List<Object> get props => [];
}