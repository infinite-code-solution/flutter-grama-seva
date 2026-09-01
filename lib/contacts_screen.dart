import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
      return;
    }

    final contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: false);
    setState(() => _contacts = contacts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_permissionDenied) {
      return const Center(child: Text('Permission denied to access contacts'));
    }
    if (_contacts == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_contacts!.isEmpty) {
      return const Center(child: Text('No contacts found'));
    }

    return ListView.builder(
      itemCount: _contacts!.length,
      itemBuilder: (context, i) {
        final contact = _contacts![i];
        final phone = contact.phones.isNotEmpty ? contact.phones.first.number : '(No phone number)';
        return ListTile(
          leading: CircleAvatar(
            child: Text(contact.displayName.isNotEmpty ? contact.displayName[0].toUpperCase() : '?'),
          ),
          title: Text(contact.displayName),
          subtitle: Text(phone),
        );
      },
    );
  }
}
