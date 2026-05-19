enum Month {
  jan('Jan'),
  feb('Feb'),
  mar('Mar'),
  apr('Apr'),
  may('May'),
  jun('Jun'),
  jul('Jul'),
  aug('Aug'),
  sep('Sep'),
  oct('Oct'),
  nov('Nov'),
  dec('Dec');

  final String value;

  const Month(this.value);

  static Month? fromIndex(int index) {
    if (index < 1 || index > 12) return null;
    return Month.values[index - 1];
  }

  static Month? fromDateTime(DateTime dateTime) {
    return fromIndex(dateTime.month);
  }
}
