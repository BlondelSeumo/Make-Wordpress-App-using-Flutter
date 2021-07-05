dynamic get(dynamic data, List<dynamic> paths, [defaultValue]) {
  if (data == null || (paths.length > 0 && !(data is Map || data is List))) return defaultValue;
  if (paths.length == 0) return data ?? defaultValue;
  List<dynamic> _paths = List.of(paths);
  String key = _paths.removeAt(0);
  return get(data[key], _paths, defaultValue);
}

class Utility {
  /// Gets the value at path of Map. If the resolved value is null, the defaultValue is returned in its place.
  dynamic get(dynamic data, List<dynamic> paths, [defaultValue]) => get(data, paths);
}
