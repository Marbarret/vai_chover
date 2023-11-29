import SwiftUI
import CoreLocation

struct HeaderView: View {
    @StateObject private var locationDelegate = LocationDelegate()
    @ObservedObject var viewModel: WeatherViewModel
    @State var text = ""
    
    var onLocationUpdate: ((CLLocation) -> Void)
    
    var body: some View {
        HStack {
            SearchView(text: $text, placeholder: "Digite a cidade") {
                viewModel.fetchCity(text)
            }
            
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
