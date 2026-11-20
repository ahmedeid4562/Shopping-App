import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  static const Color primaryColor = Color(0xFF385CF2);
  static const String _storageKey = 'payment_methods';

  List<Map<String, dynamic>> _methods = [];
  bool _isLoading = true;

  AppLocalizations get l => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    _loadMethods();
  }

  Future<void> _loadMethods() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMethods = prefs.getStringList(_storageKey) ?? [];

    if (!mounted) return;

    setState(() {
      _methods = savedMethods
          .map((item) => Map<String, dynamic>.from(jsonDecode(item)))
          .toList();
      _isLoading = false;
    });
  }

  Future<void> _saveMethods() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      _storageKey,
      _methods.map((item) => jsonEncode(item)).toList(),
    );
  }

  Future<void> _showPaymentDialog({int? index}) async {
    final isEditing = index != null;
    final method = isEditing ? _methods[index] : null;

    final nameController = TextEditingController(
      text: method?['name']?.toString() ?? '',
    );

    final lastFourController = TextEditingController(
      text: method?['lastFour']?.toString() ?? '',
    );

    final expiryController = TextEditingController(
      text: method?['expiry']?.toString() ?? '',
    );

    final formKey = GlobalKey<FormState>();

    bool isDefault = method?['isDefault'] ?? _methods.isEmpty;

    try {
      await showDialog(
        context: context,
        builder: (dialogContext) {
          final dialogL = AppLocalizations.of(dialogContext)!;

          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                title: Text(
                  isEditing
                      ? dialogL.editPaymentMethod
                      : dialogL.addPaymentMethod,
                ),
                content: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: dialogL.cardholderName,
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return dialogL.enterCardholderName;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: lastFourController,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          decoration: InputDecoration(
                            labelText: dialogL.lastFourDigits,
                            prefixIcon: const Icon(Icons.credit_card),
                            counterText: '',
                          ),
                          validator: (value) {
                            if (value == null ||
                                !RegExp(r'^\d{4}$').hasMatch(value)) {
                              return dialogL.enterExactlyFourDigits;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: expiryController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            labelText: dialogL.expiryDate,
                            hintText: 'MM/YY',
                            prefixIcon: const Icon(Icons.calendar_month),
                          ),
                          validator: (value) {
                            if (value == null ||
                                !RegExp(r'^(0[1-9]|1[0-2])/\d{2}$')
                                    .hasMatch(value.trim())) {
                              return dialogL.useMmYyFormat;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(dialogL.setAsDefault),
                          value: isDefault,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            setDialogState(() {
                              isDefault = value ?? false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text(dialogL.cancel),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      final newMethod = {
                        'name': nameController.text.trim(),
                        'lastFour': lastFourController.text.trim(),
                        'expiry': expiryController.text.trim(),
                        'isDefault': isDefault,
                      };

                      setState(() {
                        if (isDefault) {
                          for (final item in _methods) {
                            item['isDefault'] = false;
                          }
                        }

                        if (isEditing) {
                          _methods[index] = newMethod;
                        } else {
                          _methods.add(newMethod);
                        }

                        if (_methods.length == 1) {
                          _methods.first['isDefault'] = true;
                        }
                      });

                      await _saveMethods();

                      if (!mounted || !dialogContext.mounted) return;

                      Navigator.pop(dialogContext);
                    },
                    child: Text(
                      isEditing ? dialogL.saveChanges : dialogL.addCard,
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    } finally {
      nameController.dispose();
      lastFourController.dispose();
      expiryController.dispose();
    }
  }

  Future<void> _setDefault(int index) async {
    setState(() {
      for (int i = 0; i < _methods.length; i++) {
        _methods[i]['isDefault'] = i == index;
      }
    });

    await _saveMethods();
  }

  Future<void> _deleteMethod(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final dialogL = AppLocalizations.of(dialogContext)!;

        return AlertDialog(
          title: Text(dialogL.deleteCard),
          content: Text(dialogL.deletePaymentConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(dialogL.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(
                dialogL.deleteAction,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true) return;

    setState(() {
      final wasDefault = _methods[index]['isDefault'] == true;

      _methods.removeAt(index);

      if (wasDefault && _methods.isNotEmpty) {
        _methods.first['isDefault'] = true;
      }
    });

    await _saveMethods();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.paymentMethods,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showPaymentDialog(),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(l.addCard),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _methods.isEmpty
              ? _buildEmptyState(colors)
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
                  itemCount: _methods.length,
                  itemBuilder: (context, index) {
                    return _buildPaymentCard(index, colors);
                  },
                ),
    );
  }

  Widget _buildEmptyState(ColorScheme colors) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.credit_card_outlined,
              size: 75,
              color: colors.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              l.noPaymentMethods,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l.addPaymentDescription,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(int index, ColorScheme colors) {
    final method = _methods[index];
    final isDefault = method['isDefault'] == true;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDefault
              ? primaryColor
              : colors.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 42,
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.credit_card,
                    color: primaryColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        method['name']?.toString() ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '•••• ${method['lastFour']}',
                        style: TextStyle(
                          color: colors.onSurfaceVariant,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showPaymentDialog(index: index);
                    } else if (value == 'delete') {
                      _deleteMethod(index);
                    } else if (value == 'default') {
                      _setDefault(index);
                    }
                  },
                  itemBuilder: (context) => [
                    if (!isDefault)
                      PopupMenuItem(
                        value: 'default',
                        child: Text(l.setAsDefault),
                      ),
                    PopupMenuItem(
                      value: 'edit',
                      child: Text(l.edit),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text(
                        l.deleteAction,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Text(
                  '${l.expires}: ${method['expiry']}',
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                if (isDefault)
                  Chip(
                    label: Text(
                      l.defaultAddress,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                    backgroundColor: primaryColor,
                    side: BorderSide.none,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}