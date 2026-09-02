import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SmsInboxScreen(),
    );
  }
}

class SmsInboxScreen extends StatefulWidget {
  const SmsInboxScreen({super.key});

  @override
  State<SmsInboxScreen> createState() => _SmsInboxScreenState();
}

class _SmsInboxScreenState extends State<SmsInboxScreen> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];

  @override
  void initState() {
    super.initState();
  }

  // Request runtime permission and fetch messages if granted
  Future<void> _fetchSmsMessages() async {
    // Check current permission status
    var permissionStatus = await Permission.sms.status;

    if (permissionStatus.isDenied) {
      // Prompt user for permission
      permissionStatus = await Permission.sms.request();
    }

    if (permissionStatus.isGranted) {
      // Fetch messages from the inbox
      try {
        final List<SmsMessage> messages = await _query.querySms(
          kinds: [SmsQueryKind.inbox], // Scopes to the inbox folder
          count: 50,                   // Limit the number of pulled messages
        );
        setState(() {
          _messages = messages;
        });
      } catch (e) {
        debugPrint("Error fetching SMS: $e");
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      // Guide the user to system settings if permission is permanently blocked
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS Reader Example'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _fetchSmsMessages,
              child: const Text('Load Inbox Messages'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _messages.isEmpty
                  ? const Center(child: Text('No messages loaded Click the button above'))
                  : ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(message.address ?? 'Unknown Sender', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(message.body ?? ''),
                      trailing: Text(message.date != null ? message.date!.toLocal().toString().substring(0, 16) : ''),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
