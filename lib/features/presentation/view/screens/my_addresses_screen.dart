import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAddressesScreen extends StatefulWidget {
  const MyAddressesScreen({super.key});

  @override
  State<MyAddressesScreen> createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  static const Color primaryColor = Color(0xFF385CF2);
  static const String _storageKey = 'user_addresses';

  List<Map<String, dynamic>> _addresses = [];
  bool _isLoading = true;
  bool _isAddressDialogOpen = false;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAddresses = prefs.getStringList(_storageKey) ?? [];

    if (!mounted) return;

    setState(() {
      _addresses = savedAddresses
          .map((item) => Map<String, dynamic>.from(jsonDecode(item)))
          .toList();

      _isLoading = false;
    });
  }

  Future<void> _saveAddresses() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      _storageKey,
      _addresses.map((item) => jsonEncode(item)).toList(),
    );
  }

  Future<void> _showAddressDialog({int? index}) async {
    if (_isAddressDialogOpen) return;

    _isAddressDialogOpen = true;

    try {
      final isEditing = index != null;
      final address = isEditing ? _addresses[index] : null;

      final result = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (_) {
          return AddressDialog(
            isEditing: isEditing,
            address: address,
            initiallyDefault:
                address?['isDefault'] as bool? ?? _addresses.isEmpty,
          );
        },
      );

      if (!mounted || result == null) return;

      setState(() {
        if (result['isDefault'] == true) {
          for (final item in _addresses) {
            item['isDefault'] = false;
          }
        }

        if (isEditing) {
          _addresses[index] = result;
        } else {
          _addresses.add(result);
        }

        if (_addresses.length == 1) {
          _addresses.first['isDefault'] = true;
        }
      });

      await _saveAddresses();
    } finally {
      _isAddressDialogOpen = false;
    }
  }

  Future<void> _deleteAddress(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Address'),
          content: const Text('Are you sure you want to delete this address?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true) return;

    setState(() {
      final wasDefault = _addresses[index]['isDefault'] == true;

      _addresses.removeAt(index);

      if (wasDefault && _addresses.isNotEmpty) {
        _addresses.first['isDefault'] = true;
      }
    });

    await _saveAddresses();
  }

  Future<void> _setDefault(int index) async {
    setState(() {
      for (int i = 0; i < _addresses.length; i++) {
        _addresses[i]['isDefault'] = i == index;
      }
    });

    await _saveAddresses();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Addresses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isAddressDialogOpen ? null : () => _showAddressDialog(),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Address'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _addresses.isEmpty
          ? _buildEmptyState(colors)
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                return _buildAddressCard(index, colors);
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
              Icons.location_on_outlined,
              size: 75,
              color: colors.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            const Text(
              'No Addresses Yet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Add your address to make checkout easier.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(int index, ColorScheme colors) {
    final address = _addresses[index];
    final isDefault = address['isDefault'] == true;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: primaryColor.withValues(alpha: 0.1),
                  child: Icon(
                    address['name'].toString().toLowerCase() == 'home'
                        ? Icons.home_outlined
                        : Icons.location_on_outlined,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    address['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isDefault)
                  const Chip(
                    label: Text(
                      'Default',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                    backgroundColor: primaryColor,
                    side: BorderSide.none,
                  ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showAddressDialog(index: index);
                    } else if (value == 'delete') {
                      _deleteAddress(index);
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
            const SizedBox(height: 12),
            Text(
              address['street'],
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
            const SizedBox(height: 5),
            Text(
              address['city'],
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
            const SizedBox(height: 5),
            Text(
              address['phone'],
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressDialog extends StatefulWidget {
  final bool isEditing;
  final Map<String, dynamic>? address;
  final bool initiallyDefault;

  const AddressDialog({
    super.key,
    required this.isEditing,
    this.address,
    required this.initiallyDefault,
  });

  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  static const Color primaryColor = Color(0xFF385CF2);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late bool _isDefault;

  String _name = '';
  String _phone = '';
  String _city = '';
  String _street = '';

  @override
  void initState() {
    super.initState();

    _isDefault = widget.initiallyDefault;
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    Navigator.of(context).pop({
      'name': _name,
      'phone': _phone,
      'city': _city,
      'street': _street,
      'isDefault': _isDefault,
    });
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required ValueChanged<String?> onSaved,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }

          return null;
        },
        onSaved: onSaved,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEditing ? 'Edit Address' : 'Add New Address'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                label: 'Address Name',
                hint: 'Home, Work...',
                initialValue: widget.address?['name']?.toString() ?? '',
                onSaved: (value) {
                  _name = value?.trim() ?? '';
                },
              ),
              _buildTextField(
                label: 'Phone Number',
                keyboardType: TextInputType.phone,
                initialValue: widget.address?['phone']?.toString() ?? '',
                onSaved: (value) {
                  _phone = value?.trim() ?? '';
                },
              ),
              _buildTextField(
                label: 'City',
                initialValue: widget.address?['city']?.toString() ?? '',
                onSaved: (value) {
                  _city = value?.trim() ?? '';
                },
              ),
              _buildTextField(
                label: 'Street Address',
                maxLines: 2,
                initialValue: widget.address?['street']?.toString() ?? '',
                onSaved: (value) {
                  _street = value?.trim() ?? '';
                },
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Set as default address'),
                value: _isDefault,
                activeColor: primaryColor,
                onChanged: (value) {
                  setState(() {
                    _isDefault = value ?? false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
          ),
          onPressed: _submit,
          child: Text(widget.isEditing ? 'Save Changes' : 'Add Address'),
        ),
      ],
    );
  }
}
