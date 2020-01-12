class ItemContract {
  ItemContract._();

  static const String TABLE_NAME = 'item';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_NAME = "name";
  static const String COLUMN_UNIT = "unit";

  static const String CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS $TABLE_NAME ('
      '$COLUMN_ID INTEGER PRIMARY KEY, '
      '$COLUMN_NAME TEXT, '
      '$COLUMN_UNIT INTEGER);';

  static const String SELECT_TABLE = 'SELECT * FROM $TABLE_NAME';

  static const String DELETE_TABLE = 'DROP TABLE IF EXISTS $TABLE_NAME';
}
