import SwiftUI
import MapKit
import AuthenticationServices

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn = false
    @State private var isRegistering = false
    
    var body: some View {
        if isLoggedIn {
            MapView()
        } else if isRegistering {
            RegisterView(isRegistering: $isRegistering)
        } else {
            VStack {
                Text("Welcome to Oasis Secure")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    withAnimation {
                        isLoggedIn = true // Simulating login success
                    }
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    withAnimation {
                        isRegistering = true
                    }
                }) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
                .buttonStyle(PlainButtonStyle())
                
                // Sign in with Apple
                SignInWithAppleButton(
                    .signIn,
                    onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: { result in
                        switch result {
                        case .success:
                            isLoggedIn = true
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                )
                .frame(height: 50)
                .padding()
                
                // Google Sign-In Button (Placeholder)
                Button(action: {
                    print("Google Sign-In tapped")
                    isLoggedIn = true // Simulating Google login success
                }) {
                    HStack {
                        Image(systemName: "g.circle.fill")
                            .foregroundColor(.red)
                        Text("Sign in with Google")
                            .font(.headline)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }
}

struct RegisterView: View {
    @Binding var isRegistering: Bool
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    
    var body: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            TextField("Full Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Address", text: $address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Phone Number", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                withAnimation {
                    isRegistering = false
                }
            }) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding()
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                withAnimation {
                    isRegistering = false
                }
            }) {
                Text("Back to Login")
                    .foregroundColor(.blue)
            }
            .padding()
        }
        .padding()
    }
}

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                // Top Nav Bar
                HStack {
                    Button(action: { print("Menu tapped") }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                    }
                    Spacer()
                    Text("Oasis")
                        .font(.headline)
                    Spacer()
                    Button(action: { print("Settings tapped") }) {
                        Image(systemName: "gear")
                            .font(.title)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                
                // Map
                Map(position: $viewModel.cameraPosition) {
                    UserAnnotation() // shows user location pin
                }
                .ignoresSafeArea()
                .onAppear {
                    viewModel.CheckIfLocationServicesEnabled()
                }


                
                .edgesIgnoringSafeArea(.all)
                
                .onAppear {
                    viewModel.CheckIfLocationServicesEnabled()
                }

                
                // Bottom Navigation Bar
                HStack {
                    Button(action: { print("Home tapped") }) {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    }
                    Spacer()
                    Button(action: { print("Community tapped") }) {
                        VStack {
                            Image(systemName: "person.2.circle.fill")
                            Text("Community")
                        }
                    }
                    Spacer()
                    Button(action: { print("Profile tapped") }) {
                        VStack {
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
            }
            
            // recenter button
            Button(action: {viewModel.recenter()}){
                Image(systemName: "location.fill")
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
            .padding(.bottom, 100)
            .padding(.trailing, 20)
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}






