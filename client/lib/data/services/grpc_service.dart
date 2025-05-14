import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:client/data/services/phonebook_service.dart';
import 'package:client/domain/src/phonebook.pbgrpc.dart';

final grpcServiceProvider = ChangeNotifierProvider((ref) => GrpcService());

/// GrpcService for interacting with gRPC server
class GrpcService with ChangeNotifier {
  factory GrpcService() {
    return _instance;
  }

  GrpcService._internal();
  static final GrpcService _instance = GrpcService._internal();
  String _baseUrl = 'localhost';
  // String _baseUrl = '10.91.53.236';

  final int _port = 50051;
  final PhonebookService _phonebookService = PhonebookService();

  String get baseUrl => _baseUrl;
  int get port => _port;
  PhonebookService get phonebookService => _phonebookService;

  bool isConnected = false;

  set baseUrl(String value) {
    _baseUrl = value;
    _instance.init();
  }
/// Function to create channel for gRPC
  Future<ClientChannel> createChannel([String? baseUrl, int? port]) async {
    const channelOptions = ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      connectionTimeout: Duration(seconds: 3),
    );
    final channel = ClientChannel(
      baseUrl ?? _baseUrl,
      port: port ?? _port,
      options: channelOptions,
    );

    final client = PhonebookServiceClient(channel);
    // test request for checking connection
    try {
      await client
          .getNumberByName(NameRequest(name: 'ping'))
          .timeout(const Duration(seconds: 2));
      isConnected = true;
      print("Connected succersfully");
      notifyListeners();
    } catch (e) {
      print('Error: gRPC test call failed with $e');
      isConnected = false;
      notifyListeners();
    }

    return channel;
  }
  /// Function to initialize gRPC
  Future<void> init({String? baseUrl}) async {
    if (baseUrl != null) {
      _baseUrl = baseUrl;
    }
    await _phonebookService.init();
    notifyListeners();
  }
}
