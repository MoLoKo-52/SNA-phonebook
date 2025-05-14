//
//  Generated code. Do not modify.
//  source: phonebook.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use nameRequestDescriptor instead')
const NameRequest$json = {
  '1': 'NameRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `NameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nameRequestDescriptor = $convert.base64Decode(
    'CgtOYW1lUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');

@$core.Deprecated('Use numberResponseDescriptor instead')
const NumberResponse$json = {
  '1': 'NumberResponse',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'number', '3': 2, '4': 1, '5': 9, '10': 'number'},
    {'1': 'found', '3': 3, '4': 1, '5': 8, '10': 'found'},
    {'1': 'signature', '3': 4, '4': 1, '5': 9, '10': 'signature'},
  ],
};

/// Descriptor for `NumberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List numberResponseDescriptor = $convert.base64Decode(
    'Cg5OdW1iZXJSZXNwb25zZRISCgRuYW1lGAEgASgJUgRuYW1lEhYKBm51bWJlchgCIAEoCVIGbn'
    'VtYmVyEhQKBWZvdW5kGAMgASgIUgVmb3VuZBIcCglzaWduYXR1cmUYBCABKAlSCXNpZ25hdHVy'
    'ZQ==');

