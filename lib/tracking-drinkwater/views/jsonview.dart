import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_json_viewer/flutter_json_viewer.dart';
import 'package:settings/tracking-drinkwater/models/app_prefs.dart';
import 'package:intl/intl.dart';

import '../models/app_database_manager.dart';

class WidgetJson extends StatelessWidget {
  const WidgetJson({super.key});

  int totalOfMonth(int month) {
    int total = 0;
    AppPrefs.instance.logs
        .where((e) =>
            DateFormat('/MM/yyyy').format(e.date) ==
            DateFormat('/MM/yyyy').format(DateTime(DateTime.now().year, month)))
        .forEach((e) {
      for (var e2 in e.records) {
        total += e2.capacity;
      }
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: JsonViewer({
            'capacityChooserIndex': AppPrefs.instance.capacityChooserIndex,
            'target': AppPrefs.instance.target,
            'logsOfYear': List.generate(
                12,
                (index) => {
                      'month': index + 1,
                      "total": totalOfMonth(index + 1),
                    }).toList(),
            'logs': AppPrefs.instance.logs
                .map((e) => {
                      'datetime': DateFormat('dd/MM/yyyy').format(e.date),
                      'records': e.records
                          .map((e) => {
                                'capacity': e.capacity,
                                'time': e.time.format(context)
                              })
                          .toList()
                    })
                .toList(),
          }),
        ),
      ),
    );
  }
}
