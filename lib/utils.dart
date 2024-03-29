// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  const Event(this.title, this.startTime, this.endTime);

  @override
  String toString() =>
      "${title} | ${DateFormat('kk:mm').format(startTime)} - ${DateFormat('kk:mm').format(endTime)}";
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(2020, 10, item * 5),
    value: (item) => List.generate(
        item % 4 + 1,
        (index) => Event(
            'Event $item | ${index + 1}', DateTime.now(), DateTime.now())))
  ..addAll({
    DateTime.now(): [
      Event('Today\'s Event 1', DateTime.now(), DateTime.now()),
      Event('Today\'s Event 2', DateTime.now(), DateTime.now()),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);
