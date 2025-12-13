// swift-tools-version: 6.2.1

import PackageDescription

let package = Package(
    name: "sqlite-data",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "SQLiteData",
            targets: ["SQLiteData"]
        ),
        .library(
            name: "SQLiteDataTestSupport",
            targets: ["SQLiteDataTestSupport"]
        ),
    ],
    traits: [
        .trait(
            name: "SQLiteDataTagged",
            description: "Introduce SQLiteData conformances to the swift-tagged package."
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections", from: "1.0.0"),
        // NB: Fork synced with upstream v7.9.0
        .package(url: "https://github.com/doozMen/GRDB.swift", revision: "aa0079aeb82a4bf00324561a40bffe68c6fe1c26"),
        .package(url: "https://github.com/pointfreeco/swift-concurrency-extras", from: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "1.3.3"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.9.0"),
        // NB: Fork with Swift 6.3 fixes (uses doozMen/swift-perception)
        // TODO: Pin to specific commit after merging PR #3
        .package(url: "https://github.com/doozMen/swift-sharing", branch: "fix/swift-build-compatibility"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.18.4"),
        // NB: Fork with Swift 6.3 fixes
        .package(
            url: "https://github.com/doozMen/swift-structured-queries",
            revision: "85f39901d6c6046fa2f5119717741d9cc8a50b7f",
            traits: [
                .trait(
                    name: "StructuredQueriesTagged",
                    condition: .when(traits: ["SQLiteDataTagged"]))
            ]
        ),
        .package(url: "https://github.com/pointfreeco/swift-tagged", from: "0.10.0"),
        .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.5.0"),
    ],
    targets: [
        .target(
            name: "SQLiteData",
            dependencies: [
                .product(name: "ConcurrencyExtras", package: "swift-concurrency-extras"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "GRDB", package: "GRDB.swift"),
                .product(name: "IssueReporting", package: "xctest-dynamic-overlay"),
                .product(name: "OrderedCollections", package: "swift-collections"),
                .product(name: "Sharing", package: "swift-sharing"),
                .product(name: "StructuredQueriesSQLite", package: "swift-structured-queries"),
                .product(
                    name: "Tagged",
                    package: "swift-tagged",
                    condition: .when(traits: ["SQLiteDataTagged"])
                ),
            ]
        ),
        .target(
            name: "SQLiteDataTestSupport",
            dependencies: [
                "SQLiteData",
                .product(name: "ConcurrencyExtras", package: "swift-concurrency-extras"),
                .product(name: "CustomDump", package: "swift-custom-dump"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing"),
                .product(name: "StructuredQueriesTestSupport", package: "swift-structured-queries"),
            ]
        ),
        .testTarget(
            name: "SQLiteDataTests",
            dependencies: [
                "SQLiteData",
                "SQLiteDataTestSupport",
                .product(name: "DependenciesTestSupport", package: "swift-dependencies"),
                .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing"),
                .product(name: "SnapshotTestingCustomDump", package: "swift-snapshot-testing"),
                .product(name: "StructuredQueries", package: "swift-structured-queries"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("MemberImportVisibility")
    // .unsafeFlags([
    //   "-Xfrontend",
    //   "-warn-long-function-bodies=50",
    //   "-Xfrontend",
    //   "-warn-long-expression-type-checking=50",
    // ])
]

for index in package.targets.indices {
    package.targets[index].swiftSettings = swiftSettings
}

#if !os(Windows)
    // Add the documentation compiler plugin if possible
    package.dependencies.append(
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
    )
#endif
