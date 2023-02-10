import Foundation
import Combine

// Read http://www.russbishop.net/the-law for more information on why this is necessary
final class UnfairLock {
    private var _lock: UnsafeMutablePointer<os_unfair_lock>

    init() {
        _lock = UnsafeMutablePointer<os_unfair_lock>.allocate(capacity: 1)
        _lock.initialize(to: os_unfair_lock())
    }

    deinit {
        _lock.deallocate()
    }

    func locked<ReturnValue>(_ f: () throws -> ReturnValue) rethrows -> ReturnValue {
        os_unfair_lock_lock(_lock)
        defer { os_unfair_lock_unlock(_lock) }
        return try f()
    }
}

private let lock = UnfairLock()
private var cancellables: Set<AnyCancellable> = []

class ViewModel {
    func test() {
        for _ in (0...10000) {
            DispatchQueue(label: "test", qos: .default)
            //DispatchQueue.main
                .async {
                    let cancellable = Just("Test").sink(receiveValue: { value in
                        print(value)
                    })

                    lock.locked {
                        cancellable.store(in: &cancellables)
                    }
            }
        }
    }
}
