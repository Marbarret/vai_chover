import SwiftUI

struct SearchView: View {
    @Binding var text: String
    var placeholder: String
    var action: () -> Void
   
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Button {
                    action()
                    self.text = ""
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(CustomTheme.bg300.color)
                        .frame(width: 20, height: 20)
                }
                .padding(.horizontal, 10)
                
                TextField(placeholder, text: $text)
                    .foregroundColor(CustomTheme.text200.color)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
        .background(CustomTheme.bg200.color)
        .cornerRadius(15)
    }
}
