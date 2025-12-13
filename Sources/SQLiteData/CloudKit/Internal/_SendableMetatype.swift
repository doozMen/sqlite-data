#if canImport(CloudKit) && !compiler(>=6.3)
  #if swift(>=6.2)
    public typealias _SendableMetatype = SendableMetatype
  #else
    public typealias _SendableMetatype = Any
  #endif
#endif
