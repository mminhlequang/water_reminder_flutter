import 'package:flutter/material.dart';
import 'package:water_reminder/core/constraints/constraints.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class RoundedWaveWidget extends StatelessWidget {
  const RoundedWaveWidget({
    Key? key,
    required this.current,
    required this.max,
    required this.size,
    this.foregroundColor,
  }) : super(key: key);

  final int current;
  final int max;
  final double size;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: Colors.white.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(size / 2),
      ),
      clipBehavior: Clip.hardEdge,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Stack(
          children: [
            _buildWaveWidget(),
            _buildLabel(),
            _buildBottleOfWater(),
          ],
        ),
      ),
    );
  }

  Align _buildBottleOfWater() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Image.asset(
          'assets/images/ic_bottle.png',
          width: 30,
          height: 30,
        ),
      ),
    );
  }

  Center _buildLabel() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$current',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: foregroundColor,
            ),
          ),
          Text(
            '/$max',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: foregroundColor,
            ),
          )
        ],
      ),
    );
  }

  WaveWidget _buildWaveWidget() {
    return WaveWidget(
      config: CustomConfig(
        colors: [
          Palette.blue,
          Palette.lighterBlue,
        ],
        durations: [5000, 4000],
        heightPercentages: [0.9 - (current / max) - 0.005, 0.9 - (current / max)],
      ),
      backgroundColor: Palette.scaffold,
      size: const Size(double.infinity, double.infinity),
      waveAmplitude: 0,
    );
  }
}
