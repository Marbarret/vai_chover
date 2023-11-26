import SwiftUI
import CoreLocation

struct ContentView: View {
    enum TipoView: String, CaseIterable {
        case viewA = "View A"
        case viewB = "View B"
        case viewC = "View C"
    }
    
    @State private var tipoView: TipoView?
    @State private var mostrarMaisOpcoes = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    menuPrincipal
                    
                    if mostrarMaisOpcoes {
                        opcoesAdicionais
                        Button("Ver Menos") {
                            mostrarMaisOpcoes.toggle()
                        }
                        .foregroundColor(.blue)
                    } else {
                        Button("Ver Mais") {
                            mostrarMaisOpcoes.toggle()
                        }
                        .foregroundColor(.blue)
                    }
                }
                .padding()
                
                NavigationLink("", destination: viewSelecionada, tag: tipoView ?? .viewA, selection: $tipoView)
                    .hidden()
            }
            .navigationTitle("Seleção de Views")
        }
    }
    
    func botaoSelecao(tipo: TipoView) -> some View {
        Button(action: {
            self.tipoView = tipo
        }) {
            Text(nomeDaView(tipo: tipo))
                .padding()
                .background(tipoView == tipo ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
    
    func nomeDaView(tipo: TipoView) -> String {
        switch tipo {
        case .viewA:
            return "View A"
        case .viewB:
            return "View B"
        case .viewC:
            return "View C"
        }
    }
    
    @ViewBuilder
    var viewSelecionada: some View {
        switch tipoView {
        case .viewA:
            ViewA()
        case .viewB:
            ViewB()
        case .viewC:
            ViewC()
        case .none:
            EmptyView()
        }
    }
    
    var menuPrincipal: some View {
        Group {
            botaoSelecao(tipo: .viewA)
            botaoSelecao(tipo: .viewB)
        }
    }
    
    var opcoesAdicionais: some View {
        Group {
            botaoSelecao(tipo: .viewC)
        }
    }
}

struct ViewA: View {
    var body: some View {
        Text("Esta é a View A")
    }
}

struct ViewB: View {
    var body: some View {
        Text("Esta é a View B")
    }
}

struct ViewC: View {
    var body: some View {
        Text("Esta é a View C")
    }
}

struct ContentViewExe: View {
    @ObservedObject var viewModel: WeatherViewModel
    @StateObject private var locationDelegate = LocationDelegate()
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Weather Information")
                .font(.title)
            
            if let weatherData = viewModel.weather {
                Text("Temperature: \(viewModel.temperature)")
                Text("Description: \(viewModel.weather?.name ?? "")")
            } else {
                Text("Loading weather data...")
            }
            
            Button("Get Weather") {
                Task {
                    requestLocation()
                    //                    viewModel.fetchWeatherForecast(for: "Campinas")
                }
            }
        }
        .padding()
        .onAppear {
            requestLocation()
        }
        .onChange(of: locationDelegate.userLocation) { userLocation in
            if let userLocation = userLocation {
                viewModel.fetchWeather(for: userLocation)
            }
        }
    }
}

extension ContentViewExe {
    private func requestLocation() {
        viewModel.isLoading = true
        
        let locationManager = CLLocationManager()
        locationManager.delegate = locationDelegate
        
        // Verifica se a permissão de localização já foi concedida
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        }
    }
    
    
}

class LocationDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocation?

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        userLocation = location
        manager.stopUpdatingLocation()

        // Se necessário, notifique outras partes do seu aplicativo sobre a atualização de localização.
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")

        // Se necessário, notifique outras partes do seu aplicativo sobre o erro de localização.
    }
}
