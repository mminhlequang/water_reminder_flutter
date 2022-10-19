import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:water_reminder/data/models/app_database_manager.dart';
import 'package:water_reminder/data/models/models.dart';
import 'package:water_reminder/utils/utils.dart';

class WaterReminderController extends GetxController {
  // late SharedPreferences _preferences;
  RxInt selectedIndex = 0.obs;
  RxInt target = 0.obs;

  ValueNotifier<List<DailyDrinkRecord>> dailyRecords = ValueNotifier([]);

  @override
  void onInit() async {
    Config? config = await AppDatabaseManager.instance.fetchConfig();
    selectedIndex.value = config?.capacityChooserIndex ?? 3;
    int savedTarget = config?.target ?? 2000;
    changeTarget(savedTarget);
    await _fetchRecords();
    super.onInit();
  }

  _fetchRecords() async {
    List<DailyDrinkRecord> records =
        await AppDatabaseManager.instance.fetchLogs();
    dailyRecords.value = records;
    dailyRecords.notifyListeners();
    print('dailyRecords.value:${dailyRecords.value.length} ');
  }

  void changeSelectedCapacityChooserIndex(int index) {
    selectedIndex.value = index;
    // _preferences.setInt('capacityChooserIndex', index);
    AppDatabaseManager.instance.changeConfig({'capacityChooserIndex': index});
  }

  void changeTarget(int target) {
    this.target.value = target;
    // _preferences.setInt('target', target);
    AppDatabaseManager.instance.changeConfig({'target': target});
    getTodayRecord().target = target;
  }

  DailyDrinkRecord getTodayRecord() {
    return dailyRecords.value.firstWhere(
      (dailyRecord) => DateTimeUtils.isToday(dailyRecord.date),
      orElse: () {
        DailyDrinkRecord today = DailyDrinkRecord(
          id: Random().nextInt(899999) + 100000,
          target: target.value,
          records: [],
          date: DateTime.now(),
        );
        dailyRecords.value.add(today);
        return today;
      },
    );
  }

  void addDrinkRecord(int capacity) async {
    await AppDatabaseManager.instance.insertLog({
      'id': Uuid().v1(),
      "capacity": capacity,
      'datetime': DateTime.now().millisecondsSinceEpoch
    });
    _fetchRecords();
    // dailyRecords
    //     .firstWhere((record) => DateTimeUtils.isToday(record.date))
    //     .records
    //     .add(
    //       DrinkRecord(
    //         id: Random().nextInt(899999) + 100000,
    //         capacity: capacity,
    //         time: TimeOfDay.now(),
    //       ),
    //     );
    // dailyRecords.refresh();
  }

  List<ChartData?> generateChartDatas() {
    List<ChartData?> chartDatas = List.filled(7, null);
    DateTime firstDayOfWeek =
        DateTimeUtils.dateOnly(DateTimeUtils.getSartAndEndDayOfWeek()[0]);

    for (int i = 0; i < 7; i++) {
      DailyDrinkRecord record = dailyRecords.value.firstWhere(
        (record) => DateTimeUtils.compareYMD(
            firstDayOfWeek, DateTimeUtils.dateOnly(record.date)),
        orElse: () =>
            DailyDrinkRecord(target: 2000, records: [], date: firstDayOfWeek),
      );
      chartDatas[i] = ChartData(
        DateTimeUtils.isToday(record.date)
            ? 'Today'
            : DateTimeUtils.nameOfDay(record.date),
        record,
      );
      firstDayOfWeek = firstDayOfWeek.add(const Duration(days: 1));
    }

    return chartDatas;
  }

  int getWeekAverage() {
    return generateChartDatas().fold(
        0,
        (previousValue, chartData) =>
            previousValue + (chartData?.record?.totalCapacity as int));
  }

  void deleteDrinkRecord(DrinkRecord record) async {
    // getTodayRecord().records.removeWhere((r) => r.id == record.id);
    await AppDatabaseManager.instance.deleteLog(record.id);
    _fetchRecords();
  }
}
