//
//  Logger.swift
//  TextOnMenuBar
//

import Foundation

fileprivate enum LogType {
    case debug, info, error
}

fileprivate var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "
    return formatter
}()

fileprivate func convertMessage(_ items: [Any], type: LogType, _ filePath: String, _ function: String, _ line: Int) -> String {
    let time = dateFormatter.string(from: Date())
    
    let lastSlashIndex = (filePath.lastIndex(of: "/") ?? String.Index(utf16Offset: 0, in: filePath))
    let nextIndex = filePath.index(after: lastSlashIndex)
    let fileName = filePath.suffix(from: nextIndex).replacingOccurrences(of: ".swift", with: "")
    
    let message = items.map {"\($0)"}.joined(separator: " ")
    
    switch type {
    case .debug:
        return "\(time) 🔧 Debug [\(fileName).\(function)#\(line)] \(message)"
    case .info:
        return "\(time) ℹ️ Info [\(fileName).\(function)#\(line)] \(message)"
    case .error:
        return "\(time) ❌ Error [\(fileName).\(function)#\(line)] \(message)"
    }
}

func logDebug(items: Any..., tag: String = "", filePath: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    print(convertMessage(items, type: .debug, filePath, function, line))
    #endif
}

func logInfo(items: Any..., tag: String = "", filePath: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    print(convertMessage(items, type: .info, filePath, function, line))
    #endif
}

func logError(items: Any..., tag: String = "", filePath: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    print(convertMessage(items, type: .error, filePath, function, line))
    #endif
}
