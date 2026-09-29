import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../models/activity.dart';
import '../providers/activity_provider.dart';

class AddEditActivityScreen extends StatefulWidget {
  final Activity? activity;

  const AddEditActivityScreen({super.key, this.activity});

  @override
  State<AddEditActivityScreen> createState() => _AddEditActivityScreenState();
}

class _AddEditActivityScreenState extends State<AddEditActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String category;
  late String description;
  late bool isFavorite;

  final List<String> categories = [
    'Pemrograman',
    'Matematika',
    'Bahasa Inggris',
    'Desain',
    'Basis Data',
  ];

  @override
  void initState() {
    super.initState();
    title = widget.activity?.title ?? '';
    category = widget.activity?.category ?? categories.first;
    description = widget.activity?.description ?? '';
    isFavorite = widget.activity?.isFavorite ?? false;
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final provider = Provider.of<ActivityProvider>(context, listen: false);

      if (widget.activity == null) {
        // Tambah Aktivitas Baru
        final newActivity = Activity(
          id: DateTime.now().toString(),
          title: title,
          category: category,
          description: description,
          isFavorite: isFavorite,
        );
        provider.addActivity(newActivity);
      } else {
        // Edit Aktivitas
        final updatedActivity = Activity(
          id: widget.activity!.id,
          title: title,
          category: category,
          description: description,
          isCompleted: widget.activity!.isCompleted,
          isFavorite: isFavorite,
        );
        provider.updateActivity(updatedActivity);
      }
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.activity != null;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6B3BA7),
              Color(0xFF4A1E80),
              Color(0xFF2A085C),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => context.pop(),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isEditing ? 'Edit Aktivitas' : 'Tambah Aktivitas',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Label: Judul Aktivitas
                          const Text(
                            'Judul Aktivitas',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),

                          TextFormField(
                            initialValue: title,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70, width: 1.5),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                                  color: isFavorite ? Colors.pinkAccent : Colors.white70,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isFavorite = !isFavorite;
                                  });
                                },
                              ),
                            ),
                            validator: (val) =>
                            val == null || val.isEmpty ? 'Judul tidak boleh kosong' : null,
                            onSaved: (val) => title = val!,
                          ),

                          const SizedBox(height: 32),

                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBE4EB), // Warna krem/pink sof
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Kategori',
                                  style: TextStyle(
                                    color: Color(0xFF4A1078),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: category,
                                    isExpanded: true,
                                    icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF2A085C)),
                                    style: const TextStyle(
                                      color: Color(0xFF2A085C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    dropdownColor: const Color(0xFFFBE4EB),
                                    items: categories.map((cat) {
                                      return DropdownMenuItem(
                                        value: cat,
                                        child: Text(cat),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() => category = val);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Label: Deskripsi
                          const Text(
                            'Deskripsi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Input Text Field:Deskripsi
                          TextFormField(
                            initialValue: description,
                            maxLines: 3,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70, width: 1.5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            onSaved: (val) => description = val ?? '',
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Tombol Batal & Simpan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Batal
                      OutlinedButton(
                        onPressed: () => context.pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          side: const BorderSide(color: Colors.white, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Batal',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Simpan
                      ElevatedButton(
                        onPressed: _saveForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFBE4EB),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                            color: Color(0xFF2A085C),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}