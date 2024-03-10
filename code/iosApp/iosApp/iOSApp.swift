import SwiftUI

@main
struct iOSApp: App {
	var body: some Scene {
		WindowGroup {
            TabView {
                CalculatorView()
                    .tabItem {
                        Label("Calculator", systemImage: "plus")
                    }
                TickView()
                    .tabItem {
                        Label("Tick", systemImage: "clock")
                    }
                ChatRoomView()
                    .tabItem {
                        Label("ChatRoom", systemImage: "message")
                    }
            }
		}
	}
}
