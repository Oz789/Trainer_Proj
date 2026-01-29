import SwiftUI

struct UserRootProfileView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // MARK: - Profile Header
                        VStack(spacing: 16) {
                            ZStack(alignment: .bottomTrailing) {
                                Circle()
                                    .fill(LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 100, height: 100)
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .font(.system(size: 50))
                                            .foregroundStyle(.white)
                                    )
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.blue)
                                    .background(Circle().fill(.white))
                                    .offset(x: -2, y: -2)
                            }

                            VStack(spacing: 4) {
                                Text("Oz")
                                    .font(.title2.bold())
                                Text("@oz_fit")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        // MARK: - Stats Row
                        HStack(spacing: 40) {
                            StatView(value: "128", label: "Workouts")
                            StatView(value: "1.2k", label: "Followers")
                            StatView(value: "450", label: "Following")
                        }
                        
                        // MARK: - Action Buttons
                        HStack(spacing: 12) {
                            Button {} label: {
                                Text("Edit Profile")
                                    .font(.subheadline.weight(.semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(Color.white.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            
                            Button {} label: {
                                Text("Share Profile")
                                    .font(.subheadline.weight(.semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(Color.white.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .padding(.horizontal)

                        // MARK: - Content Picker
                        VStack(spacing: 0) {
                            HStack {
                                TabButton(title: "Activity", isActive: selectedTab == 0) { selectedTab = 0 }
                                TabButton(title: "Achievements", isActive: selectedTab == 1) { selectedTab = 1 }
                            }
                            
                            Divider().background(Color.white.opacity(0.2))
                            
                            // Placeholder for Grid/List Content
                            LazyVStack(spacing: 15) {
                                ForEach(0..<5) { _ in
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white.opacity(0.05))
                                        .frame(height: 100)
                                        .overlay(
                                            HStack {
                                                Image(systemName: "figure.cross.training")
                                                    .font(.title)
                                                    .padding()
                                                VStack(alignment: .leading) {
                                                    Text("Morning HIIT Session")
                                                        .font(.headline)
                                                    Text("45 mins • 320 kcal")
                                                        .font(.caption)
                                                        .foregroundStyle(.secondary)
                                                }
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .padding()
                                            }
                                        )
                                }
                            }
                            .padding()
                        }
                    }
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.white)
                    }
                }
            }
            .foregroundStyle(.white)
        }
    }
}

// MARK: - Helper Views

struct StatView: View {
    let value: String
    let label: String
    var body: some View {
        VStack {
            Text(value).font(.headline).bold()
            Text(label).font(.caption).foregroundStyle(.secondary)
        }
    }
}

struct TabButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 14, weight: isActive ? .bold : .medium))
                    .foregroundStyle(isActive ? .white : .secondary)
                
                ZStack {
                    Rectangle()
                        .fill(isActive ? Color.white : Color.clear)
                        .frame(height: 2)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    UserRootProfileView()
        .preferredColorScheme(.dark)
}
