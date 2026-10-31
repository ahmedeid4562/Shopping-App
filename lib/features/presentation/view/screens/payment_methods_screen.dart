import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    final nameController = TextEditingController(text: method?['name'] ?? '');

    final lastFourController = TextEditingController(
      text: method?['lastFour'] ?? '',
    );

    final expiryController = TextEditingController(
      text: method?['expiry'] ?? '',
    );

    final formKey = GlobalKey<FormState>();

    bool isDefault = method?['isDefault'] ?? _methods.isEmpty;

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                isEditing ? 'Edit Payment Method' : 'Add Payment Method',
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Cardholder Name',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter cardholder name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: lastFourController,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: const InputDecoration(
                          labelText: 'Last 4 Digits',
                          prefixIcon: Icon(Icons.credit_card),
                          counterText: '',
                        ),
                        validator: (value) {
                          if (value == null ||
                              !RegExp(r'^\d{4}$').hasMatch(value)) {
                            return 'Enter exactly 4 digits';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: expiryController,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          labelText: 'Expiry Date',
                          hintText: 'MM/YY',
                          prefixIcon: Icon(Icons.calendar_month),
                        ),
                        validator: (value) {
                          if (value == null ||
                              !RegExp(r'^(0[1-9]|1[0-2])/\d{2}$')
                                  .hasMatch(value.trim())) {
                            return 'Use MM/YY format';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Set as default'),
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
                  child: const Text('Cancel'),
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
                  child: Text(isEditing ? 'Save Changes' : 'Add Card'),
                ),
              ],
            );
          },
        );
      },
    );

    nameController.dispose();
    lastFourController.dispose();
    expiryController.dispose();
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
      builder: (context) => AlertDialog(
        title: const Text('Delete Card'),
        content: const Text(
          'Are you sure you want to delete this payment method?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

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
        title: const Text(
          'Payment Methods',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showPaymentDialog(),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Card'),
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

            const Text(
              'No Payment Methods Yet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              'Add a payment method to manage your cards.',
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
                        method['name'],
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
                      const PopupMenuItem(
                        value: 'default',
                        child: Text('Set as Default'),
                      ),

                    const PopupMenuItem(value: 'edit', child: Text('Edit')),

                    const PopupMenuItem(
                      value: 'delete',
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
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
                  'Expires: ${method['expiry']}',
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),

                const Spacer(),

                if (isDefault)
                  const Chip(
                    label: Text(
                      'Default',
                      style: TextStyle(color: Colors.white, fontSize: 11),
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
