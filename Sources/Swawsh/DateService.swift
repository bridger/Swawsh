import Foundation

protocol DateFormatterProtocol {
    var timeZone: TimeZone! { get set }
    var dateFormat: String! { get set }
    func string(from date: Date) -> String
    
}

extension DateFormatter: DateFormatterProtocol {
    
    static func dateFormatterFactory() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        return dateFormatter
    }
    
    static func amzDateFormatterFactory() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmssZZZZZ"
        dateFormatter.timeZone =  TimeZone(abbreviation: "GMT")
        return dateFormatter
    }
}

protocol DateServiceProtocol {
    func format(date: Date) -> String
    func formatAmz(date: Date) -> String
}

class DateService: DateServiceProtocol {
    internal var amzDateFormatter: DateFormatterProtocol
    internal var dateFormatter: DateFormatterProtocol

    init(dateFormatter: DateFormatterProtocol, amzDateFormatter: DateFormatterProtocol) {
        self.dateFormatter = dateFormatter
        self.amzDateFormatter = amzDateFormatter
    }
    
    func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func formatAmz(date: Date) -> String {
        return amzDateFormatter.string(from: date)
    }
}
