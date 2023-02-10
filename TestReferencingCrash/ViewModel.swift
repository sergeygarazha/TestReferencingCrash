import Foundation
import Combine

private var cancellables: Set<AnyCancellable> = []

class ViewModel {
    func test() {
        for _ in (0...1000) {
            DispatchQueue(label: "test", qos: .default)
            //DispatchQueue.main
                .async {
                Just("Test").sink(receiveValue: { value in
                    print(value)
                }).store(in: &cancellables)
            }
        }
    }
}
