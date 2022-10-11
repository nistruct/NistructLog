import SwiftyBeaver

private typealias log = SwiftyBeaver

public class NistructLog {
    static let shared = NistructLog()
    
    private lazy var consoleFilter = createFilter(for: .info)
    
    private lazy var consoleDestination: ConsoleDestination = {
        let consoleDestination = ConsoleDestination()
        consoleDestination.format = "$Dyyyy-MM-dd HH:mm:ss.SSS$d $C$L$c $N.$F:$l - $M"
        return consoleDestination
    }()
    
    public static func configure() {
        NistructLog.shared.configure()
    }
    
    public static func setLogLevel(_ level: LogLevel) {
        NistructLog.shared.setLogLevel(level)
    }
    
    /// log something generally unimportant (lowest priority)
    public class func verbose(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        log.custom(level: .verbose, message: message(), file: file, function: function, line: line, context: context)
    }

    /// log something which help during debugging (low priority)
    public class func debug(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        log.custom(level: .debug, message: message(), file: file, function: function, line: line, context: context)
    }

    /// log something which you are really interested but which is not an issue or error (normal priority)
    public class func info(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        log.custom(level: .info, message: message(), file: file, function: function, line: line, context: context)
    }

    /// log something which may cause big trouble soon (high priority)
    public class func warning(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        log.custom(level: .warning, message: message(), file: file, function: function, line: line, context: context)
    }

    /// log something which will keep you awake at night (highest priority)
    public class func error(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        log.custom(level: .error, message: message(), file: file, function: function, line: line, context: context)
    }
}

private extension NistructLog {
    func configure() {
        log.addDestination(consoleDestination)
        consoleDestination.addFilter(consoleFilter)
        
        log.debug("NistructLog loaded")
    }
    
    func setLogLevel(_ level: LogLevel) {
        consoleDestination.removeFilter(consoleFilter)
        consoleFilter = createFilter(for: level)
        consoleDestination.addFilter(consoleFilter)
    }
    
    func createFilter(for level: LogLevel) -> CompareFilter {
        let swiftyLevel = swiftyLevel(for: level)
        return CompareFilter(.Message(.Custom { _ in true }), required: true, minLevel: swiftyLevel)
    }
    
    func swiftyLevel(for level: LogLevel) -> SwiftyBeaver.Level {
        switch level {
        case .verbose: return .verbose
        case .debug: return .debug
        case .info: return .info
        case .warning: return .warning
        case .error: return .error
        }
    }
}
