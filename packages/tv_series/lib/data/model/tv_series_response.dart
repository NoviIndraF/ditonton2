import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tv_series/data/model/tv_series_model.dart';

TvSeriesResponse TvSeriesResponseFromJson(String str) => TvSeriesResponse.fromJson(json.decode(str));

String TvSeriesResponseToJson(TvSeriesResponse data) => json.encode(data.toJson());

class TvSeriesResponse extends Equatable {
  final int page;
  final List<TvSeriesModel> tvSeriesList;
  final int totalPages;
  final int totalResults;

  TvSeriesResponse({
    required this.page,
    required this.tvSeriesList,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) => TvSeriesResponse(
    page: json["page"],
    tvSeriesList: List<TvSeriesModel>.from(json["results"].map((x) => TvSeriesModel.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(tvSeriesList.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesList];
}
