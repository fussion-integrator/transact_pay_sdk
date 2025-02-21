import 'package:flutter/material.dart';
import 'dart:async';

import 'package:transact_pay_sdk/src/constant/app_colors.dart';

class AppCountdownTimer extends StatefulWidget {
  final int durationInSeconds; // Duration in seconds
  final TextStyle textStyle;
  final VoidCallback? onCountdownFinished; // Callback when countdown finishes
  final ValueChanged<int>?
      onRemainingTimeChanged; // Callback for remaining time

  const AppCountdownTimer({
    super.key,
    this.durationInSeconds = 600, // Default to 10 minutes (600 seconds)
    this.textStyle = const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor),
    this.onCountdownFinished, // Callback for when countdown finishes
    this.onRemainingTimeChanged, // Callback for remaining time
  });

  @override
  _AppCountdownTimerState createState() => _AppCountdownTimerState();
}

class _AppCountdownTimerState extends State<AppCountdownTimer> {
  late int remainingTime; // Time left in seconds
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.durationInSeconds;
    startCountdown();
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
        if (widget.onRemainingTimeChanged != null) {
          widget.onRemainingTimeChanged!(
              remainingTime); // Trigger callback with remaining time
        }
      } else {
        timer.cancel();
        if (widget.onCountdownFinished != null) {
          widget
              .onCountdownFinished!(); // Trigger callback when countdown finishes
        }
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (remainingTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingTime % 60).toString().padLeft(2, '0');

    return Text(
      "$minutes:$seconds",
      style: widget.textStyle,
    );
  }
}
