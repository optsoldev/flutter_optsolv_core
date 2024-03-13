class ClientSettings {
  late String _tenantId;

  String get tenantId => _tenantId;

  void loadEnvironment() {
    _tenantId = const String.fromEnvironment('TENANT_ID');
  }
}
