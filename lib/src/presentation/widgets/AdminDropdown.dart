import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho/src/presentation/provider/langProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminLanguage extends ConsumerStatefulWidget {
  const AdminLanguage({Key? key}) : super(key: key);

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends ConsumerState<AdminLanguage> {
  late Locale _selectedLanguage;
  late List<Locale> _availableLanguages;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = ref.read(languageProvider);
    _availableLanguages = [
      const Locale('en'),
      const Locale('tr'),
      const Locale('fr'),
      const Locale('ja'),
      const Locale('hi'),
    ];
  }

  String _getLanguageName(Locale locale) {
    if (locale.languageCode == 'en') {
      return 'En';
    } else if (locale.languageCode == 'tr') {
      return 'Tr';
    } else if (locale.languageCode == 'fr') {
      return 'Fr';
    } else if (locale.languageCode == 'ja') {
      return 'Ja';
    } else if (locale.languageCode == 'hi') {
      return 'Hi';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.adminLang),
        actions: [
          DropdownButton<Locale>(
            value: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
              ref.read(languageProvider.notifier).changeLocale(value!);
            },
            items: _availableLanguages
                .map<DropdownMenuItem<Locale>>((Locale value) {
              return DropdownMenuItem<Locale>(
                value: value,
                child: Text(
                  _getLanguageName(value),
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.admin,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.admins,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}