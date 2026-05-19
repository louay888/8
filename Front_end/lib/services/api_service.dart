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

  Future<bool> createTimelineEvent(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/timeline/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error creating timeline event: $e');
      return false;
    }
  }

// --- USER PROFILE INFORMATION ---
  Future<List<dynamic>> fetchProfiles() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/profile/'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error fetching profiles: $e');
    }
    return [];
  }

  Future<bool> createProfile(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/profile/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode != 201) {
        print('Error creating profile (Status ${response.statusCode}): ${response.body}');
      }
      return response.statusCode == 201;
    } catch (e) {
      print('Error creating profile: $e');
      return false;
    }
  }

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
      if (response.statusCode != 200) {
        print('Error updating profile (Status ${response.statusCode}): ${response.body}');
      }
      return response.statusCode == 200;
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }

  // --- BIBLIOGRAPHY ENDPOINTS ---
  Future<List<dynamic>> fetchBibliography() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/bibliography/'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error fetching bibliography references: \$e');
    }
    return [];
  }

  Future<bool> createBibliographyEntry(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/bibliography/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error creating bibliography entry: \$e');
      return false;
    }
  }
}
