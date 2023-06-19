import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  ActivityScreen({super.key});

  List<Color> get availableColors =><Color>[
  ColorsManager.primary  ,
  ColorsManager.primary,
  ColorsManager.primary,
  ColorsManager.primary,
  ColorsManager.primary,
  ];

  final Color barBackgroundColor =
      ColorsManager.primary;
  final Color barColor = ColorsManager.black;
  final Color touchedBarColor = ColorsManager.white;

  @override
  State<StatefulWidget> createState() => ActivityScreenState();
  }

  class ActivityScreenState extends State<ActivityScreen> {
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;
  bool isPlaying = false;

  double Regularity =9.0;
  double Feeding =9.0;
  double Training =7.0;
  double Response =2.0;
  double Total =2.0;

  @override
  Widget build(BuildContext context) {
  return  Container(
      height: 300.0,
      width: double.infinity,
    decoration:BoxDecoration(
      borderRadius: const BorderRadiusDirectional.only(
          topEnd: Radius.circular(10),
          // ignore: prefer_const_constructors
          bottomStart: Radius.circular(10),
          topStart:Radius.circular(40.0),
          bottomEnd: Radius.circular(40.0,)
      ),
      color:ColorsManager.grey,
      backgroundBlendMode: BlendMode.screen,
    ) ,

      child: AspectRatio(
      aspectRatio: 1,
      child: Stack(
      children: <Widget>[
      Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
       Text(
      'Evaluation',
      style: TextStyle(
      color: ColorsManager.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      ),
      ),
      const SizedBox(
      height: 10,
      ),
      Text(
      '*Evaluation within a week',
      style: TextStyle(
      color: ColorsManager.primary,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      ),
      ),
      Text(
          '*Evaluation from your trainer',
          style: TextStyle(
            color: ColorsManager.primary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      const SizedBox(
      height: 30,
      ),
      Expanded(
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BarChart(
      isPlaying ? randomData() : mainBarData(),
      swapAnimationDuration: animDuration,
      ),
      ),
      ),
      const SizedBox(
      height: 12,
      ),
      ],
      ),
      ),
      ],
      ),
      ),
    );
  }
    BarChartGroupData makeGroupData(
      int x,
     double y, {
     bool isTouched = false,
     Color? barColor,
     double width = 25,
           List<int> showTooltips = const [],
  }) {
  barColor ??= widget.barColor;
  return BarChartGroupData(
  x: x,
  barRods: [
  BarChartRodData(
  toY: isTouched ? y +1 : y,
  color: isTouched ? widget.touchedBarColor : barColor,
  width: width,
  borderSide: isTouched
  ? BorderSide (color: ColorsManager.primary,)
      : const BorderSide(color: Colors.white, width: 0),
  backDrawRodData: BackgroundBarChartRodData(
  show: true,
  toY: 10,
  color: widget.barBackgroundColor,
  ),
  ),
  ],
  showingTooltipIndicators: showTooltips,
  );
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////
               List<BarChartGroupData> showingGroups() => List.generate(5, (i) {
  switch (i) {
  case 0:
  return makeGroupData(0,Regularity, isTouched: i == touchedIndex);
  case 1:
  return makeGroupData(1, Feeding, isTouched: i == touchedIndex);
  case 2:
  return makeGroupData(2, Training, isTouched: i == touchedIndex);
  case 3:
  return makeGroupData(3, Response, isTouched: i == touchedIndex);
  case 4:
  return makeGroupData(4, Total, isTouched: i == touchedIndex);
    case 5:
      return makeGroupData(5, 2, isTouched: i == touchedIndex);
  default:
  return throw Error();
  }
  });
                BarChartData mainBarData() {
                return BarChartData(
                barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: ColorsManager.grey,
                tooltipHorizontalAlignment: FLHorizontalAlignment.right,
                tooltipMargin: -10,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String weekDay;
                switch (group.x) {
                case 0:
                weekDay = 'regularity';
                break;
                case 1:
                weekDay = 'feeding';
                break;
                case 2:
                weekDay = 'training';
                break;
                case 3:
                weekDay = 'running';
                break;
                case 4:
                weekDay = 'response';
                break;
                case 5:
                  weekDay = 'The total';
                  break;

                default:
                throw Error();
                }
                return BarTooltipItem(
                '$weekDay\n',
                const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                ),
                children: <TextSpan>[
                TextSpan(
                text: (rod.toY - 1).toString(),
                style: TextStyle(
                color: widget.touchedBarColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                ),
                ),
                ],
                );
                },
                ),

                touchCallback: (FlTouchEvent event, barTouchResponse) {
                setState(() {
                if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
                touchedIndex = -1;
                return;
                }
                touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                });
                },
                ),
                titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                showTitles:  true,
                getTitlesWidget: getTitles,
               // reservedSize:25.0,
                ),
                ),
                leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                showTitles: false,
                ),
                ),
                ),
                borderData: FlBorderData(
                show: false,
                ),
                barGroups: showingGroups(),
                gridData: const FlGridData(show: false),
                );
                }
                 Widget getTitles(double value, TitleMeta meta) {
                const style = TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                );
                Widget text;
                switch (value.toInt()) {
                case 0:
                text = const Text('Regularity  ', style: style);
                break;
                case 1:
                text = const Text('Feeding', style: style);
                break;
                case 2:
                text = const Text('Training ', style: style);
                break;
                case 3:
                text = const Text(' Response', style: style);
                break;
                case 4:
                text = const Text('Total', style: style);
                break;
                default:
                text = const Text('', style: style);
                break;
                }
                return SideTitleWidget(
                axisSide: meta.axisSide,
                space:10,
                child: text,
                );
                }
                BarChartData randomData() {
                return BarChartData(
                barTouchData: BarTouchData(
                enabled: false,
                ),
                titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getTitles,
                reservedSize: 38,
                ),
                ),
                leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                showTitles: false,
                ),
                ),
                topTitles: const AxisTitles(
                sideTitles: SideTitles(
                showTitles: false,
                ),
                ),
                rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                showTitles: false,
                ),
                ),
                ),
                borderData: FlBorderData(
                show: false,
                ),
                barGroups: List.generate(7, (i) {
                switch (i) {
                case 0:
                return makeGroupData(
                0,
                Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                Random().nextInt(widget.availableColors.length)],
                );
                case 1:
                return makeGroupData(
                1,
                Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                Random().nextInt(widget.availableColors.length)],
                );
                case 2:
                return makeGroupData(
                2,
                Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                Random().nextInt(widget.availableColors.length)],
                );
                case 3:
                return makeGroupData(
                3,
                Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                Random().nextInt(widget.availableColors.length)],
                );
                case 4:
                return makeGroupData(
                4,
                Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                Random().nextInt(widget.availableColors.length)],
                );
                case 5:
                return makeGroupData(
                5,
                Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                Random().nextInt(widget.availableColors.length)],
                );
                default:
                return throw Error();
                }
                }),
                gridData: const FlGridData(show: false),
                );
                }
                Future<dynamic> refreshState() async {
                setState(() {});
                await Future<dynamic>.delayed(
                animDuration + const Duration(milliseconds: 50),
                );
                if (isPlaying) {
                await refreshState();
                }
                }
                }