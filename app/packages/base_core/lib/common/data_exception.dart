class DataException implements Exception {
  final dynamic _dataError;

  dynamic get dataError => _dataError;

  DataException(this._dataError);
}
