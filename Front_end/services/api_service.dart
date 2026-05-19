import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 10.0.2.2 points back to your local computer's localhost from the Android Emulator
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // --- GESTION DES TÂCHES ---
  Future<List<dynamic>> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tasks/'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error fetching tasks: $e');
    }
    return [];
  }

  Future<bool> createNewTask(String title, String description) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tasks/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "title": title,
          "description": description,
          "status": "todo"
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error creating task: $e');
      return false;
    }
  }

  // --- CHRONOLOGIES ---
  Future<List<dynamic>> fetchTimeline() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/timeline/'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error fetching timeline: $e');
    }
    return [];
  }

  // --- USER PROFILE INFORMATION ---
  Future<Map<String, dynamic>?> fetchUserProfile(int profileId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/profile/$profileId/'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error fetching profile: $e');
    }
    return null;
  }

  Future<bool> updateUserProfile(int profileId, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/profile/$profileId/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }
}