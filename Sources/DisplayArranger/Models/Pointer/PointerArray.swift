final class PointerArray<A> {
    let capacity: Int

    private let value: UnsafeMutableBufferPointer<A>

    var first: UnsafeMutablePointer<A>

    var array: [A] {
        .init(value)
    }

    init(capacity: Int) {
        self.capacity = capacity
        self.first = .allocate(capacity: capacity)
        self.value = .init(start: first, count: capacity)
    }

    convenience init(capacity: UInt32) {
        self.init(capacity: Int(capacity))
    }

    deinit {
        first.deallocate()
    }

    subscript(_ index: Int) -> A {
        value[index]
    }
}
