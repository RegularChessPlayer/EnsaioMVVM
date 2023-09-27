import UIKit

class ViewController: UIViewController {
    
    private lazy var profileViewModel = ProfileViewModel()
    
    private lazy var mockProfileView: ProfileView = {
        let profileView = ProfileView(
            viewModel: profileViewModel,
            frame: CGRect(origin: .zero, size: .zero)
        )
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()
        profileViewModel.loadAssembliemanDataInfo()
    }

}

extension ViewController: ViewCodeProtocol {
    
    private enum Constants {
        static let profileTop: CGFloat = 100
        static let profileLeading: CGFloat = 16
        static let profileTrailing: CGFloat = -16
    }
    
    internal func buildViewHierarchy() {
        view.addSubview(mockProfileView)
    }
    
    internal func setupConstraints() {
        NSLayoutConstraint.activate([
            mockProfileView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: Constants.profileTop
            ),
            mockProfileView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.profileLeading
            ),
            mockProfileView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.profileTrailing
            ),
        ])
    }
    
    internal func configureViews() {
        mockProfileView.delegate = self //binding view
        profileViewModel.delegate = self
        profileViewModel.updateView()
    }
    
}

extension ViewController: ProfileViewProtocol {
    
    internal func profileViewDidPressFollowButton() {
        profileViewModel.profileViewDidPressFollowButton()
    }
    
}

extension ViewController: ProfileViewModelProtocol {
    
    internal func profileViewModelUpdateProfileView(
        image: String,
        name: String,
        age: String,
        occupation: String,
        gender: String,
        isFollow: Bool
    ) {
        mockProfileView.fillProfileInfo(
            image: image,
            name: name,
            age: age,
            occupation: occupation,
            gender: gender,
            isFollow: isFollow
        )
    }

}
