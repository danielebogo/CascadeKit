import Foundation


class Cache {
    static let shared = Stack<Int, Fallback>()
}


private struct StackConstant {
    static let archiveKey = "kCascadeStackArchiveKey"
}


class Stack<Key: Hashable, Value: Codable> {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let defaults = UserDefaults.standard
    private var values: [Key: [Data]] = [:]


    init() {
        restoreValues()
    }


    // MARK: Public methods

    func value(for key: Key, _ block:@escaping (Value) -> Void) -> Bool {
        guard let values = self.values[key], !values.isEmpty else {
            return false
        }

        values.forEach {
            do {
                let value = try decoder.decode(Value.self, from: $0)
                block(value)
            } catch {
                fatalError("Unable to decode data \(String(data: $0, encoding: .utf8) ?? "unknown")")
            }
        }

        return true
    }

    func set(value: Fallback, for key: Key) {
        var values = self.values[key] ?? []

        do {
            let data = try encoder.encode(value)
            values.append(data)
        } catch {
            fatalError("Unable to encode data for key \(key)")
        }

        if !values.isEmpty {
            self.values[key] = values
        }
    }

    func synchronize() {
        let data = NSKeyedArchiver.archivedData(withRootObject: values)
        defaults.set(data, forKey: StackConstant.archiveKey)
        defaults.synchronize()
    }

    func flush() {
        values.removeAll()
        synchronize()
    }


    // MARK: Private methods

    private func restoreValues() {
        if let data = defaults.object(forKey: StackConstant.archiveKey) as? Data {
            do {
                values = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Key: [Data]] ?? [:]
            } catch {
                fatalError("Unable to restore data: unarchive failure")
            }
        }
    }
}
