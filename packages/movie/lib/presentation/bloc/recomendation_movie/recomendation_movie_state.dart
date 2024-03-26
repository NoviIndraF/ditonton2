part of 'recomendation_movie_bloc.dart';

abstract class RecomendationMovieState extends Equatable {
  const RecomendationMovieState();

  @override
  List<Object> get props => [];
}

final class RecomendationMovieInitial extends RecomendationMovieState {}

class RecomendationMovieEmpty extends RecomendationMovieState {}

class RecomendationMovieLoading extends RecomendationMovieState {}

class RecomendationMovieError extends RecomendationMovieState {
  final String message;

  RecomendationMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class GetRecomendationMovieState extends RecomendationMovieState {
  final List<Movie> result;

  GetRecomendationMovieState(this.result);

  @override
  List<Object> get props => [result];
}