import 'package:flutter/material.dart';
import '../models/activity.dart';

class ActivityProvider extends ChangeNotifier {
  // Minimal 10 data dummy dengan ID unik dan kategori
  final List<Activity> _activities = [
    Activity(id: 'act-1', title: 'Belajar Flutter State Management', category: 'Pemrograman', description: 'Memahami penggunaan Provider'),
    Activity(id: 'act-2', title: 'Latihan Soal Matematika Dasar', category: 'Matematika', description: 'Mengerjakan latihan bab 3'),
    Activity(id: 'act-3', title: 'Membaca Grammar Basic', category: 'Bahasa Inggris', description: 'Mempelajari present continuous tense'),
    Activity(id: 'act-4', title: 'Membuat Desain App', category: 'Desain', description: 'Desain aplikasi Study Planner'),
    Activity(id: 'act-5', title: 'Review Materi Basis Data', category: 'Basis Data', description: 'Mempelajari SQL Join'),
    Activity(id: 'act-6', title: 'Persiapan Presentasi UTS', category: 'Pemrograman', description: 'Membuat slide presentasi'),
    Activity(id: 'act-7', title: 'Menulis Resume Jurnal', category: 'Bahasa Inggris', description: 'Meringkas artikel ilmiah'),
    Activity(id: 'act-8', title: 'Latihan Coding Dart Async', category: 'Pemrograman', description: 'Memahami Future, Stream, dan async-await'),
    Activity(id: 'act-9', title: 'Mengerjakan Tugas Vektor', category: 'Matematika', description: 'Latihan soal perkalian silang'),
    Activity(id: 'act-10', title: 'Setup Environment Android Studio', category: 'Pemrograman', description: 'Instalasi SDK dan konfigurasi emulator'),
  ];

  List<Activity> get activities => _activities;

  List<Activity> get favoriteActivities =>
      _activities.where((act) => act.isFavorite).toList();

  int get completedCount =>
      _activities.where((act) => act.isCompleted).length;

  // Pencarian & Filtering
  List<Activity> searchAndFilter(String query, String category, String status) {
    return _activities.where((act) {
      bool matchesQuery = act.title.toLowerCase().contains(query.toLowerCase()) ||
          act.description.toLowerCase().contains(query.toLowerCase());
      bool matchesCategory = category == 'Semua' || act.category == category;
      bool matchesStatus = status == 'Semua' ||
          (status == 'Selesai' && act.isCompleted) ||
          (status == 'Belum Selesai' && !act.isCompleted);

      return matchesQuery && matchesCategory && matchesStatus;
    }).toList();
  }

  Activity? findById(String id) {
    try {
      return _activities.firstWhere((act) => act.id == id);
    } catch (_) {
      return null;
    }
  }

  // CRUD Operations
  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  void updateActivity(Activity activity) {
    final index = _activities.indexWhere((act) => act.id == activity.id);
    if (index != -1) {
      _activities[index] = activity;
      notifyListeners();
    }
  }

  void deleteActivity(String id) {
    _activities.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final index = _activities.indexWhere((act) => act.id == id);
    if (index != -1) {
      _activities[index].isFavorite = !_activities[index].isFavorite;
      notifyListeners();
    }
  }

  void toggleStatus(String id) {
    final index = _activities.indexWhere((act) => act.id == id);
    if (index != -1) {
      _activities[index].isCompleted = !_activities[index].isCompleted;
      notifyListeners();
    }
  }
}