import 'package:flutter/material.dart';

class DateUtil {
  //for getting formatted time from fromMillisecondsSinceEpoch string
  String getFormattedtime({
    required BuildContext context,
    required String time,
  }) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }
}
