import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/app_interceptor.dart';
import 'package:quotes/core/api/dio_consumer.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/data/datasources/random_quote_local_data_source.dart';
import 'package:quotes/features/data/datasources/random_quote_remote_data_source.dart';
import 'package:quotes/features/data/repositories/quote_repository_impl.dart';
import 'package:quotes/features/domain/repositories/quote_repository.dart';
import 'package:quotes/features/domain/usecases/get_random_quote.dart';
import 'package:quotes/features/presentation/cubit/random_quote_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /* ** features ** */
  //Blocs
  sl.registerFactory(() => RandomQuoteCubit(getRandomQuoteUseCase: sl()));

  //use case
  sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl()));

  //Repository
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
      networkInfo: sl(),
      randomQuoteRemoteDataSource: sl(),
      randomQuoteLocalDataSource: sl()));

  //data sources
  sl.registerLazySingleton<RandomQuoteLocalDataSource>(() => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RandomQuoteRemoteDataSource>(() => RandomQuoteRemoteDataSourceImpl(apiConsumer: sl()));

  /* ** core ** */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
  /* ** external ** */
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseHeader: true,
    responseBody: true,
    error: true,
  ));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}