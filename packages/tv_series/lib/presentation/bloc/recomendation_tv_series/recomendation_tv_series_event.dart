part of 'recomendation_tv_series_bloc.dart';

abstract class RecomendationTvSeriesEvent extends Equatable {
  const RecomendationTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class GetTvSeriesRecomendationEvent extends RecomendationTvSeriesEvent {
  int id;
  GetTvSeriesRecomendationEvent(this.id);

  @override
  List<Object> get props => [];
}