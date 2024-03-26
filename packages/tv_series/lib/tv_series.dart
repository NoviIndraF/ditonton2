library tv_series;

export 'data/datasources/db/database_helper.dart';

export 'data/datasources/tv_series_local_data_source.dart';
export 'data/datasources/tv_series_remote_data_source.dart';
export 'data/repositories/tv_series_repository_impl.dart';

export 'domain/entities/tv_series.dart';

export 'domain/repositeries/tv_series_repository.dart';
export 'domain/usecase/get_tv_series_detail.dart';
export 'domain/usecase/get_tv_series_recommendations.dart';
export 'domain/usecase/get_on_the_airing_tv_series.dart';
export 'domain/usecase/get_popular_tv_series.dart';
export 'domain/usecase/get_top_rated_tv_series.dart';
export 'domain/usecase/get_watchlist_tv_series.dart';
export 'domain/usecase/get_watchlist_status_tv_series.dart';
export 'domain/usecase/remove_watchlist_tv_series.dart';
export 'domain/usecase/save_watchlist_tv_series.dart';

export 'presentation/pages/tv_series_page.dart';
export 'presentation/pages/tv_series_detail_page.dart';
export 'presentation/pages/popular_tv_series_page.dart';
export 'presentation/pages/top_rated_tv_series_page.dart';
export 'presentation/pages/watchlist_tv_series_page.dart';

export 'presentation/widget/tv_list_card.dart';
