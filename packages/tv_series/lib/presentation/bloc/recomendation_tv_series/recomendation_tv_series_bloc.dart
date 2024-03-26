import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecase/get_tv_series_recommendations.dart';

part 'recomendation_tv_series_event.dart';
part 'recomendation_tv_series_state.dart';

class RecomendationTvSeriesBloc
    extends Bloc<RecomendationTvSeriesEvent, RecomendationTvSeriesState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  RecomendationTvSeriesBloc(
    this.getTvSeriesRecommendations,
  ) : super(RecomendationTvSeriesInitial()) {
    on<GetTvSeriesRecomendationEvent>((event, emit) async {
      emit(RecomendationTvSeriesLoading());
      final result = await getTvSeriesRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(RecomendationTvSeriesError(failure.message));
        },
        (data) {
          data.isEmpty
              ? emit(RecomendationTvSeriesEmpty())
              : emit(GetRecomendationTvSeriesState(data));
        },
      );
    });
  }
}
