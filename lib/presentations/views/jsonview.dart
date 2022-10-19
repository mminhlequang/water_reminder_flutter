import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:water_reminder/data/models/app_database_manager.dart';

class WidgetJson extends StatelessWidget {
  const WidgetJson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List>(
            future: AppDatabaseManager.instance.fetchAll(),
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox();
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: snapshot.data!
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            jsonEncode(e),
                            textAlign: TextAlign.center,
                          ),
                        ))
                    .toList(),
              );
            }),
      ),
    );
  }
}
