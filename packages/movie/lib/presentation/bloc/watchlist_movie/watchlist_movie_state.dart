part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

final class WatchlistMovieInitial extends WatchlistMovieState {}

class WatchlistMovieEmpty extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}


class GetMovieWatchlistStatusState extends WatchlistMovieState {
  final bool result;

  GetMovieWatchlistStatusState(this.result);

  @override
  List<Object> get props => [result];
}

class GetWatchlistMovieState extends WatchlistMovieState {
  final List<Movie> result;

  GetWatchlistMovieState(this.result);

  @override
  List<Object> get props => [result];
}

class RemovedWatchlistMovieState extends WatchlistMovieState {
  final String result;

  RemovedWatchlistMovieState(this.result);

  @override
  List<Object> get props => [result];
}

class SavedWatchlistMovieState extends WatchlistMovieState {
  final String result;

  SavedWatchlistMovieState(this.result);

  @override
  List<Object> get props => [result];
}