part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class GetWatchlistTvSeriesEvent extends WatchlistTvSeriesEvent {
  const GetWatchlistTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class GetTvSeriesWatchlistStatusEvent extends WatchlistTvSeriesEvent {
  int id;
  GetTvSeriesWatchlistStatusEvent(this.id);

  @override
  List<Object> get props => [];
}

class RemoveWatchlistTvSeriesEvent extends WatchlistTvSeriesEvent {
  TvSeriesDetail tvSeriesDetail;
  RemoveWatchlistTvSeriesEvent(this.tvSeriesDetail);

  @override
  List<Object> get props => [];
}

class SaveWatchlistTvSeriesEvent extends WatchlistTvSeriesEvent {
  TvSeriesDetail tvSeriesDetail;
  SaveWatchlistTvSeriesEvent(this.tvSeriesDetail);

  @override
  List<Object> get props => [];
}