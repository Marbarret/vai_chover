import SwiftUI
import CoreLocation

struct HeaderView: View {
    @StateObject private var locationDelegate = LocationDelegate()
    @ObservedObject var viewModel: WeatherViewModel
    
    var onLocationUpdate: ((CLLocation) -> Void)
    
    var body: some View {
        HStack {
            
            Spacer()
            
            Button(action: { locationDelegate.requestLocation() }) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 50, height: 50, alignment: .center)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                    
                    Image("location")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black)
                        .frame(width: 30, height: 30, alignment: .center)
                }
            }
        }
        .onAppear {
            locationDelegate.requestLocation()
        }
        .onChange(of: locationDelegate.userLocation) { userLocation in
            if let userLocation = userLocation {
                onLocationUpdate(userLocation)
            }
        }
    }
}

struct FooterView: View {
    @Binding var isDarkModeOn: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            ZStack{
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(isDarkModeOn ? .black : .white)
                Image(systemName: isDarkModeOn ? "sun.max.fill" : "moon.fill")
                    .foregroundColor(isDarkModeOn ? .white : .black)
                
            }
            .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
            .padding(24)
        }
        .onTapGesture {
            self.isDarkModeOn.toggle()
        }
    }
}
