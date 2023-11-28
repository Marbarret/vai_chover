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
    @State private var currentWeatherCondition: WeatherCondition = .clearSky
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        BackgroundView {
            VStack {
                HeaderView(viewModel: viewModel) { location in
                    viewModel.userLocation = location
                    viewModel.fetchWeather()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 5)
                .padding(.top, UIApplication
                    .shared
                    .connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }?.safeAreaInsets.top)
                
                VStack(spacing: 5) {
                    if viewModel.weather != nil {
                        HStack(spacing: 0) {
                            weatherInformations
                            
                            VStack(spacing: 5) {
                                detailWeather
                                HStack {
                                    temperaturaMax
                                    temperaturaMin
                                }
                            }
                        }
                    } else {
                        Text("Loading weather data...")
                            .font(CustomTheme.fontLightInter(size: 20))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 250)
                .foregroundStyle(Color.white)
                .contentShape(Rectangle())
                .padding(.horizontal, 20)
                
                Rectangle()
                    .frame(height: 1.5)
                    .foregroundColor(CustomTheme.primary300.color.opacity(0.4))
                    .padding([.top, .horizontal], 15)
                
                TempRow()
                
                Spacer()
                
                FooterView(isDarkModeOn: $isDarkModeOn)

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
}

extension ContentViewExe {
    var detailWeather: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image("chuva")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            
            Text("Chances de chuva")
                .font(CustomTheme.fontBoldInter(size: 17))
                .foregroundColor(CustomTheme.text100.color)
            
            Text("\(viewModel.calculateRainProbability())%")
                .foregroundColor(CustomTheme.text100.color)
                .font(CustomTheme.fontBoldInter(size: 30))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(10)
        .background(CustomTheme.bg200.color)
        .cornerRadius(12)
    }
    
    var temperaturaMax: some View {
        VStack(alignment: .center, spacing: 5) {
            Image(systemName: "thermometer.high")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            
            Text("Max")
                .font(CustomTheme.fontRegularInter(size: 14))
                .foregroundColor(CustomTheme.text100.color)
            
            Text("\(viewModel.high)C")
                .foregroundColor(CustomTheme.text100.color)
                .font(CustomTheme.fontBoldInter(size: 20))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(10)
        .background(CustomTheme.bg200.color)
        .cornerRadius(12)
    }
    
    var temperaturaMin: some View {
        VStack(alignment: .center, spacing: 5) {
            Image(systemName: "thermometer.low")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            
            Text("Min.")
                .font(CustomTheme.fontRegularInter(size: 14))
                .foregroundColor(CustomTheme.text100.color)
            
            Text("\(viewModel.low)C")
                .foregroundColor(CustomTheme.text100.color)
                .font(CustomTheme.fontBoldInter(size: 20))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(10)
        .background(CustomTheme.bg200.color)
        .cornerRadius(12)
    }
    
    var weatherInformations: some View {
        VStack(spacing: 10) {
            viewModel.currentWeatherCondition.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            Text("\(viewModel.temperature)C")
                .foregroundColor(CustomTheme.text100.color)
                .font(CustomTheme.fontBlacktInter(size: 40))
                .bold()
                .offset(y: -20)
            
            VStack(alignment: .center) {
                Text("\(viewModel.name)")
                    .foregroundColor(CustomTheme.text100.color)
                    .font(CustomTheme.fontBoldInter(size: 22))
                
                Text("\(viewModel.day)")
                    .foregroundColor(CustomTheme.text200.color)
                    .font(CustomTheme.fontLightInter(size: 17))
            }
            .padding(.top, 20)
        }
        .padding(.horizontal, 15)
    }
}

struct TempRow: View {
    var body: some View {
        HStack(spacing: 0) {
            Circle()
                .fill(.gray)
                .frame(height: 40)
                .overlay {
                    Image(systemName: "arrow.up.arrow.down")
                        .foregroundColor(.blue)
                        .padding()
                }
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Cidade")
                        .font(.caption)
                        .foregroundColor(CustomTheme.text100.color)
                    
                    Text("12/12")
                        .font(.caption)
                        .foregroundColor(CustomTheme.text100.color)
                }
                .padding(15)
                
                Spacer()
                
                Text("32")
                    .font(.callout)
                    .foregroundColor(.green)
            }
        }
        .padding(10)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 70)
        .background(CustomTheme.bg200.color)
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}
