#if canImport(CloudKit) && !compiler(>=6.3)
  import StructuredQueriesCore

  @Table
  package struct TableInfo: Codable, Hashable {
    let defaultValue: String?
    let isPrimaryKey: Bool
    package let name: String
    let isNotNull: Bool
    let type: String
  }
#endif
