import SwiftUI

struct SearchView: View {
    @Binding var text: String
    var placeholder: String
    var action: () -> Void
   
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 35)
                .overlay {
                    CustomTheme.bg300.color
                }
                .cornerRadius(10)
            
            HStack {
                Button {
                    action()
                    self.text = ""
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(CustomTheme.bg200.color)
                        .frame(width: 24, height: 24)
                }
                .padding(.horizontal, 10)
                
                TextField(placeholder, text: $text)
                    .foregroundColor(CustomTheme.text200.color)
            }
        }
        .padding(10)
    }
}
