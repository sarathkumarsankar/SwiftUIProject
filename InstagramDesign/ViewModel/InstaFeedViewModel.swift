
import Foundation

class InstaFeedViewModel: ObservableObject {
    @Published var users: [Users] = []
    @Published var showError: Bool = false

    let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIServiceManager.shared) {
        self.apiService = apiService
    }
    
    func getData() {
        apiService.excute([Users].self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let page):
                    self?.users = page
                case .failure(let error):
                    print("API Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
