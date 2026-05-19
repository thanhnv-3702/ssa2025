class EventBus {
  static EventBus get instance => _getInstance();

  static EventBus? _instance;

  EventBus._internal();

  static EventBus _getInstance() {
    _instance ??= EventBus._internal();
    return _instance!;
  }

  final Map<String, List<void Function(dynamic)>> _listener = {};

  void addListener(void Function(dynamic) fn, {String? name}) async {
    if (name == null || name.isEmpty) {
      var dl = _listener[defaultNotification];
      if (dl == null || dl.isEmpty) {
        _listener[defaultNotification] = [fn];
      } else {
        _listener[defaultNotification] = dl..add(fn);
      }
    } else {
      var otherLst = _listener[name];
      if (otherLst == null || otherLst.isEmpty) {
        _listener[name] = [fn];
      } else {
        _listener[name] = otherLst..add(fn);
      }
    }
  }

  void notificationListener({String? name, dynamic parameter}) {
    if (name == null || name.isEmpty) {
      var dl = _listener[defaultNotification];
      if (dl != null) {
        for (var fn in dl) {
          fn(parameter);
        }
      }
    } else {
      var dl = _listener[name];
      if (dl != null) {
        for (var fn in dl) {
          fn(parameter);
        }
      }
    }
  }

  void removeListener(void Function(dynamic) fn, {String? name}) {
    if (name == null || name.isEmpty) {
      _listener[defaultNotification]?.remove(fn);
    } else {
      _listener[name]?.remove(fn);
    }
  }

  void removeAllListener() {
    _listener.clear();
  }
}

const String defaultNotification = 'defaultNotification';
const String logoutNotification = 'logoutNotification';
