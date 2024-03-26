part of 'on_the_airing_tv_series_bloc.dart';

abstract class OnTheAiringTvSeriesState extends Equatable {
  const OnTheAiringTvSeriesState();

  @override
  List<Object> get props => [];
}

final class OnTheAiringTvSeriesInitial extends OnTheAiringTvSeriesState {}

class OnTheAiringTvSeriesEmpty extends OnTheAiringTvSeriesState {}

class OnTheAiringTvSeriesLoading extends OnTheAiringTvSeriesState {}

class OnTheAiringTvSeriesError extends OnTheAiringTvSeriesState {
  final String message;

  OnTheAiringTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class GetOnTheAiringTvSeriesState extends OnTheAiringTvSeriesState {
  final List<TvSeries> result;

  GetOnTheAiringTvSeriesState(this.result);

  @override
  List<Object> get props => [result];
}