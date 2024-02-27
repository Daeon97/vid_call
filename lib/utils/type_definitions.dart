// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';

typedef RtcOperationInitiatorCallback<T> = Function0<Future<T>>;

typedef FailureHandlerCallback<L> = Function1<String, L>;

typedef OnVideoViewCreatedCallback = Function1<int, void>;
