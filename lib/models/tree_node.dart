// lib/models/tree_node.dart
// Model đại diện cho một cây được gắn cảm biến (Sentinel Node)

enum TreeStatus { healthy, drought, warning, offline }

class TreeNode {
  final String id;
  final String name;         // Ví dụ: "Tree #1"
  final String species;      // Giống cây: "Xoài", "Bưởi"
  final String location;     // Vị trí: "Main orchard, row 1"
  final TreeStatus status;
  final int batteryPercent;
  final bool isConnected;
  final DateTime lastActive;
  final List<String> recommendedActions;
  final double signalStrength; // 0.0 - 1.0

  const TreeNode({
    required this.id,
    required this.name,
    required this.species,
    required this.location,
    required this.status,
    required this.batteryPercent,
    required this.isConnected,
    required this.lastActive,
    this.recommendedActions = const [],
    this.signalStrength = 1.0,
  });

  // Trả về nhãn trạng thái tiếng Anh
  String get statusLabel {
    switch (status) {
      case TreeStatus.healthy:
        return 'Healthy';
      case TreeStatus.drought:
        return 'Drought';
      case TreeStatus.warning:
        return 'Warning';
      case TreeStatus.offline:
        return 'Offline';
    }
  }

  // Emoji tương ứng với trạng thái
  String get statusEmoji {
    switch (status) {
      case TreeStatus.healthy:
        return '😊';
      case TreeStatus.drought:
        return '😢';
      case TreeStatus.warning:
        return '😰';
      case TreeStatus.offline:
        return '😶';
    }
  }

  // Màu dot trạng thái
  String get lastActiveLabel {
    final diff = DateTime.now().difference(lastActive);
    if (diff.inMinutes < 1) return 'NOW';
    if (diff.inMinutes < 60) return '${diff.inMinutes}min ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

final List<TreeNode> mockTrees = [
  TreeNode(
    id: 't1',
    name: 'Tree #1',
    species: 'Xoài',
    location: 'Main orchard, row 1',
    status: TreeStatus.healthy,
    batteryPercent: 92,
    isConnected: true,
    lastActive: DateTime.now().subtract(const Duration(hours: 2)),
    signalStrength: 0.98,
    recommendedActions: [
      'Increase irrigation by 30% TODAY',
      'Check soil moisture (target 70%)',
      'Inspect tree bark for damage',
      'Call agricultural extension officer',
    ],
  ),
  TreeNode(
    id: 't2',
    name: 'Tree #2',
    species: 'Bưởi',
    location: 'Main orchard, row 2',
    status: TreeStatus.drought,
    batteryPercent: 88,
    isConnected: true,
    lastActive: DateTime.now(),
    signalStrength: 0.88,
    recommendedActions: [
      'Water immediately - critical drought stress',
      'Check irrigation system for blockage',
      'Mulch around base to retain moisture',
    ],
  ),
  TreeNode(
    id: 't3',
    name: 'Tree #3',
    species: 'Xoài',
    location: 'Main orchard, row 3',
    status: TreeStatus.healthy,
    batteryPercent: 95,
    isConnected: true,
    lastActive: DateTime.now().subtract(const Duration(minutes: 30)),
    signalStrength: 0.98,
    recommendedActions: [
      'Routine maintenance check',
      'Apply fertilizer next week',
    ],
  ),
];

// ─── Alert Model ─────────────────────────────────────────────────────────────
class TreeAlert {
  final String id;
  final String treeId;
  final String treeName;
  final String message;
  final bool isUrgent;
  final DateTime timestamp;

  const TreeAlert({
    required this.id,
    required this.treeId,
    required this.treeName,
    required this.message,
    required this.isUrgent,
    required this.timestamp,
  });
}

final List<TreeAlert> mockAlerts = [
  TreeAlert(
    id: 'a1',
    treeId: 't2',
    treeName: 'Tree #2',
    message: 'Cavitation detected - water stress indicated',
    isUrgent: true,
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  TreeAlert(
    id: 'a2',
    treeId: 't2',
    treeName: 'Tree #2',
    message: 'Soil moisture below threshold',
    isUrgent: false,
    timestamp: DateTime.now().subtract(const Duration(minutes: 12)),
  ),
];
