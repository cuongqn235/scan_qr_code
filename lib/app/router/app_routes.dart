enum AppRoutes {
  onBoard(
    name: 'onBoard',
    path: '/onBoard',
  ),
  home(
    name: 'home',
    path: '/home',
  ),
  scanQrCode(
    name: 'scanQrCode',
    path: '/scanQrCode',
  ),
  history(
    name: 'history',
    path: '/history',
  );

  const AppRoutes({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;

  @override
  String toString() => name;
}
