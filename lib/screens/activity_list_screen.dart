import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/activity_provider.dart';
import '../widgets/activity_card.dart';

class ActivityListScreen extends StatefulWidget {
  const ActivityListScreen({super.key});

  @override
  State<ActivityListScreen> createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends State<ActivityListScreen> {
  String searchQuery = '';
  String selectedCategory = 'Semua';
  String selectedStatus = 'Semua';

  final List<String> categories = ['Semua', 'Pemrograman', 'Matematika', 'Bahasa Inggris', 'Desain', 'Basis Data'];
  final List<String> statuses = ['Semua', 'Selesai', 'Belum Selesai'];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActivityProvider>(context);
    final filteredList = provider.searchAndFilter(searchQuery, selectedCategory, selectedStatus);

    return Scaffold(
      body: Container(
        // background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A1584),
              Color(0xFF7B2CBF),
              Color(0xFFE8D7FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // HEADER & APPBAR CUSTOM
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Daftar Aktivitas ♡',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    onChanged: (val) => setState(() => searchQuery = val),
                    style: const TextStyle(color: Color(0xFF2A085C)),
                    decoration: const InputDecoration(
                      hintText: 'Cari Aktivitas',
                      hintStyle: TextStyle(color: Color(0xFF4A1078)),
                      prefixIcon: Icon(Icons.search, color: Color(0xFF8E24AA)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // FILTER DROPDOWN
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    // Dropdown Kategori
                    Expanded(
                      child: _buildFilterDropdown(
                        icon: Icons.grid_view_rounded,
                        value: selectedCategory,
                        items: categories,
                        onChanged: (val) => setState(() => selectedCategory = val!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Dropdown Status
                    Expanded(
                      child: _buildFilterDropdown(
                        icon: Icons.filter_alt_outlined,
                        value: selectedStatus,
                        items: statuses,
                        onChanged: (val) => setState(() => selectedStatus = val!),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: filteredList.isEmpty
                    ? const Center(
                  child: Text(
                    'Tidak ada aktivitas ditemukan.',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                )
                    : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 80.0),
                  itemCount: filteredList.length,
                  itemBuilder: (ctx, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ActivityCard(activity: filteredList[i]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // TOMBOL TAMBAH AKTIVITAS
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFD81B60),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
        onPressed: () => context.push('/add-edit'),
      ),
    );
  }

  Widget _buildFilterDropdown({
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF6C2BD9)),
          isExpanded: true,
          style: const TextStyle(
            color: Color(0xFF2A085C),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  Icon(icon, size: 18, color: const Color(0xFF6C2BD9)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}