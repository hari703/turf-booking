import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../models/manager_model.dart'; 

class ManagersScreen extends StatefulWidget {
  const ManagersScreen({super.key});

  @override
  ManagersScreenState createState() => ManagersScreenState();
}

class ManagersScreenState extends State<ManagersScreen> {
  List<ManagerModel> managers = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchManagers();
  }

  Future<void> fetchManagers() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/admin/managers'));

      if (response.statusCode == 200) {
        final List managerList = json.decode(response.body);
        setState(() {
          managers = managerList.map((manager) => ManagerModel.fromJson(manager)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load managers');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  Future<void> addManager(String name, String email, String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/admin/addManager'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({'name': name, 'email': email, 'phone': phone, 'password': password}),
      );
      if (response.statusCode == 201) {
        fetchManagers();
        _showDialog('Success', 'Manager added successfully!');
      } else {
        _showDialog('Error', 'Failed to add manager. Please try again.');
      }
    } catch (e) {
      _showDialog('Error', 'Unexpected error occurred: $e');
    }
  }

  Future<void> updateManager(String id, String name, String email, String phone) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:3000/api/admin/updateManager/$id'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({'name': name, 'email': email, 'phone': phone}),
      );
      if (response.statusCode == 200) {
        fetchManagers();
        _showDialog('Success', 'Manager updated successfully!');
      } else {
        _showDialog('Error', 'Failed to update manager. Please try again.');
      }
    } catch (e) {
      _showDialog('Error', 'Unexpected error occurred: $e');
    }
  }

  Future<void> deleteManager(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://localhost:3000/api/admin/deleteManager/$id'),
      );
      if (response.statusCode == 200) {
        fetchManagers();
        _showDialog('Success', 'Manager deleted successfully!');
      } else {
        _showDialog('Error', 'Failed to delete manager. Please try again.');
      }
    } catch (e) {
      _showDialog('Error', 'Unexpected error occurred: $e');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showAddManagerDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Manager'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
              TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Phone')),
              TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  addManager(nameController.text, emailController.text, phoneController.text, passwordController.text);
                  Navigator.of(context).pop();
                } else {
                  _showDialog('Error', 'Please fill in all fields!');
                }
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showEditManagerDialog(ManagerModel manager) {
    final TextEditingController nameController = TextEditingController(text: manager.name);
    final TextEditingController emailController = TextEditingController(text: manager.email);
    final TextEditingController phoneController = TextEditingController(text: manager.phone);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Manager'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
              TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Phone')),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty) {
                  updateManager(manager.id, nameController.text, emailController.text, phoneController.text);
                  Navigator.of(context).pop();
                } else {
                  _showDialog('Error', 'Please fill in all fields!');
                }
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Managers'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: showAddManagerDialog),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text('Error loading data: $errorMessage'))
              : managers.isEmpty
                  ? const Center(child: Text('No managers found.'))
                  : ListView.builder(
                      itemCount: managers.length,
                      itemBuilder: (context, index) {
                        var manager = managers[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(child: Text(manager.name[0])),
                            title: Text(manager.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(manager.email),
                                Text(manager.phone),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(icon: const Icon(Icons.edit), onPressed: () => showEditManagerDialog(manager)),
                                IconButton(icon: const Icon(Icons.delete), onPressed: () => deleteManager(manager.id)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
