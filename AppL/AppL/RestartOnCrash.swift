//
//  RestartOnCrash.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 20/3/24.
//

import Cocoa
import Foundation

func restart() {
    guard CommandLine.arguments.count == 1 || (
        CommandLine.arguments.count == 2 && CommandLine.arguments[1].starts(with: "restarts=")
    ) else {
        exit(1)
    }

    var args: [String] = []
    if CommandLine.arguments.count == 2 {
        let restarts = CommandLine.arguments[1].split(separator: "=")[1].split(separator: ":").map { TimeInterval($0)! }
        let now = Date().timeIntervalSince1970
        if restarts.filter({ now - $0 < 10 }).count > 3 {
            exit(1)
        } else {
            args.append("\(CommandLine.arguments[1]):\(now)")
        }
    }

    do {
        try exec(arg0: Bundle.main.executablePath!, args: args)
    } catch {
        print("Failed to restart: \(error)")
    }
    exit(0)
}

func restartOnCrash() {
    NSSetUncaughtExceptionHandler { _ in restart() }
    signal(SIGABRT) { _ in restart() }
    signal(SIGILL) { _ in restart() }
    signal(SIGSEGV) { _ in restart() }
    signal(SIGFPE) { _ in restart() }
    signal(SIGBUS) { _ in restart() }
    signal(SIGPIPE) { _ in restart() }
    signal(SIGTRAP) { _ in restart() }
    signal(SIGHUP) { _ in restart() }
    signal(SIGINT) { _ in NSApp.terminate(nil) }
}

// MARK: - exec

import var Darwin.EINVAL
import var Darwin.ERANGE
import func Darwin.strerror_r

func stringerror(_ code: Int32) -> String {
    var cap = 64
    while cap <= 16 * 1024 {
        var buf = [Int8](repeating: 0, count: cap)
        let err = strerror_r(code, &buf, buf.count)
        if err == EINVAL {
            return "unknown error \(code)"
        }
        if err == ERANGE {
            cap *= 2
            continue
        }
        if err != 0 {
            return "fatal: strerror_r: \(err)"
        }
        return "\(String(cString: buf)) (\(code))"
    }
    return "fatal: strerror_r: ERANGE"
}

func exec(arg0: String, args: [String]) throws -> Never {
    let args = CStringArray([arg0] + args)

    guard execv(arg0, args.cArray) != -1 else {
        throw POSIXError.execv(executable: arg0, errno: errno)
    }

    fatalError("Impossible if execv succeeded")
}

// MARK: - POSIXError
enum POSIXError: LocalizedError {
    case execv(executable: String, errno: Int32)

    var errorDescription: String? {
        switch self {
        case let .execv(executablePath, errno):
            "execv failed: \(stringerror(errno)): \(executablePath)"
        }
    }
}

// MARK: - CStringArray

private final class CStringArray {
    init(_ array: [String]) {
        cArray = array.map { $0.withCString { strdup($0) } } + [nil]
    }

    deinit {
        for case let element? in cArray {
            free(element)
        }
    }
    let cArray: [UnsafeMutablePointer<Int8>?]
}
