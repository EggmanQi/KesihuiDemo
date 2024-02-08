//
//  KesihuiDemoApp.swift
//  KesihuiDemo
//
//  Created by P on 2024/2/3.
//

import SwiftUI
//import SwiftData

@main
struct KesihuiDemoApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}

struct SwiftPageWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return SwiftPage()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update the view controller if needed
    }
}

struct SplashView: View {

    @State private var isSwiftPageActive: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("This is Kesihui Demo")
                    .font(.headline)
                    .padding()
                NavigationLink(destination: SwiftPageWrapper()) {
                    Text("Section I - Brain Teasers")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink(destination: ContentView()) {
                    Text("Section II - Write an application")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

#Preview {
    SwiftPageWrapper()
}
