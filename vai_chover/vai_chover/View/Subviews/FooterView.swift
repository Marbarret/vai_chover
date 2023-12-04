import SwiftUI

struct FooterView: View {
    @Binding var isDarkModeOn: Bool
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(isDarkModeOn ? .black : .white)
            Image(systemName: isDarkModeOn ? "sun.max.fill" : "moon.fill")
                .foregroundColor(isDarkModeOn ? .white : .black)
            
        }
        .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
        .padding(24)
        .onTapGesture {
            self.isDarkModeOn.toggle()
        }
    }
}
