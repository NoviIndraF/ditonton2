part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();

  @override
  List<Object> get props => [];
}

final class TopRatedTvSeriesInitial extends TopRatedTvSeriesState {}

class TopRatedTvSeriesEmpty extends TopRatedTvSeriesState {}

class TopRatedTvSeriesLoading extends TopRatedTvSeriesState {}

class TopRatedTvSeriesError extends TopRatedTvSeriesState {
  final String message;

  TopRatedTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class GetTopRatedTvSeriesState extends TopRatedTvSeriesState {
  final List<TvSeries> result;

  GetTopRatedTvSeriesState(this.result);

  @override
  List<Object> get props => [result];
}