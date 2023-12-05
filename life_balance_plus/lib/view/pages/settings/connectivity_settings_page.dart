import 'package:flutter/material.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/data/model/session.dart';

class ConnectivitySettingsPage extends StatefulWidget {
  const ConnectivitySettingsPage({super.key});

  @override
  State<ConnectivitySettingsPage> createState() =>
      _ConnectivitySettingsPageState();
}

class _ConnectivitySettingsPageState extends State<ConnectivitySettingsPage> {
  bool? enableWifi = true;
  bool? enableMobileData = false;
  bool? enableBluetooth = true;
  bool? enableNFC = false;
  bool? enableLocationServices = true;

  @override
  void initState() {
    super.initState();

    // Get user data from account
    Account? account = Session.instance.account;
    if (account != null) {
      enableWifi = account.useWifi;
      enableMobileData = account.useMobileData;
      enableBluetooth = account.useBluetooth;
      enableNFC = account.useNFC;
      enableLocationServices = account.useLocation;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectivity Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Wi-Fi'),
            CheckboxListTile(
              title: const Text('Enable Wi-Fi'),
              value: enableWifi,
              onChanged: (value) {
                setState(() {
                  enableWifi = value;
                });
              },
            ),
            const Divider(),
            const Text('Mobile Data'),
            CheckboxListTile(
              title: const Text('Enable Mobile Data'),
              value: enableMobileData,
              onChanged: (value) {
                setState(() {
                  enableMobileData = value;
                });
              },
            ),
            const Divider(),
            const Text('Bluetooth'),
            CheckboxListTile(
              title: const Text('Enable Bluetooth'),
              value: enableBluetooth,
              onChanged: (value) {
                setState(() {
                  enableBluetooth = value;
                });
              },
            ),
            const Divider(),
            const Text('NFC (Near Field Communication)'),
            CheckboxListTile(
              title: const Text('Enable NFC'),
              value: enableNFC,
              onChanged: (value) {
                setState(() {
                  enableNFC = value;
                });
              },
            ),
            const Divider(),
            const Text('Location Services'),
            CheckboxListTile(
              title: const Text('Enable Location Services'),
              value: enableLocationServices,
              onChanged: (value) {
                setState(() {
                  enableLocationServices = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Session.instance.account?.updateAccountInfo(
                  useWifi: enableWifi,
                  useMobileData: enableMobileData,
                  useBluetooth: enableBluetooth,
                  useNFC: enableNFC,
                  useLocation: enableLocationServices,
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
