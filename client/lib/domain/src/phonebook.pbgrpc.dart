//
//  Generated code. Do not modify.
//  source: phonebook.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'phonebook.pb.dart' as $0;

export 'phonebook.pb.dart';

@$pb.GrpcServiceName('phonebook.PhonebookService')
class PhonebookServiceClient extends $grpc.Client {
  static final _$getNumberByName = $grpc.ClientMethod<$0.NameRequest, $0.NumberResponse>(
      '/phonebook.PhonebookService/GetNumberByName',
      ($0.NameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.NumberResponse.fromBuffer(value));

  PhonebookServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.NumberResponse> getNumberByName($0.NameRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNumberByName, request, options: options);
  }
}

@$pb.GrpcServiceName('phonebook.PhonebookService')
abstract class PhonebookServiceBase extends $grpc.Service {
  $core.String get $name => 'phonebook.PhonebookService';

  PhonebookServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.NameRequest, $0.NumberResponse>(
        'GetNumberByName',
        getNumberByName_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.NameRequest.fromBuffer(value),
        ($0.NumberResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.NumberResponse> getNumberByName_Pre($grpc.ServiceCall call, $async.Future<$0.NameRequest> request) async {
    return getNumberByName(call, await request);
  }

  $async.Future<$0.NumberResponse> getNumberByName($grpc.ServiceCall call, $0.NameRequest request);
}
