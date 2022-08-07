import ProjectDescription

let projectName = "MaxiDigital-Case"
let bundleId = "com.yasinkbas.\(projectName)"

let appTarget = Target(
    name: projectName,
    platform: .iOS,
    product: .app,
    bundleId: bundleId,
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    infoPlist: .extendingDefault(with: [
        "UILaunchScreen": [:]
    ]),
    sources: ["\(projectName)/**"],
    resources: [
        "\(projectName)/**/*.xcassets",
    ],
    dependencies: [
        .external(name: "UILab"),
        
        // Kits
        .project(target: "CommonKit", path: .relativeToManifest("Kits/CommonKit")),
    ]
)

let testTarget = Target(
    name: "\(projectName)Tests",
    platform: .iOS,
    product: .unitTests,
    bundleId: "\(bundleId)Tests",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    infoPlist: .default,
    sources: [
        "UnitTests/**"
    ],
    resources: [
        "UnitTests/**"
    ],
    dependencies: [
        .target(name: projectName)
    ])

let project = Project(
    name: projectName,
    organizationName: bundleId,
    targets: [
        appTarget,
        testTarget
    ]
)
