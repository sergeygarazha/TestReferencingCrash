import SwiftUI

struct ContentView: View {
    let buttonAction: () -> Void

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button(action: buttonAction) {
                Text("Test")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(buttonAction: {})
    }
}
