import 'package:flutter/material.dart';
import 'package:health_line_bd/animation/water_effect/water_effect.dart';
import 'daily_drink_amount.dart';
import 'daily_goal_amount.dart';

class GoalAndDrinkWaterTile extends StatelessWidget {
  final double goal;
  final double waterDrunk;
  GoalAndDrinkWaterTile({
    @required this.goal,
    @required this.waterDrunk,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
            constraints: constraints,
            child: Stack(
              alignment: Alignment.center,
              children: [
                WaterEffect(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DailyGoalAmount(
                            goal: goal,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          DailyDrinkAmount(
                            goal: goal,
                            waterDrunk: waterDrunk,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}
