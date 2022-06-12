import 'package:dartz/dartz.dart';
import '../../../core/usecases/usecase.dart';
import '../../../features/domain/repositories/quote_repository.dart';

import '../../../core/error/failures.dart';
import '../entities/quote.dart';

class GetRandomQuote implements UseCase<Quote, NoParams>{
  final QuoteRepository quoteRepository;

  GetRandomQuote({required this.quoteRepository});

  @override
  Future<Either<Failure, Quote>> call(NoParams params)=>
      quoteRepository.getRandomQuote();
}