//
//  ContentView.swift
//  converter
//
//  Created by Julio Cesar Guzman Villanueva on 2/20/24.
//

import SwiftUI
import spatialvideo

struct ContentView: View {
    @State private var image = Image(systemName: "bolt")
    @State private var description = ""

    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .dropDestination(for: Data.self) { sideBySideVideos, location in
                    image = Image(systemName: "bolt.fill")
                    Task {
                        for sideBySideVideo in sideBySideVideos {
                            do {
                                let videoPath = try await spatialVideo(with: sideBySideVideo)
                                print("MV-HEVC video encoded to \(videoPath)")
                                image = Image(systemName: "bolt")
                            } catch {
                                print("error \(error)")
                                description = error.localizedDescription
                                image = Image(systemName: "bolt.trianglebadge.exclamationmark")
                            }
                        }
                    }
                    return true
                }
            Text(description)
        }
    }
}

func spatialVideo(with videoData: Data) async throws -> URL {
    let sideBySideVideoURL = URL.documentsDirectory.appending(path: "input-\(UUID().uuidString).mp4")
    try videoData.write(to: sideBySideVideoURL, options: [.atomic, .completeFileProtection])
    let spatialVideo = try await spatialVideo(from: sideBySideVideoURL)
    return spatialVideo
}

#Preview {
    ContentView()
}
