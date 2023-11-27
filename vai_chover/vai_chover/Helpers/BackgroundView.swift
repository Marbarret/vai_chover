import SwiftUI

struct BackgroundView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color.orange.opacity(0.03)
            
            ZStack {
                Circle()
                    .blur(radius: 3)
                    .foregroundColor(CustomTheme.primary200.color)
                    .frame(width: 200, height: 200)
                    .offset(x: -150, y: 350)
                
                Circle()
                    .foregroundColor(CustomTheme.primary200.color)
                    .frame(width: 300, height: 300)
                    .offset(x: 150, y: -350)
                
                Circle()
                    .stroke(CustomTheme.primary200.color, lineWidth: 2)
                    .frame(width: 300, height: 300)
                    .offset(x: 150, y: -300)
                
                content
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
