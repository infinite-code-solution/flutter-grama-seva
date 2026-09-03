import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';

class SimsScreen extends StatefulWidget {
  const SimsScreen({Key? key}) : super(key: key);

  @override
  _SimsScreenState createState() => _SimsScreenState();
}

class _SimsScreenState extends State<SimsScreen> {
  String _mobileNumber = '';
  List<SimCard> _simCard = <SimCard>[];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
    
    initMobileNumberState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }

    String mobileNumber = '';
    List<SimCard> simCards = <SimCard>[];
    
    try {
      mobileNumber = (await MobileNumber.mobileNumber) ?? '';
      simCards = (await MobileNumber.getSimCards) ?? <SimCard>[];
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    if (!mounted) return;

    setState(() {
      _mobileNumber = mobileNumber;
      _simCard = simCards;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIM Details'),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator()) 
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Number of SIMs: ${_simCard.length}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: _simCard.isEmpty
                    ? const Center(
                        child: Text(
                          'No SIM cards found or permission denied.',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _simCard.length,
                        itemBuilder: (context, index) {
                          final sim = _simCard[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: ListTile(
                              leading: const Icon(Icons.sim_card, color: Colors.blue),
                              title: Text(sim.carrierName ?? 'Unknown Network'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Phone Number: ${sim.number ?? 'Unknown'}'),
                                  Text('Country ISO: ${sim.countryPhonePrefix ?? 'Unknown'}'),
                                  Text('Slot Index: ${sim.slotIndex}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
    );
  }
}
