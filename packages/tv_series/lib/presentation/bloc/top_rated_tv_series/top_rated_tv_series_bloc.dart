import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecase/get_top_rated_tv_series.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesBloc(this.getTopRatedTvSeries) : super(TopRatedTvSeriesInitial()) {
    on<GetTopRatedTvSeriesEvent>((event, emit) async {
      emit(TopRatedTvSeriesLoading());
      final result = await getTopRatedTvSeries.execute();

      result.fold(
            (failure) {
          emit(TopRatedTvSeriesError(failure.message));
        },
            (data) {
              data.isEmpty
                  ? emit(TopRatedTvSeriesEmpty())
                  : emit(GetTopRatedTvSeriesState(data));
        },
      );
    });
  }
}
