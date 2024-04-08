import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zoho/src/data/datasource/local/sqflite.dart';
import 'package:zoho/src/presentation/provider/langProvider.dart';
import 'package:zoho/src/presentation/views/User/login.dart';

void main() {
  ProjectDataSource db = ProjectDataSource();
  WidgetsFlutterBinding.ensureInitialized();
  db.initDB();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: ref.watch(languageProvider),
          home: LoginScreen(),
      );
  }
}