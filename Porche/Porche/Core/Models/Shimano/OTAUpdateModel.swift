import Foundation

/// Firmware verzija, status updatea
struct OTAUpdateModel {
    var currentFirmwareVersion: String
    var availableVersion: String?
    var updateStatus: OTAUpdateStatus
}

enum OTAUpdateStatus {
    case idle
    case downloading
    case installing
    case completed
    case failed(Error)
}
