part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object> get props => [];
}

final class WatchlistTvSeriesInitial extends WatchlistTvSeriesState {}

class WatchlistTvSeriesEmpty extends WatchlistTvSeriesState {}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {}

class WatchlistTvSeriesError extends WatchlistTvSeriesState {
  final String message;

  WatchlistTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}


class GetTvSeriesWatchlistStatusState extends WatchlistTvSeriesState {
  final bool result;

  GetTvSeriesWatchlistStatusState(this.result);

  @override
  List<Object> get props => [result];
}

class GetWatchlistTvSeriesState extends WatchlistTvSeriesState {
  final List<TvSeries> result;

  GetWatchlistTvSeriesState(this.result);

  @override
  List<Object> get props => [result];
}

class RemovedWatchlistTvSeriesState extends WatchlistTvSeriesState {
  final String result;

  RemovedWatchlistTvSeriesState(this.result);

  @override
  List<Object> get props => [result];
}

class SavedWatchlistTvSeriesState extends WatchlistTvSeriesState {
  final String result;

  SavedWatchlistTvSeriesState(this.result);

  @override
  List<Object> get props => [result];
}