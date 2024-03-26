import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/tv_series/domain/usecase/search_tv_series.dart';
import 'package:tv_series/tv_series.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';


EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class SearchTvSeriesBloc extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries _searchTvSeries;

  SearchTvSeriesBloc(this._searchTvSeries) : super(SearchTvSeriesEmpty()) {
    on<OnQueryChangedTvSeries>((event, emit) async {
      final query = event.query;

      emit(SearchTvSeriesLoading());
      final result = await _searchTvSeries.execute(query);

      result.fold(
            (failure) {
          emit(SearchTvSeriesError(failure.message));
        },
            (data) {
          emit(SearchHasDataTvSeries(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}