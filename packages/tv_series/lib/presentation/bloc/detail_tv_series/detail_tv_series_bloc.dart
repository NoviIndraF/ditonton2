import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecase/get_tv_series_detail.dart';

part 'detail_tv_series_event.dart';
part 'detail_tv_series_state.dart';

class DetailTvSeriesBloc extends Bloc<DetailTvSeriesEvent, DetailTvSeriesState> {
  final GetTvSeriesDetail getTvSeriesDetail;

  DetailTvSeriesBloc(
      this.getTvSeriesDetail,
      ) : super(DetailTvSeriesInitial()) {
    on<GetTvSeriesDetailEvent>((event, emit) async {
      emit(DetailTvSeriesLoading());
      final result = await getTvSeriesDetail.execute(event.id);

      result.fold(
            (failure) {
          emit(DetailTvSeriesError(failure.message));
        },
            (data) {
          emit(GetDetailTvSeriesState(data));
        },
      );
    });
  }
}
