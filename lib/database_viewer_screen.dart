import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' hide context;

class DatabaseViewerScreen extends StatefulWidget {
  const DatabaseViewerScreen({Key? key}) : super(key: key);

  @override
  State<DatabaseViewerScreen> createState() => _DatabaseViewerScreenState();
}

class _DatabaseViewerScreenState extends State<DatabaseViewerScreen> {
  bool _isLoading = true;
  // Map of Database Name -> List of Table Names
  Map<String, List<String>> _databasesAndTables = {};
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadDatabases();
  }

  Future<void> _loadDatabases() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final dbPath = await getDatabasesPath();
      final dir = Directory(dbPath);
      
      if (!await dir.exists()) {
        setState(() {
          _isLoading = false;
          _errorMessage = "No database directory found for this app.";
        });
        return;
      }

      final List<FileSystemEntity> files = dir.listSync();
      Map<String, List<String>> dbData = {};

      for (var file in files) {
        if (file is File) {
          final fileName = basename(file.path);
          
          // Skip journal and wal files which are temporary SQLite files
          if (!fileName.endsWith('-journal') && !fileName.endsWith('-wal') && !fileName.endsWith('-shm')) {
            try {
              // Open database in read-only mode to prevent locks
              final db = await openDatabase(file.path, readOnly: true);
              
              // Query the sqlite_master table to get all user-created tables
              final List<Map<String, dynamic>> tables = await db.rawQuery(
                "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"
              );
              
              dbData[fileName] = tables.map((t) => t['name'] as String).toList();
              await db.close();
            } catch (e) {
              // If the file is not a valid SQLite database, skip it silently
              debugPrint("Skipped $fileName: not a valid database.");
            }
          }
        }
      }

      setState(() {
        _databasesAndTables = dbData;
        _isLoading = false;
      });

    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Databases Viewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDatabases,
            tooltip: 'Refresh Databases',
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text('Error: $_errorMessage', style: const TextStyle(color: Colors.red)))
              : _databasesAndTables.isEmpty
                  ? const Center(
                      child: Text(
                        'No SQLite databases found in this app.\n(System databases belonging to other apps cannot be read due to Android sandboxing).',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _databasesAndTables.length,
                      itemBuilder: (context, index) {
                        String dbName = _databasesAndTables.keys.elementAt(index);
                        List<String> tables = _databasesAndTables[dbName]!;
                        
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          elevation: 3,
                          child: ExpansionTile(
                            leading: const Icon(Icons.storage, color: Colors.blueAccent),
                            title: Text(dbName, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('${tables.length} tables available'),
                            children: tables.isEmpty 
                                ? [const ListTile(title: Text('No tables found', style: TextStyle(fontStyle: FontStyle.italic)))]
                                : tables.map((table) => ListTile(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 32.0),
                                    leading: const Icon(Icons.table_chart_outlined, size: 20),
                                    title: Text(table),
                                  )).toList(),
                          ),
                        );
                      },
                    ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createDummyDatabase,
        icon: const Icon(Icons.add),
        label: const Text("Create Test DB"),
      ),
    );
  }

  // Helper method to create a dummy database so the user can test the screen
  Future<void> _createDummyDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'test_database_${DateTime.now().millisecondsSinceEpoch}.db');
      
      Database db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          // Create a couple of dummy tables
          await db.execute('CREATE TABLE Users (id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
          await db.execute('CREATE TABLE Orders (id INTEGER PRIMARY KEY, item_name TEXT, price REAL)');
          await db.execute('CREATE TABLE Settings (id INTEGER PRIMARY KEY, theme TEXT)');
        },
      );
      
      await db.close();
      
      // Refresh the screen to show the new database
      _loadDatabases();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dummy database created successfully!'), backgroundColor: Colors.green),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create DB: $e'), backgroundColor: Colors.red),
      );
    }
  }
}
