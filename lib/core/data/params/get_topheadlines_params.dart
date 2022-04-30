import 'package:equatable/equatable.dart';

class GetTopHeadlinesParams extends Equatable {
  final String country;
  final String category;
  final String pageSize;
  final String page;

  const GetTopHeadlinesParams({
    required this.country,
    required this.category,
    required this.pageSize,
    required this.page,
  });

  @override
  List<Object?> get props => [country, pageSize, page];
}
