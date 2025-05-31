// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listAllSongsHash() => r'45f68a0af8548cf3743f2c51c0db13d13013c863';

/// See also [listAllSongs].
@ProviderFor(listAllSongs)
final listAllSongsProvider =
    AutoDisposeFutureProvider<List<SongModel>>.internal(
  listAllSongs,
  name: r'listAllSongsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$listAllSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ListAllSongsRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$listAllFavSongsHash() => r'7146e8678780be58346b32946c93cff6dcea7a62';

/// See also [listAllFavSongs].
@ProviderFor(listAllFavSongs)
final listAllFavSongsProvider =
    AutoDisposeFutureProvider<List<SongModel>>.internal(
  listAllFavSongs,
  name: r'listAllFavSongsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$listAllFavSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ListAllFavSongsRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$homeViewModelHash() => r'5b05e92902c889ee3bf3df56fb74c128328bc532';

/// See also [HomeViewModel].
@ProviderFor(HomeViewModel)
final homeViewModelProvider =
    AutoDisposeNotifierProvider<HomeViewModel, AsyncValue?>.internal(
  HomeViewModel.new,
  name: r'homeViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
