//
//  Logger.swift
//  Core40
//
//  Created by Paris Pinkney on 11/12/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import Foundation
import CocoaLumberjack
import CocoaLumberjackSwift
import CocoaLumberjack.DDDispatchQueueLogFormatter
import MachO

@inline(__always)
public func log(_ level: DDLogLevel, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, assert: Bool = false, fatal: Bool = false) {
	switch level {
	case .all, .verbose, .off:
		DDLogVerbose(message, file: file, function: function, line: line)
	case .debug:
		DDLogDebug(message, file: file, function: function, line: line)
	case .error:
		DDLogError(message, file: file, function: function, line: line)
	case .info:
		DDLogInfo(message, file: file, function: function, line: line)
	case .warning:
		DDLogWarn(message, file: file, function: function, line: line)
	}

	if fatal {
		assertionFailure(message)
	}

	if assert {
		pthread_kill(pthread_self(), SIGSTOP) // send a stop signal to the current thread
	}
}

// MARK: - Logger

struct Logger {

	static func configureLoggers() {
		let ttyLogger = DDTTYLogger.sharedInstance()
		ttyLogger?.logFormatter = LogFormatter()
		DDLog.add(ttyLogger) // TTY = Xcode console

		let aslLogger = DDASLLogger.sharedInstance()
		DDLog.add(aslLogger) // ASL = Apple System Logs
	}
}

// MARK: - LogFormatter

private final class LogFormatter: DDDispatchQueueLogFormatter {

	private lazy var dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
		return formatter
	}()

	override func format(message logMessage: DDLogMessage!) -> String {
		guard let timestamp = logMessage?.timestamp,
			let filename = logMessage?.fileName,
			let line = logMessage?.line,
			let function = logMessage?.function,
			let message = logMessage?.message else { return "" }

		// NSLog() format:
		// 2016-11-12 16:13:55.646 Core40[17487:1768317] Hello World!
		// [  date  ] [   time   ] [  pname ][  pid :  tid  ] [ message ]

		let formattedTimestamp = dateFormatter.string(from: timestamp)

		let processName = ProcessInfo.processInfo.processName
		let processID = getpid()

		var threadID: UInt64 = 0
		pthread_threadid_np(nil, &threadID)

		// Custom log() format:
		// 2016-11-12 16:13:55.646 Core40[17487:1768317] <HomeViewController:16> - viewDidLoad(): Hello World!

		return "\(formattedTimestamp) \(processName)[\(processID):\(threadID)] <\(filename):\(line)> - \(function): \(message)"
	}
}

