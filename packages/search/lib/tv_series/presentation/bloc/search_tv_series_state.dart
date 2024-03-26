part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesState extends Equatable {
  const SearchTvSeriesState();

  @override
  List<Object> get props => [];
}
final class SearchInitial extends SearchTvSeriesState {
  @override
  List<Object> get props => [];
}

class SearchTvSeriesEmpty extends SearchTvSeriesState {}

class SearchTvSeriesLoading extends SearchTvSeriesState {}

class SearchTvSeriesError extends SearchTvSeriesState {
  final String message;

  SearchTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasDataTvSeries extends SearchTvSeriesState {
  final List<TvSeries> result;

  SearchHasDataTvSeries(this.result);

  @override
  List<Object> get props => [result];
}