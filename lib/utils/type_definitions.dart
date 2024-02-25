import 'package:dartz/dartz.dart';

typedef RtcOperationInitiatorCallback<T> = Function0<Future<T>>;

typedef FailureHandlerCallback<L> = Function1<String, L>;
