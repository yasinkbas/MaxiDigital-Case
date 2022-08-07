import ProjectDescription

let projectName = "CommonKit"
let bundleId = "com.yasinkbas.\(projectName)"

let project = Project(
    name: projectName,
    organizationName: "com.yasinkbas",
    targets: [
        Target(
            name: projectName,
            platform: .iOS,
            product: .framework,
            bundleId: bundleId,
            deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
            infoPlist: .default,
            sources: ["Sources/**"],
//            resources: ["Sources/**/*.xcassets"],
            dependencies: [])
    ])

