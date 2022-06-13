import 'package:quotes/core/api/end_point.dart';
import 'package:quotes/features/data/models/quote_model.dart';

import '../../../core/api/api_consumer.dart';


abstract class RandomQuoteRemoteDataSource{
  Future <QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource{
  ApiConsumer apiConsumer;
  RandomQuoteRemoteDataSourceImpl({required this.apiConsumer});
  @override
  Future<QuoteModel> getRandomQuote() async{
    final response = await apiConsumer.get(
        EndPoints.randomQuote,
    );
    return QuoteModel.fromJson(response);
  }

}