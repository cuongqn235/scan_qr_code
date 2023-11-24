enum HistoryType {
  all('Tất cả', null),
  scanned('Đã quét', false),
  created('Đã tạo', true);

  final String title;
  final bool? value;
  const HistoryType(
    this.title,
    this.value,
  );
}
