part of 'recomendation_tv_series_bloc.dart';

abstract class RecomendationTvSeriesState extends Equatable {
  const RecomendationTvSeriesState();

  @override
  List<Object> get props => [];
}

final class RecomendationTvSeriesInitial extends RecomendationTvSeriesState {}

class RecomendationTvSeriesEmpty extends RecomendationTvSeriesState {}

class RecomendationTvSeriesLoading extends RecomendationTvSeriesState {}

class RecomendationTvSeriesError extends RecomendationTvSeriesState {
  final String message;

  RecomendationTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class GetRecomendationTvSeriesState extends RecomendationTvSeriesState {
  final List<TvSeries> result;

  GetRecomendationTvSeriesState(this.result);

  @override
  List<Object> get props => [result];
}