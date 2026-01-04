import StructuredQueriesCore

extension StructuredQueriesCore.Table {
  /// Returns an array of all values fetched from the database.
  ///
  /// - Parameter db: A database connection.
  /// - Returns: An array of all values decoded from the database.
  @inlinable
  public static func fetchAll(_ db: Database) throws -> [QueryOutput] {
    try all.fetchAll(db)
  }

  /// Returns a single value fetched from the database.
  ///
  /// - Parameter db: A database connection.
  /// - Returns: A single value decoded from the database.
  @inlinable
  public static func fetchOne(_ db: Database) throws -> QueryOutput? {
    try all.fetchOne(db)
  }

  /// Returns the number of rows fetched by the query.
  ///
  /// - Parameter db: A database connection.
  /// - Returns: The number of rows fetched by the query.
  @inlinable
  public static func fetchCount(_ db: Database) throws -> Int {
    try all.fetchCount(db)
  }

  /// Returns a cursor to all values fetched from the database.
  ///
  /// - Parameter db: A database connection.
  /// - Returns: A cursor to all values decoded from the database.
  @inlinable
  public static func fetchCursor(_ db: Database) throws -> QueryCursor<QueryOutput> {
    try all.fetchCursor(db)
  }
}

// TODO: See if upstream works now
/*
extension StructuredQueriesCore.PrimaryKeyedTable {
  /// Returns a single value fetched from the database for a given primary key.
  ///
  /// - Parameters
  ///   - db: A database connection.
  ///   - primaryKey: A primary key identifying a table row.
  /// - Returns: A single value decoded from the database.
  @inlinable
  public static func find(
    _ db: Database,
    key primaryKey: some QueryExpression<PrimaryKey>
  ) throws -> QueryOutput {
    try all.find(db, key: primaryKey)
  }
}
*/

// NB: Swift 6.2.3 and 6.3-dev guard Select.find(_:) in swift-structured-queries due to compiler crashes.
// This extension depends on that method, so it must also be guarded.
// Tracking: https://github.com/doozMen/sqlite-data/issues/2
#if !compiler(>=6.2.3)
  extension StructuredQueriesCore.PrimaryKeyedTable {
    /// Returns a single value fetched from the database for a given primary key.
    ///
    /// - Parameters
    ///   - db: A database connection.
    ///   - primaryKey: A primary key identifying a table row.
    /// - Returns: A single value decoded from the database.
    @inlinable
    public static func find(
      _ db: Database,
      key primaryKey: some QueryExpression<PrimaryKey>
    ) throws -> QueryOutput {
      guard let record = try Self.all.find(primaryKey).fetchOne(db) else {
        throw NotFound()
      }
      return record
    }
  }
#endif
