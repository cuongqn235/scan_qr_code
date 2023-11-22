enum AppRoutes {
  splash(
    name: 'splash',
    path: '/splash',
  ),
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
