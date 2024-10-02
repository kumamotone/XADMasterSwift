import Foundation
import XADMaster

public class XADMasterSwift {
    private static var currentArchive: XADArchive?

    public static func extractArchive(at path: String, to destination: String) throws {
        guard let archive = XADArchive(file: path) else {
            throw NSError(domain: "XADMasterSwift", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create archive"])
        }
        currentArchive = archive
        try archive.extract(to: destination)
    }

    public static func listContents(of path: String) throws -> [String] {
        guard let archive = currentArchive ?? XADArchive(file: path) else {
            throw NSError(domain: "XADMasterSwift", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create archive"])
        }
        currentArchive = archive

        if archive.isEncrypted() && (archive.password == nil || archive.password()!.isEmpty) {
            throw NSError(domain: "XADMasterSwift", code: 2, userInfo: [NSLocalizedDescriptionKey: "Password required"])
        }

        var contents: [String] = []
        for index in 0..<archive.numberOfEntries() {
            if let name = archive.name(ofEntry: index) {
                contents.append(name)
            }
        }
        return contents
    }

    public static func extractFile(at path: String, entryIndex: Int, to destination: String) throws {
        guard let archive = currentArchive ?? XADArchive(file: path) else {
            throw NSError(domain: "XADMasterSwift", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create archive"])
        }
        currentArchive = archive

        try archive.extractEntry(Int32(entryIndex), to: destination)
    }

    public static func setPassword(for path: String, password: String) throws {
        guard let archive = currentArchive ?? XADArchive(file: path) else {
            throw NSError(domain: "XADMasterSwift", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create archive"])
        }
        currentArchive = archive

        archive.setPassword(password)
    }

    public static func getArchiveFormat(of path: String) throws -> String {
        guard let archive = currentArchive ?? XADArchive(file: path) else {
            throw NSError(domain: "XADMasterSwift", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create archive"])
        }
        currentArchive = archive

        return archive.formatName()
    }
}
