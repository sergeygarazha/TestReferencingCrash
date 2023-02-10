import Foundation
import Combine

private var lock = NSLock()
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

                    lock.lock()
                    cancellable.store(in: &cancellables)
                    lock.unlock()
            }
        }
    }
}
