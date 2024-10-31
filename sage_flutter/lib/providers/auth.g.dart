// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionManagerHash() => r'a1c89a392857990a2504a8a64870abb13347cfce';

/// See also [sessionManager].
@ProviderFor(sessionManager)
final sessionManagerProvider = FutureProvider<SessionManager>.internal(
  sessionManager,
  name: r'sessionManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SessionManagerRef = FutureProviderRef<SessionManager>;
String _$authControllerHash() => r'eb00ef43925f6e7045b9e5e9f76f0414f68a3a86';

/// See also [authController].
@ProviderFor(authController)
final authControllerProvider =
    AutoDisposeProvider<EmailAuthController>.internal(
  authController,
  name: r'authControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthControllerRef = AutoDisposeProviderRef<EmailAuthController>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
