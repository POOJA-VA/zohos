import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho/src/presentation/provider/langProvider.dart';

class Language extends ConsumerStatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  ConsumerState<Language> createState() => _LanguageState();
}

class _LanguageState extends ConsumerState<Language> {
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
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
        ),
      ),
    );
  }

  String _getLanguageName(Locale locale) {
    if (locale.languageCode == 'en') {
      return 'En';
    } else if (locale.languageCode == 'tr') {
      return 'Tu';
    } else if (locale.languageCode == 'fr') {
      return 'Fr';
    }
    return '';
  }
}