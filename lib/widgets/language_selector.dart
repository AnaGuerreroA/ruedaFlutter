import 'package:flutter/material.dart';
import '../main.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language, size: 24),
      tooltip: 'Cambiar idioma / Change language',
      onSelected: (Locale locale) {
        MyApp.setLocale(context, locale);
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<Locale>(
          value: Locale('es'),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🇪🇸', style: TextStyle(fontSize: 20)),
              SizedBox(width: 8),
              Text('Español'),
            ],
          ),
        ),
        const PopupMenuItem<Locale>(
          value: Locale('en'),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🇺🇸', style: TextStyle(fontSize: 20)),
              SizedBox(width: 8),
              Text('English'),
            ],
          ),
        ),
      ],
    );
  }
}
