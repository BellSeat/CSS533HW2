import SwiftUI

struct ScrumProgressViewStyle: ProgressViewStyle{
    var theme: Theme
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(theme.mainColor)
        }
    }
    
}
