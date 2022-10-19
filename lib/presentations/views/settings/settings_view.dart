import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/core/constraints/constraints.dart';
import 'package:water_reminder/presentations/controllers/controllers.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        backgroundColor: Palette.scaffold,
        foregroundColor: Palette.foregroundColor,
        elevation: 0.0,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: GetX<WaterReminderController>(builder: (controller) {
            return ListView(
              children: [
                ListTile(
                  title: const Text(
                    'Mục tiêu',
                    style: TextStyle(color: Palette.foregroundColor),
                  ),
                  subtitle: Text(
                    'Hầu hết mọi người cần 2000 ml mỗi ngày.',
                    style: TextStyle(color: Palette.foregroundColor.withOpacity(0.5)),
                  ),
                  trailing: DropdownButton<int>(
                    value: controller.target.value,
                    style: const TextStyle(color: Palette.foregroundColor),
                    dropdownColor: Palette.scaffold,
                    onChanged: (target) => controller.changeTarget(target ?? 500),
                    items: [
                      for (int i = 500; i < 5001; i += 500)
                        DropdownMenuItem(
                          value: i,
                          child: Text('$i ml'),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      backgroundColor: Palette.scaffold,
    );
  }
}
