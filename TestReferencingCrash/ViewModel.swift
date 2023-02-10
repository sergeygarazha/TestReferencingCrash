import Foundation
import Combine

private var cancellables: Set<AnyCancellable> = []

class ViewModel {
    func test() {
        for _ in (0...10000) {
            DispatchQueue(label: "test", qos: .default)
            //DispatchQueue.main
                .async {
                    objc_sync_enter(cancellables)
                        Just("Test").sink(receiveValue: { value in
                            print(value)
                        }).store(in: &cancellables)
                    objc_sync_exit(cancellables)
            }
        }
    }
}
