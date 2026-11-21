import 'package:flutter/material.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  static const Color primaryColor = Color(0xFF385CF2);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    final faqs = [
      {'question': l.faqTrackOrderQuestion, 'answer': l.faqTrackOrderAnswer},
      {'question': l.faqCancelOrderQuestion, 'answer': l.faqCancelOrderAnswer},
      {'question': l.faqAddFavoriteQuestion, 'answer': l.faqAddFavoriteAnswer},
      {
        'question': l.faqChangePersonalInfoQuestion,
        'answer': l.faqChangePersonalInfoAnswer,
      },
      {
        'question': l.faqChangePasswordQuestion,
        'answer': l.faqChangePasswordAnswer,
      },
      {
        'question': l.faqPaymentMethodsQuestion,
        'answer': l.faqPaymentMethodsAnswer,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.helpSupport,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Icon(Icons.support_agent, color: Colors.white, size: 55),
                const SizedBox(height: 14),
                Text(
                  l.howCanWeHelp,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l.helpDescription,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          Text(
            l.frequentlyAskedQuestions,
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          ...faqs.map(
            (faq) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: colors.outline.withValues(alpha: 0.12),
                ),
              ),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                iconColor: primaryColor,
                collapsedIconColor: colors.onSurfaceVariant,
                title: Text(
                  faq['question']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      faq['answer']!,
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.outline.withValues(alpha: 0.12)),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.headset_mic_outlined,
                  color: primaryColor,
                  size: 35,
                ),
                const SizedBox(height: 10),
                Text(
                  l.stillNeedHelp,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l.contactSupportDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          final dialogL = AppLocalizations.of(dialogContext)!;

                          return AlertDialog(
                            title: Text(dialogL.contactSupport),
                            content: Text(dialogL.supportDetailsComingSoon),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                },
                                child: Text(dialogL.supportDialogOk),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.support_agent),
                    label: Text(l.contactSupport),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: const BorderSide(color: primaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
