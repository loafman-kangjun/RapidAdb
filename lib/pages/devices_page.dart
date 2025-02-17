import 'package:flutter/material.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  Future<Map<String, String>> _fetchDeviceInfo() async {
    // 模拟异步获取设备信息
    await Future.delayed(const Duration(seconds: 2));
    return {
      'CPU': 'Snapdragon 888',
      'GPU': 'Adreno 660',
      'RAM': '8GB',
      'ROM': '128GB',
      '型号': 'Pixel 6',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设备信息'),
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _fetchDeviceInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('获取设备信息失败'));
          } else if (snapshot.hasData) {
            final deviceInfo = snapshot.data!;
            return ListView(
              children: deviceInfo.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key),
                  subtitle: Text(entry.value),
                );
              }).toList(),
            );
          } else {
            return const Center(child: Text('没有设备信息'));
          }
        },
      ),
    );
  }
}