class Memory {
  static const operations = const ['()', '%', '/', 'x', '-', '+', '='];

  final _buffer = [0.0, 0.0];
  int _bufferIn = 0;
  String _op;
  String _value = '0';
  bool _wipeVal = false;
  String _lastCom;

  void applyCommand(String com) {
    if (_isReplacingOperation(com)) {
      _op = com;
      return;
    }

    if (com == 'C') {
      _clear();
    } else if (operations.contains(com)) {
      _setOperation(com);
    } else {
      _addDigit(com);
    }

    _lastCom = com;
  }

  _isReplacingOperation(String com) {
    return operations.contains(_lastCom) &&
        operations.contains(com) &&
        _lastCom != '=' &&
        com != '=';
  }

  _setOperation(String newOperation) {
    bool isEqualSign = newOperation == '=';
    if (_bufferIn == 0) {
      if (!isEqualSign) {
        _op = newOperation;
        _bufferIn = 1;
      }
    } else {
      _buffer[0] = _calc();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;
      _op = isEqualSign ? null : newOperation;
      _bufferIn = isEqualSign ? 0 : 1;
    }
    _wipeVal = true;
  }

  _addDigit(String digit) {
    final isDot = digit == '.';
    final wipeVal = (_value == '0' && !isDot) || _wipeVal;

    if (isDot && _value.contains('.') && !wipeVal) {
      return;
    }

    final emptyValue = isDot ? '0' : ' ';
    final currentValue = wipeVal ? emptyValue : _value;
    _value = currentValue + digit;
    _wipeVal = false;

    _buffer[_bufferIn] = double.tryParse(_value) ?? 0;
  }

  _clear() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _bufferIn = 0;
    _op = null;
    _wipeVal = false;
  }

  _calc() {
    switch (_op) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '/':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      default:
        return _buffer[0];
    }
  }

  String get value {
    return _value;
  }
}
