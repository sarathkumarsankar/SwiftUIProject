import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct ImageView: View {
    let imageUrl: URL
    
    var body: some View {
        WebImage(url: imageUrl)
            .resizable()
            .placeholder {
                // You can set a placeholder view while the image is being loaded
                Color.gray
            }
            .indicator(.activity) // Show an activity indicator while loading
            .transition(.flipFromBottom) // Add a transition animation
            .scaledToFit()
            .frame(height: 100) // Adjust the height as needed
    }
}
