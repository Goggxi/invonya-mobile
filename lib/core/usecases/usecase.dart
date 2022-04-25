import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Stream<Either<Failure, Type>> build(Params params);

  Stream<Either<Failure, Type>> execute(Params params) {
    return build(params).onErrorResume((error, stackTrace) {
      Failure failure;

      if (error is DioError) {
        final res = jsonDecode(error.response.toString());
        failure = ServerFailure(message: "${res['message']}");
      } else {
        failure = AnotherFailure(message: "$error");
      }

      return Stream.value(Left(failure));
    });
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
