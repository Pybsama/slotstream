import Foundation
import Slotstream

/// The older 2.1 bundle is preserved as data. Its fixtures must explicitly
/// identify the reviewed newer execution source, which is also native here.
/// Existing 3.2/4.4 goldens predate this field and remain usable unchanged.
struct VQReferenceExecution: Decodable {
    let schema: Int
    let mode: String
    let bundled_runtime_sha256: String
    let runtime_sha256: String

    static func validate(inventorySHA: String, runtimeSHA: String?, profile: Self?) throws {
        let reviewed = "1685ec90feb24e421c379ae4e3594f659478905d2c1393617990d84d3f514ee8"
        let bundled: String
        switch inventorySHA {
        case "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
             "a30ded4e88270d33dfcca8e9b6c414a69cf82f0ad27d20bb3fe71b2b1c14ccac": bundled = reviewed
        case "4f63194dec2e4c3bec31289d6503cc7c886685e16e7c4aac58116d4cf0c7f037":
            bundled = "36de8d6ba21ff93ac3de2994eed4fd59e9cfab86b1908f72f5ee2673bd0aa5bb"
        default: throw ModelError("VQ reference execution requires an inspected artifact")
        }
        if let profile {
            guard profile.schema == 1, profile.runtime_sha256 == reviewed, runtimeSHA == reviewed,
                  profile.bundled_runtime_sha256 == bundled,
                  profile.mode == "explicit-reviewed-v1" || (bundled == reviewed && profile.mode == "bundled-reviewed-v1") else {
                throw ModelError("VQ reference execution profile does not bind the reviewed source")
            }
        } else {
            guard bundled == reviewed, runtimeSHA == nil || runtimeSHA == reviewed else {
                throw ModelError("VQ reference requires its explicit reviewed execution profile")
            }
        }
    }
}
