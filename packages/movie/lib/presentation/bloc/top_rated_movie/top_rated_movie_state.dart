part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

final class TopRatedMovieInitial extends TopRatedMovieState {}

class TopRatedMovieEmpty extends TopRatedMovieState {}

class TopRatedMovieLoading extends TopRatedMovieState {}

class TopRatedMovieError extends TopRatedMovieState {
  final String message;

  TopRatedMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class GetTopRatedMovieState extends TopRatedMovieState {
  final List<Movie> result;

  GetTopRatedMovieState(this.result);

  @override
  List<Object> get props => [result];
}