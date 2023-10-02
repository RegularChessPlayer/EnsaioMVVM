import UIKit

class ViewController: UIViewController {
    
    private lazy var assembliemanViewModel = AssembliemanViewModel() //
    
    private lazy var assembliemanProfileView: AssembliemanView = {
        let profileView = AssembliemanView(frame: CGRect(origin: .zero, size: .zero))
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()
        assembliemanViewModel.loadAssembliemanDataInfo()
    }

}

extension ViewController: ViewCodeProtocol {
    
    private enum Constants {
        static let profileTop: CGFloat = 100
        static let profileLeading: CGFloat = 16
        static let profileTrailing: CGFloat = -16
    }
    
    internal func buildViewHierarchy() {
        view.addSubview(assembliemanProfileView)
    }
    
    internal func setupConstraints() {
        NSLayoutConstraint.activate([
            assembliemanProfileView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: Constants.profileTop
            ),
            assembliemanProfileView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.profileLeading
            ),
            assembliemanProfileView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.profileTrailing
            ),
        ])
    }
    
    internal func configureViews() {
        assembliemanProfileView.delegate = self //binding view
        assembliemanViewModel.delegate = self
        assembliemanViewModel.updateView()
    }
    
}

extension ViewController: AssembliemanViewProtocol {
    
    internal func profileViewDidPressFollowButton() {
        assembliemanViewModel.profileViewDidPressFollowButton()
    }
    
}

extension ViewController: AssembliemanViewModelProtocol {
    
    internal func profileViewModelUpdateProfileView(
        image: String,
        name: String,
        age: String,
        occupation: String,
        gender: String,
        isFollow: Bool
    ) {
        assembliemanProfileView.fillProfileInfo(
            image: image,
            name: name,
            age: age,
            occupation: occupation,
            gender: gender,
            isFollow: isFollow
        )
    }

}
