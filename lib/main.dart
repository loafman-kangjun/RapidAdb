import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

// 导航控制器
class NavigationController extends GetxController {
  var selectedIndex = 0.obs;
  
  void changePage(int index) {
    selectedIndex.value = index;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Desktop Navigation Demo',
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

// 示例页面
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('首页'),
    );
  }
}

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('设备页面'),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('设置页面'),
    );
  }
}