import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finlink/providers/network_provider.dart';

class NetworkStatusBar extends StatelessWidget {
  const NetworkStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final networkProvider = Provider.of<NetworkProvider>(context);
    final isConnected = networkProvider.isConnected;

    // If connected, don't show anything
    if (isConnected) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      color: Colors.red,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(width: 8),
          Text(
            'No internet connection',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
