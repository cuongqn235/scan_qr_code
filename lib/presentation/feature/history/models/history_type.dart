enum HistoryType {
  all('All', null),
  scanned('Scanned', false),
  created('Created', true);

  final String title;
  final bool? value;
  const HistoryType(
    this.title,
    this.value,
  );
}
