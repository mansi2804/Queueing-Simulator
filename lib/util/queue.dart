
class queue<T> {
  final List<T> _heap = [];
  final int Function(T, T) _comparator;

  queue(this._comparator);

  /// Add an element to priority queue & maintain the heap property
  void add(T value) {
    _heap.add(value);
    _bubbleUp(_heap.length - 1);
  }

  /// the highest priority element will remove & return
  T removeFirst() {
    if (_heap.isEmpty) throw StateError('The Priority Queue is empty');
    
    T result = _heap.first;
    
    if (_heap.length == 1) {
      _heap.removeLast();
      return result;
    }

  
    _heap[0] = _heap.removeLast();
    _bubbleDown(0);

    return result;
  }

  /// Check whether the priority queue is empty or not
  bool get isEmpty => _heap.isEmpty;

  /// Get the no. of elements in the priority queue
  int get length => _heap.length;

  /// Add multiple elements to the queue
  void addAll(Iterable<T> values) {
    for (var value in values) {
      add(value);
    }
  }

  /// Adjust the position of an element up to maintain the heap property
  void _bubbleUp(int index) {
    while (index > 0) {
      int parentIndex = (index - 1) ~/ 2;
      if (_comparator(_heap[index], _heap[parentIndex]) < 0) {
        _swap(index, parentIndex);
        index = parentIndex;
      } else {
        break;
      }
    }
  }

  /// Adjust the position of an element down to maintain the heap property
  void _bubbleDown(int index) {
    int leftChild, rightChild, smallest;

    while (index < _heap.length) {
      leftChild = 2 * index + 1;
      rightChild = 2 * index + 2;
      smallest = index;

      if (leftChild < _heap.length &&
          _comparator(_heap[leftChild], _heap[smallest]) < 0) {
        smallest = leftChild;
      }

      if (rightChild < _heap.length &&
          _comparator(_heap[rightChild], _heap[smallest]) < 0) {
        smallest = rightChild;
      }

      if (smallest != index) {
        _swap(index, smallest);
        index = smallest;
      } else {
        break;
      }
    }
  }

  /// Swaping two elements in the heap
  void _swap(int i, int j) {
    T temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }
}
