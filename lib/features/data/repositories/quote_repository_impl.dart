import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/data/datasources/random_quote_local_data_source.dart';
import 'package:quotes/features/domain/entities/quote.dart';
import 'package:quotes/features/domain/repositories/quote_repository.dart';

import '../../../core/network/network_info.dart';
import '../datasources/random_quote_remote_data_source.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final NetworkInfo networkInfo;
  final RandomQuoteRemoteDataSource randomQuoteRemoteDataSource;
  final RandomQuoteLocalDataSource randomQuoteLocalDataSource;

  QuoteRepositoryImpl(
      {required this.networkInfo,
      required this.randomQuoteRemoteDataSource,
      required this.randomQuoteLocalDataSource});

  @override
  Future<Either<Failure, Quote>> getRandomQuote() async{
    // if(await networkInfo.isConnected){
      try{
        final remoteRandomQuote = await randomQuoteRemoteDataSource.getRandomQuote();
        randomQuoteLocalDataSource.cacheQuote(remoteRandomQuote);
        return Right(remoteRandomQuote);
      }on ServerException{
        return Left(ServerFailure());
      }
    // }
    // else{
    //   try{
    //     final localRandomQuote = await randomQuoteLocalDataSource.getLastRandomQuote();
    //     return Right(localRandomQuote);
    //   }on CacheException{
    //     return Left(CacheFailure());
    //   }
    // }
  }
}
