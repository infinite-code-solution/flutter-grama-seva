import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_filex/open_filex.dart';

class FileBrowserScreen extends StatefulWidget {
  const FileBrowserScreen({Key? key}) : super(key: key);

  @override
  State<FileBrowserScreen> createState() => _FileBrowserScreenState();
}

class _FileBrowserScreenState extends State<FileBrowserScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  bool _isLoading = true;
  List<FileSystemEntity> _allFiles = [];
  
  // Categorized files
  final List<FileSystemEntity> _images = [];
  final List<FileSystemEntity> _docs = [];
  final List<FileSystemEntity> _audios = [];
  final List<FileSystemEntity> _videos = [];
  final List<FileSystemEntity> _others = [];

  // Search controllers for each tab
  final List<TextEditingController> _searchControllers = List.generate(5, (_) => TextEditingController());
  
  // Active search queries
  List<String> _searchQueries = ['', '', '', '', ''];

  final List<String> _tabs = ['Images', 'Docs', 'Audio', 'Video', 'Others'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    
    // Listen to tab changes to clear search or manage state if needed
    _tabController.addListener(() {
      setState(() {});
    });

    for (int i = 0; i < _searchControllers.length; i++) {
      _searchControllers[i].addListener(() {
        setState(() {
          _searchQueries[i] = _searchControllers[i].text.toLowerCase();
        });
      });
    }

    _requestPermissionAndLoadFiles();
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var controller in _searchControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _requestPermissionAndLoadFiles() async {
    bool isGranted = false;

    if (Platform.isAndroid) {
      // For Android 11+ (API 30+), manageExternalStorage is needed for non-media files
      var manageStatus = await Permission.manageExternalStorage.status;
      if (!manageStatus.isGranted) {
        manageStatus = await Permission.manageExternalStorage.request();
      }
      
      // Fallback for older Android versions or if manage is not granted
      var storageStatus = await Permission.storage.status;
      if (!storageStatus.isGranted) {
        storageStatus = await Permission.storage.request();
      }

      // If we are on Android 13+, we might also need these
      await Permission.photos.request();
      await Permission.videos.request();
      await Permission.audio.request();

      isGranted = manageStatus.isGranted || storageStatus.isGranted;
    } else {
      var status = await Permission.storage.request();
      isGranted = status.isGranted;
    }

    if (isGranted) {
      await _loadFiles();
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission is required to display files. Please enable it in Settings.')),
        );
        // Optionally open app settings
        openAppSettings();
      }
    }
  }

  Future<void> _loadFiles() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Directory dir = Directory('/storage/emulated/0/');
      _allFiles.clear();
      await _listDir(dir);
      
      _categorizeFiles();
    } catch (e) {
      debugPrint("Error loading files: $e");
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _listDir(Directory dir) async {
    try {
      var entities = dir.listSync(recursive: false, followLinks: false);
      for (var entity in entities) {
        if (entity is File) {
          _allFiles.add(entity);
        } else if (entity is Directory) {
          // Skip restricted Android directories
          String path = entity.path.toLowerCase();
          if (path.endsWith('/android/data') || path.endsWith('/android/obb')) {
            continue;
          }
          // Recursively list subdirectories
          await _listDir(entity);
        }
      }
    } catch (e) {
      // Ignore directories that we don't have permission to access
    }
  }

  void _categorizeFiles() {
    _images.clear();
    _docs.clear();
    _audios.clear();
    _videos.clear();
    _others.clear();

    final imageExts = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
    final docExts = ['.pdf', '.doc', '.docx', '.xls', '.xlsx', '.ppt', '.pptx', '.txt'];
    final audioExts = ['.mp3', '.wav', '.aac', '.flac', '.m4a'];
    final videoExts = ['.mp4', '.mkv', '.avi', '.mov', '.flv', '.wmv'];

    for (var file in _allFiles) {
      String path = file.path.toLowerCase();
      
      // Skip hidden files and Android system directories to speed things up
      if (path.contains('/.') || path.contains('/android/data/')) {
        continue;
      }

      String ext = '';
      int extIndex = path.lastIndexOf('.');
      if (extIndex >= 0) {
        ext = path.substring(extIndex);
      }

      if (imageExts.contains(ext)) {
        _images.add(file);
      } else if (docExts.contains(ext)) {
        _docs.add(file);
      } else if (audioExts.contains(ext)) {
        _audios.add(file);
      } else if (videoExts.contains(ext)) {
        _videos.add(file);
      } else {
        _others.add(file);
      }
    }

    // Sort all categorized lists by last modified (newest first)
    int compareModified(FileSystemEntity a, FileSystemEntity b) {
      try {
        return b.statSync().modified.compareTo(a.statSync().modified);
      } catch (e) {
        return 0;
      }
    }

    _images.sort(compareModified);
    _docs.sort(compareModified);
    _audios.sort(compareModified);
    _videos.sort(compareModified);
    _others.sort(compareModified);
  }

  List<FileSystemEntity> _getFilteredFiles(List<FileSystemEntity> files, String query) {
    if (query.isEmpty) return files;
    return files.where((file) {
      String fileName = file.path.split('/').last.toLowerCase();
      return fileName.contains(query);
    }).toList();
  }

  Widget _buildFileList(List<FileSystemEntity> files, int tabIndex) {
    List<FileSystemEntity> filteredFiles = _getFilteredFiles(files, _searchQueries[tabIndex]);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchControllers[tabIndex],
            decoration: InputDecoration(
              hintText: 'Search ${_tabs[tabIndex]}...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchControllers[tabIndex].text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchControllers[tabIndex].clear();
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        Expanded(
          child: filteredFiles.isEmpty
              ? const Center(child: Text('No files found'))
              : (tabIndex == 0 // Images tab
                  ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: filteredFiles.length,
                      itemBuilder: (context, index) {
                        File file = filteredFiles[index] as File;
                        return GestureDetector(
                          onTap: () {
                            OpenFilex.open(file.path);
                          },
                          child: Image.file(
                            file,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 50),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: filteredFiles.length,
                      itemBuilder: (context, index) {
                        File file = filteredFiles[index] as File;
                        String fileName = file.path.split('/').last;
                        
                        IconData iconData;
                        switch (tabIndex) {
                          case 1: iconData = Icons.description; break;
                          case 2: iconData = Icons.audiotrack; break;
                          case 3: iconData = Icons.video_library; break;
                          default: iconData = Icons.insert_drive_file; break;
                        }

                        return ListTile(
                          leading: Icon(iconData, color: Theme.of(context).primaryColor),
                          title: Text(fileName, maxLines: 1, overflow: TextOverflow.ellipsis),
                          subtitle: Text(file.parent.path, maxLines: 1, overflow: TextOverflow.ellipsis),
                          onTap: () {
                            OpenFilex.open(file.path);
                          },
                        );
                      },
                    )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Storage Explorer'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Scanning device storage... This may take a moment.")
                ],
              ),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                _buildFileList(_images, 0),
                _buildFileList(_docs, 1),
                _buildFileList(_audios, 2),
                _buildFileList(_videos, 3),
                _buildFileList(_others, 4),
              ],
            ),
    );
  }
}
