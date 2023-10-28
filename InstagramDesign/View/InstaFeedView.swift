import SwiftUI
import CachedAsyncImage
import Combine

struct InstaFeedView: View {
    @StateObject var viewModel = InstaFeedViewModel()
    
    var body: some View {
        List(viewModel.users, id: \.id, rowContent: { user in
            VStack {
                Text(user.author)
                ImageView(imageUrl: URL(string: user.imageUrl)!)
            }
        })
        .task {
            viewModel.getData()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text("Alert"), message: Text("Try again"), dismissButton: .default(Text("Dismiss")))
        }
    }
    
}

struct InstaFeedView_Previews: PreviewProvider {
    static var previews: some View {
        InstaFeedView()
    }
}
