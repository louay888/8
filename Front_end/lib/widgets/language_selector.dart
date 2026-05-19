import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentLocale = Localizations.localeOf(context);

    return PopupMenuButton<Locale>(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _getLanguageFlag(currentLocale.languageCode),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white.withOpacity(0.7),
              size: 18,
            ),
          ],
        ),
      ),
      onSelected: (Locale locale) {
        CartoVecApp.setLocale(context, locale);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.languageChanged),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
        PopupMenuItem<Locale>(
          value: const Locale('fr'),
          child: Row(
            children: [
              const Text('🇫🇷', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Text(
                l10n.french,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              if (currentLocale.languageCode == 'fr') ...[
                const Spacer(),
                const Icon(Icons.check, color: Color(0xFF0d6b78)),
              ],
            ],
          ),
        ),
        PopupMenuItem<Locale>(
          value: const Locale('ar'),
          child: Row(
            children: [
              const Text('🇸🇦', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Text(
                l10n.arabic,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              if (currentLocale.languageCode == 'ar') ...[
                const Spacer(),
                const Icon(Icons.check, color: Color(0xFF0d6b78)),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _getLanguageFlag(String code) {
    switch (code) {
      case 'fr':
        return '🇫🇷';
      case 'ar':
        return '🇸🇦';
      default:
        return '🌐';
    }
  }
}
