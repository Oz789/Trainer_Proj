import SwiftUI

struct ContentView: View {
    var body: some View {
        RootLogInView()
    }
}

#Preview {
    let tm = ThemeManager()
    return ContentView()
        .environmentObject(tm)
}
