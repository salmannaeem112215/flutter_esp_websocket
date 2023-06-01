class Device {
  String name;
  String ip;
  bool isConnected;
  bool isLocked;

  Device({
    required this.name,
    required this.isConnected,
    required this.isLocked,
    required this.ip,
  });
}
