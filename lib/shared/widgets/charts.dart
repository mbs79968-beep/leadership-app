import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/models.dart';

/// Line chart for weekly improvement / leadership progression.
class ProgressLineChart extends StatelessWidget {
  final List<TrendPoint> points;
  final Color color;
  final double height;

  const ProgressLineChart({
    super.key,
    required this.points,
    this.color = AppColors.electric,
    this.height = 160,
  });

  @override
  Widget build(BuildContext context) {
    final spots = [
      for (int i = 0; i < points.length; i++)
        FlSpot(i.toDouble(), points[i].value),
    ];

    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 25,
            getDrawingHorizontalLine: (_) =>
                const FlLine(color: AppColors.steel, strokeWidth: 0.5),
          ),
          titlesData: FlTitlesData(
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 26,
                interval: 1,
                getTitlesWidget: (v, _) {
                  final i = v.toInt();
                  if (i < 0 || i >= points.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(points[i].label,
                        style: AppType.mono(9, color: AppColors.textFaint)),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.35,
              barWidth: 3,
              gradient: AppColors.accentGradient,
              dotData: FlDotData(
                show: true,
                getDotPainter: (s, _, __, ___) => FlDotCirclePainter(
                    radius: 3,
                    color: AppColors.glowBlue,
                    strokeWidth: 0),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color.withOpacity(0.25), color.withOpacity(0)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Radar chart for the 5 leadership skills.
class SkillRadarChart extends StatelessWidget {
  final List<Skill> skills;
  const SkillRadarChart({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: RadarChart(
        RadarChartData(
          radarShape: RadarShape.polygon,
          radarBackgroundColor: Colors.transparent,
          borderData: FlBorderData(show: false),
          radarBorderData: const BorderSide(color: AppColors.steel, width: 1),
          gridBorderData: const BorderSide(color: AppColors.steel, width: 0.5),
          tickBorderData: const BorderSide(color: Colors.transparent),
          tickCount: 4,
          ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 0),
          titlePositionPercentageOffset: 0.15,
          getTitle: (i, _) => RadarChartTitle(
            text: skills[i].name.split(' ').first,
            positionPercentageOffset: 0.05,
          ),
          titleTextStyle: AppType.label(9.5, color: AppColors.silver),
          dataSets: [
            RadarDataSet(
              fillColor: AppColors.electric.withOpacity(0.18),
              borderColor: AppColors.electric,
              borderWidth: 2,
              entryRadius: 3,
              dataEntries:
                  skills.map((s) => RadarEntry(value: s.value)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Circular score ring used on the Feedback screen.
class ScoreRing extends StatelessWidget {
  final double value; // 0..100
  final double size;
  final String label;

  const ScoreRing(
      {super.key, required this.value, required this.label, this.size = 130});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.intensity(100 - value); // higher = greener
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: value / 100),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOutCubic,
            builder: (_, v, __) => SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: v,
                strokeWidth: 9,
                backgroundColor: AppColors.slate,
                valueColor: AlwaysStoppedAnimation(color),
                strokeCap: StrokeCap.round,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${value.toInt()}',
                  style: AppType.mono(34, color: AppColors.platinum)),
              Text(label.toUpperCase(), style: AppType.label(9)),
            ],
          ),
        ],
      ),
    );
  }
}
