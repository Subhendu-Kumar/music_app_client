import 'package:hive/hive.dart';
import 'package:client/my_app.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:client/features/auth/view_model/auth_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationOngoing: true,
    androidNotificationChannelName: 'Audio playback',
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  );
  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  await container.read(authViewModelProvider.notifier).getCurrentUser();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}
