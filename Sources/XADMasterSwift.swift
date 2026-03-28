import Foundation
import XADMaster

// MARK: - Instance-based API

public class XADArchiveReader {
    private let archive: XADArchive

    public let path: String
    public var isEncrypted: Bool { archive.isEncrypted() }
    public var formatName: String { archive.formatName() }
    public var numberOfEntries: Int { Int(archive.numberOfEntries()) }

    public init(path: String) throws {
        self.path = path
        guard let archive = XADArchive(file: path) else {
            throw XADMasterSwiftError.failedToOpenArchive
        }
        self.archive = archive
    }

    public func setPassword(_ password: String) {
        archive.setPassword(password)
    }

    public func nameOfEntry(at index: Int) -> String? {
        archive.name(ofEntry: Int32(index))
    }

    public func entryIsDirectory(at index: Int) -> Bool {
        archive.entryIsDirectory(Int32(index))
    }

    public func entryIsEncrypted(at index: Int) -> Bool {
        archive.entryIsEncrypted(Int32(index))
    }

    public func entryIsArchive(at index: Int) -> Bool {
        archive.entryIsArchive(Int32(index))
    }

    public func uncompressedSizeOfEntry(at index: Int) -> Int64 {
        archive.uncompressedSize(ofEntry: Int32(index))
    }

    public func contentsOfEntry(at index: Int) -> Data? {
        archive.contents(ofEntry: Int32(index))
    }
}

// MARK: - Error types

public enum XADMasterSwiftError: LocalizedError {
    case failedToOpenArchive
    case passwordRequired

    public var errorDescription: String? {
        switch self {
        case .failedToOpenArchive:
            return "Failed to open archive"
        case .passwordRequired:
            return "Password required"
        }
    }
}

// MARK: - Legacy static API (backward compatible)

public class XADMasterSwift {
    private static var currentArchive: XADArchive?

    public static func extractArchive(at path: String, to destination: String) throws {
        guard let archive = XADArchive(file: path) else {
            throw XADMasterSwiftError.failedToOpenArchive
        }
        currentArchive = archive
        try archive.extract(to: destination)
    }

    public static func listContents(of path: String) throws -> [String] {
        guard let archive = currentArchive ?? XADArchive(file: path) else {
            throw XADMasterSwiftError.failedToOpenArchive
        }
        currentArchive = archive

        if archive.isEncrypted() && (archive.password == nil || archive.password()!.isEmpty) {
            throw XADMasterSwiftError.passwordRequired
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
            throw XADMasterSwiftError.failedToOpenArchive
        }
        currentArchive = archive

        try archive.extractEntry(Int32(entryIndex), to: destination)
    }

    public static func setPassword(for path: String, password: String) throws {
        guard let archive = currentArchive ?? XADArchive(file: path) else {
            throw XADMasterSwiftError.failedToOpenArchive
        }
        currentArchive = archive

        archive.setPassword(password)
    }

    public static func getArchiveFormat(of path: String) throws -> String {
        guard let archive = currentArchive ?? XADArchive(file: path) else {
            throw XADMasterSwiftError.failedToOpenArchive
        }
        currentArchive = archive

        return archive.formatName()
    }
}
