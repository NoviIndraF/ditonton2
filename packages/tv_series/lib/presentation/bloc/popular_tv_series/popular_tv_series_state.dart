part of 'popular_tv_series_bloc.dart';

abstract class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();

  @override
  List<Object> get props => [];
}

final class PopularTvSeriesInitial extends PopularTvSeriesState {}

class PopularTvSeriesEmpty extends PopularTvSeriesState {}

class PopularTvSeriesLoading extends PopularTvSeriesState {}

class PopularTvSeriesError extends PopularTvSeriesState {
  final String message;

  PopularTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class GetPopularTvSeriesState extends PopularTvSeriesState {
  final List<TvSeries> result;

  GetPopularTvSeriesState(this.result);

  @override
  List<Object> get props => [result];
}