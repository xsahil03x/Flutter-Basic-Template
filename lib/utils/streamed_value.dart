import 'package:rxdart/rxdart.dart';

abstract class StreamedValueBase<T> {
  final stream = BehaviorSubject<T>();

  /// timesUpdate shows how many times the got updated
  int timesUpdated = 0;

  /// Sink for the stream
  Function(T) get inStream => stream.sink.add;

  /// Stream getter
  ValueObservable<T> get outStream => stream.stream;

  T get value => stream.value;

  set value(T value) => inStream(value);

  refresh() {
    inStream(value);
  }

  dispose() {
    print('---------- Closing Stream ------ type: $T');
    stream.close();
  }
}

class StreamedValue<T> extends StreamedValueBase<T> {
  StreamedValue({T initialData}) {
    if (initialData != null) {
      stream.value = initialData;
    }
  }

  set value(T value) {
    if (stream.value != value) {
      inStream(value);
      timesUpdated++;
    }
  }
}

class StreamedList<T> extends StreamedListBase<T> {
  StreamedList({List<T> initialData}) {
    if (initialData != null) {
      stream.value = initialData;
    }
  }

  set value(List<T> value) {
    if (value == null) {
      stream.value = [];
    }
    inStream(value);
    timesUpdated++;
  }
}

abstract class StreamedListBase<T> {
  /// - [addElement]
  /// - [removeElement]
  /// - [removeAt]
  /// - [clear]
  /// - [replace]
  /// - [replaceAt]

  final stream = BehaviorSubject<List<T>>();

  int timesUpdated = 0;

  /// Sink for the stream
  Function(List<T>) get inStream => stream.sink.add;

  /// Stream getter
  ValueObservable<List<T>> get outStream => stream.stream;

  List<T> get value => stream.value ?? [];

  set value(List<T> value) => inStream(value);

  bool isEmpty() {
    return value.isEmpty;
  }

  int get length => value.length;

  addElement(T element) {
    value.add(element);
    refresh();
  }

  void addAll(List<T> elements) {
    value.addAll(elements);
    refresh();
  }

  bool contains(T msg) {
    return value.contains(msg);
  }

  removeElement(T element) {
    value.remove(element);
    refresh();
  }

  removeAt(int index) {
    value.removeAt(index);
    refresh();
  }

  replaceAt(int index, T newElement) {
    value[index] = newElement;
    refresh();
  }

  replace(T oldElement, T newElement) {
    var index = stream.value.indexOf(oldElement);
    replaceAt(index, newElement);
  }

  clear() {
    value.clear();
    refresh();
  }

  refresh() {
    inStream(value);
    timesUpdated++;
  }

  dispose() {
    print('---------- Closing Stream ------ type: List<$T>');
    stream.close();
  }
}

class StreamedMap<K, V> extends StreamedMapBase<K, V> {
  StreamedMap({Map<K, V> initialData}) {
    if (initialData != null) {
      stream.value = initialData;
    }
  }

  set value(Map<K, V> value) {
    if (value == null) {
      stream.value = {};
    }
    inStream(value);
    timesUpdated++;
  }
}

abstract class StreamedMapBase<K, V> {
  /// - [put]
  /// - [putIfAbsent]
  /// - [remove]
  /// - [clear]
  /// - [length]
  /// - [containsKey]

  final stream = BehaviorSubject<Map<K, V>>();
  int timesUpdated = 0;

  Function(Map<K, V>) get inStream => stream.sink.add;

  ValueObservable<Map<K, V>> get outStream => stream.stream;

  Map<K, V> get value => stream.value ?? {};

  set value(Map<K, V> value) => inStream(value);

  refresh() {
    inStream(value);
    timesUpdated++;
  }

  bool isEmpty() {
    return value.isEmpty;
  }

  putIfAbsent(K key, V val) {
    value.putIfAbsent(key, () => val);
    refresh();
  }

  remove(K key) {
    value.remove(key);
    refresh();
  }

  clear() {
    value.clear();
    refresh();
  }

  bool containsKey(K key) {
    return value.containsKey(key);
  }

  get length {
    value.length;
  }

  dispose() {
    print('---------- Closing Stream ------ type: Map<$K, $V>');
    stream.close();
  }
}
