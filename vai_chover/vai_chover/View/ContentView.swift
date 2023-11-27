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
    @State private var userLocation: CLLocation?
    @AppStorage("isDarkModeOn") private var isDarkModeOn: Bool = false

    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        BackgroundView {
            VStack {
                HeaderView(viewModel: viewModel, isDarkModeOn: $isDarkModeOn) { location in
                    viewModel.userLocation = location
                    viewModel.fetchWeather()
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 5)
                .padding(.top, UIApplication
                    .shared
                    .connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }?.safeAreaInsets.top)
                
                VStack(spacing: 12) {
                    if viewModel.weather != nil {
                        Text("\(viewModel.temperature)C")
                            .font(.system(size: 100))
                            .bold()
                        
                        Text("Description: \(viewModel.weather?.name ?? "")")
                    } else {
                        Text("Loading weather data...")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .foregroundStyle(Color.white)
//                .padding(.horizontal, 30)
//                .padding(.top, 35)
//                .padding(.bottom, 25)
                .contentShape(Rectangle())
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(CustomTheme.primary100.color)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(Color.black.opacity(0.02), lineWidth: 1.5)
                        )
                }
                .shadow(color: .black.opacity(0.2), radius: 5)
                .padding(.horizontal, 15)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
        .background {
            Rectangle()
                .fill(isDarkModeOn ? CustomTheme.bg100.color : .black)
                .ignoresSafeArea()
        }
    }
}
