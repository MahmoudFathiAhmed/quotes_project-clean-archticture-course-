import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String author;
  final int id;
  final String content;
  final String permaLink;

  const Quote(
      {required this.author,
      required this.id,
      required this.content,
      required this.permaLink});

  @override
  List<Object?> get props => throw UnimplementedError();
}
