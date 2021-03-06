import Foundation
import Result

public protocol AnyModelValue {
    static var anyValue: AnyValue { get }
}

public protocol ModelValue: AnyModelValue, Hashable {
    associatedtype Encoded
    static var value: Value<Encoded, Self> { get }
}

extension ModelValue where Encoded == Date {
    public static var anyValue: AnyValue {
        return AnyValue(value)
    }
}

extension ModelValue where Encoded == Double {
    public static var anyValue: AnyValue {
        return AnyValue(value)
    }
}

extension ModelValue where Encoded == Int {
    public static var anyValue: AnyValue {
        return AnyValue(value)
    }
}

extension ModelValue where Encoded == String {
    public static var anyValue: AnyValue {
        return AnyValue(value)
    }
}

extension ModelValue where Encoded == None {
    public static var anyValue: AnyValue {
        return AnyValue(value)
    }
}

public protocol AnyModel {
    static var anySchema: AnySchema { get }
}

public protocol Model: AnyModel {
    static var schema: Schema<Self> { get }
}

extension Model {
    public static var anySchema: AnySchema {
        return AnySchema(schema)
    }
}

public protocol ModelProjection: Hashable {
    associatedtype Model: Schemata.Model
    static var projection: Projection<Model, Self> { get }
}

extension Date: ModelValue {
    public static let value = Value<Date, Date>()
}

extension Double: ModelValue {
    public static let value = Value<Double, Double>()
}

extension Int: ModelValue {
    public static let value = Value<Int, Int>()
}

extension String: ModelValue {
    public static let value = Value<String, String>()
}

extension URL: ModelValue {
    public static let value = String.value.bimap(
        decode: { string in
            URL(string: string).map(Result.success)
                ?? .failure(.typeMismatch)
        },
        encode: { $0.absoluteString }
    )
}

extension UUID: ModelValue {
    public static let value = String.value.bimap(
        decode: { string in
            UUID(uuidString: string).map(Result.success)
                ?? .failure(.typeMismatch)
        },
        encode: { $0.uuidString }
    )
}
