import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/navigation_controller.dart';
import 'pages/home_page.dart';
import 'pages/devices_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rapid ADB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DesktopHomePage(),
    );
  }
}

class DesktopHomePage extends StatelessWidget {
  const DesktopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 初始化导航控制器
    final NavigationController navigationController = Get.put(NavigationController());
    
    return Scaffold(
      body: Row(
        children: [
          // 侧边导航栏
          NavigationRail(
            extended: true,
            selectedIndex: navigationController.selectedIndex.value,
            onDestinationSelected: (int index) {
              navigationController.changePage(index);
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('首页'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.devices),
                label: Text('设备'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('设置'),
              ),
            ],
          ),
          // 垂直分割线
          const VerticalDivider(thickness: 1, width: 1),
          // 主要内容区域
          Expanded(
            child: Obx(() => _buildPage(navigationController.selectedIndex.value)),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const DevicesPage();
      case 2:
        return const SettingsPage();
      default:
        return const HomePage();
    }
  }
}