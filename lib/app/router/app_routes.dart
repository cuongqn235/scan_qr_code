enum AppRoutes {
  onBoard(
    name: 'onBoard',
    path: '/onBoard',
  ),
  home(
    name: 'home',
    path: '/home',
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
