// CloudKitAvailability.swift
// Compile-time warning for Swift 6.3+ users

#if compiler(>=6.3)
  #warning("""
    CloudKit functionality is disabled on Swift 6.3+ due to compiler crashes.
    See https://github.com/doozMen/sqlite-data/issues/2 for details.
    Use Swift 6.2.x if you need CloudKit synchronization features.
    """)
#endif
