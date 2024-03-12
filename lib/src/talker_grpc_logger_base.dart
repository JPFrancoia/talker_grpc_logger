/// Implements a gRPC interceptor that logs requests and responses to Talker.
/// https://pub.dev/documentation/grpc/latest/grpc/ClientInterceptor-class.html

import 'package:talker/talker.dart';
import 'package:grpc/grpc.dart';

class TalkerHttpLogger extends ClientInterceptor {
  TalkerHttpLogger({Talker? talker}) {
    _talker = talker ?? Talker();
  }

  late Talker _talker;

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    print('interceptUnary');
    print(method);
    print("PATH: ${method.path}");
    print("REQUEST: $request");
    // return invoker(method, request, options);
    final response = invoker(method, request, options);
    response.then((r) {
      print(r.runtimeType);
      print('got response: $r');
    });
    return response;
  }

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
      ClientMethod<Q, R> method,
      Stream<Q> requests,
      CallOptions options,
      ClientStreamingInvoker<Q, R> invoker) {
    print('interceptStreaming');

    return invoker(method, requests, options);
  }
}
