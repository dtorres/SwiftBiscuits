import Freddy

extension JSON {
    func url() throws -> NSURL {
        if case .String(let string) = self,
            let url = NSURL(string: string) {
            return url
        }
        
        throw JSON.Error.ValueNotConvertible(value: self, to: NSURL.self)
    }
    
    func date(path: JSONPathType, formatter: NSDateFormatter) throws -> NSDate {
        let string = try self.string(path)
        guard let date = formatter.dateFromString(string) else {
            throw JSON.Error.ValueNotConvertible(value: string.toJSON(), to: NSDate.self)
        }
        return date
    }
}

protocol JSONType {}

extension JSON: JSONType {}
extension JSONDecodable {
    private init(json: JSONType) throws {
        let realJSON = json as! Freddy.JSON
        try self.init(json: realJSON)
    }
}

extension Array where Element: JSONType {
    func flatDecode<Decoded: JSONDecodable>(to type: Decoded.Type = Decoded.self) -> [Decoded] {
        return self.flatMap({
            let a: Decoded?
            do {
                a = try Decoded.init(json: $0)
            } catch let error {
                print(error)
                a = nil
            }
            return a
        })
    }
}
