part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class GetWatchlistMovieEvent extends WatchlistMovieEvent {
  const GetWatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class GetMovieWatchlistStatusEvent extends WatchlistMovieEvent {
  int id;
  GetMovieWatchlistStatusEvent(this.id);

  @override
  List<Object> get props => [];
}

class RemoveWatchlistMovieEvent extends WatchlistMovieEvent {
  MovieDetail tvSeriesDetail;
  RemoveWatchlistMovieEvent(this.tvSeriesDetail);

  @override
  List<Object> get props => [];
}

class SaveWatchlistMovieEvent extends WatchlistMovieEvent {
  MovieDetail tvSeriesDetail;
  SaveWatchlistMovieEvent(this.tvSeriesDetail);

  @override
  List<Object> get props => [];
}