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
                        .frame(width: 35, height: 35, alignment: .center)
                        .overlay(
                            Circle()
                                .stroke(Color(red: 0.35, green: 0.65, blue: 0.96).opacity(0.2), lineWidth: 1)
                        )
                    
                    Image("location")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black)
                        .frame(width: 22, height: 22, alignment: .center)
                }
            }
        }
        .padding(.bottom, 40)
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
