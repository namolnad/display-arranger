extension Dictionary {
    subscript<A>(_ key: Key) -> A? {
        get {
            return self[key] as? A
        }
        set {
            self[key] = newValue as? Value
        }
    }
}
