import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/yasinkbas/UILab.git", requirement: .upToNextMajor(from: "0.3.3")),
    ],
    platforms: [.iOS]
)

