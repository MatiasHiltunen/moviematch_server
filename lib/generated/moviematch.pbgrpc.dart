//
//  Generated code. Do not modify.
//  source: moviematch.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'moviematch.pb.dart' as $0;

export 'moviematch.pb.dart';

@$pb.GrpcServiceName('MovieMatch')
class MovieMatchClient extends $grpc.Client {
  static final _$streamState = $grpc.ClientMethod<$0.StateMessage, $0.StateMessage>(
      '/MovieMatch/StreamState',
      ($0.StateMessage value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.StateMessage.fromBuffer(value));

  MovieMatchClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$0.StateMessage> streamState($async.Stream<$0.StateMessage> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamState, request, options: options);
  }
}

@$pb.GrpcServiceName('MovieMatch')
abstract class MovieMatchServiceBase extends $grpc.Service {
  $core.String get $name => 'MovieMatch';

  MovieMatchServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StateMessage, $0.StateMessage>(
        'StreamState',
        streamState,
        true,
        true,
        ($core.List<$core.int> value) => $0.StateMessage.fromBuffer(value),
        ($0.StateMessage value) => value.writeToBuffer()));
  }

  $async.Stream<$0.StateMessage> streamState($grpc.ServiceCall call, $async.Stream<$0.StateMessage> request);
}
