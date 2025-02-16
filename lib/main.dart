import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
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
      // 设置初始命名路由
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => const DesktopHomePage(content: HomePage()),
        ),
        GetPage(
          name: '/devices',
          page: () => const DesktopHomePage(content: DevicesPage()),
        ),
        GetPage(
          name: '/settings',
          page: () => const DesktopHomePage(content: SettingsPage()),
        ),
      ],
    );
  }
}

class DesktopHomePage extends StatelessWidget {
  final Widget content;
  const DesktopHomePage({super.key, required this.content});

  // 根据当前路由决定 NavigationRail 的选中项
  int _getSelectedIndex() {
    switch (Get.currentRoute) {
      case '/home':
        return 0;
      case '/devices':
        return 1;
      case '/settings':
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _getSelectedIndex();

    return Scaffold(
      body: Row(
        children: [
          // 侧边导航栏
          NavigationRail(
            extended: true,
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              // 根据索引切换到对应的命名页面
              switch (index) {
                case 0:
                  if (Get.currentRoute != '/home') {
                    Get.toNamed('/home');
                  }
                  break;
                case 1:
                  if (Get.currentRoute != '/devices') {
                    Get.toNamed('/devices');
                  }
                  break;
                case 2:
                  if (Get.currentRoute != '/settings') {
                    Get.toNamed('/settings');
                  }
                  break;
              }
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
          const VerticalDivider(thickness: 1, width: 1),
          // 主要内容区域，展示传入的页面
          Expanded(child: content),
        ],
      ),
    );
  }
}

// 示例页面
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('首页'));
  }
}

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('设备页面'));
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('设置页面'));
  }
}
