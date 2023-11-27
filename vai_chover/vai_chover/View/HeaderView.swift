import SwiftUI
import CoreLocation

struct HeaderView: View {
    @StateObject private var locationDelegate = LocationDelegate()
    @ObservedObject var viewModel: WeatherViewModel
    @Binding var isDarkModeOn: Bool
    var onLocationUpdate: ((CLLocation) -> Void)
    
    var body: some View {
        HStack {
            ZStack {
                Capsule()
                    .frame(width: 80, height: 44)
                    .foregroundColor(isDarkModeOn ? .white : .black.opacity(0.4))
                ZStack{
                    Circle()
                        .frame(width:40, height:40)
                        .foregroundColor(isDarkModeOn ? .white : .black)
                    Image(systemName: isDarkModeOn ? "sun.max.fill" : "moon.fill")
                        .foregroundColor(isDarkModeOn ? .black : .white)
                    
                }
                .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
                .offset(x: isDarkModeOn ? 18 : -18)
                .padding(24)
                .animation(.spring())
            }
            .onTapGesture {
                self.isDarkModeOn.toggle()
            }
            
            Spacer()
            
            Button(action: { locationDelegate.requestLocation() }) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 50, height: 50, alignment: .center)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                    
                    Image(systemName: "cart")
                        .font(.title)
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
