import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecase/get_on_the_airing_tv_series.dart';

part 'on_the_airing_tv_series_event.dart';
part 'on_the_airing_tv_series_state.dart';

class OnTheAiringTvSeriesBloc
    extends Bloc<OnTheAiringTvSeriesEvent, OnTheAiringTvSeriesState> {
  final GetOnTheAiringTvSeries getOnTheAiringTvSeries;

  OnTheAiringTvSeriesBloc(this.getOnTheAiringTvSeries)
      : super(OnTheAiringTvSeriesInitial()) {
    on<GetOnTheAiringTvSeriesEvent>((event, emit) async {
      emit(OnTheAiringTvSeriesLoading());
      final result = await getOnTheAiringTvSeries.execute();

      result.fold(
        (failure) {
          emit(OnTheAiringTvSeriesError(failure.message));
        },
        (data) {
          data.isEmpty
              ? emit(OnTheAiringTvSeriesEmpty())
              : emit(GetOnTheAiringTvSeriesState(data));
        },
      );
    });
  }
}
