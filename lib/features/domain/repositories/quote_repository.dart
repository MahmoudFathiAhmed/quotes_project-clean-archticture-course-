
import 'package:dartz/dartz.dart';
import 'package:quotes/features/domain/entities/quote.dart';

import '../../../core/error/failures.dart';

abstract class QuoteRepository{
Future<Either<Failure, Quote>> getRandomQuote();
}