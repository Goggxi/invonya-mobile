import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StaticFunction {
  StaticFunction._();

  static Options newsApiHttpOptions() {
    return Options(headers: {"Authorization": "Bearer ${dotenv.env['NEWS_API_KEY']}"});
  }

}
