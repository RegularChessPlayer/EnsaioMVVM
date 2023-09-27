import UIKit

protocol ProfileViewProtocol: AnyObject {
    func profileViewDidPressFollowButton()
}

class ProfileView: UIView {
  // MARK: - UI properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var occupationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var followButton: UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
       return button
    }()
    
    internal weak var delegate: ProfileViewProtocol?
    
    public init(viewModel: ProfileViewModel, frame: CGRect) {
        super.init(frame: frame)
        
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() { // method that is called once the layout is already defined
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    @objc private func didTapButton() {
        delegate?.profileViewDidPressFollowButton()
    }
    // If during your view's lifecycle you need some update of the layout,
    // you should notify that a layout change is needed and call setNeedsLayout
}

extension ProfileView: ViewCodeProtocol {
    
    private enum profileConstants {
        static let imageLeading: CGFloat = 16
        static let imageHeight: CGFloat = 80
        static let imageWidth: CGFloat = 80
        static let imageToStackSpacing: CGFloat = 48
        static let stackTop: CGFloat = 8
        static let stackBotton: CGFloat = -8
        static let stackTrailing: CGFloat = -8
    }
    
    internal func buildViewHierarchy() {
        addSubViews(imageView, stackView)
        stackView.addArrangedSubviews(
            nameLabel,
            occupationLabel,
            ageLabel, genderLabel,
            followButton
        )
    }
    
    internal func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: profileConstants.imageLeading),
            imageView.heightAnchor.constraint(equalToConstant: profileConstants.imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: profileConstants.imageWidth),

            stackView.topAnchor.constraint(equalTo: topAnchor, constant: profileConstants.stackTop),
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: profileConstants.imageToStackSpacing),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: profileConstants.stackTrailing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: profileConstants.stackBotton)
        ])
    }
    
    internal func configureViews() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 1
    }
    
    internal func fillProfileInfo(
        image: String,
        name: String,
        age: String,
        occupation: String,
        gender: String,
        isFollow: Bool
    ) { // data is dynamic and may change during the lifecycle.
        imageView.image = UIImage(named: image)
        configProfileInfo(name: name, occupation: occupation, age: age, gender: gender)
        configButton(isFollow: isFollow)
    }
    
    private func configProfileInfo(name: String, occupation: String, age: String, gender: String) {
        nameLabel.text = "Name: \(name)"
        occupationLabel.text = "Occupation: \(occupation)"
        ageLabel.text = "Age: \(age)"
        genderLabel.text = "Gender: \(gender)"
    }
    
    private func configButton(isFollow: Bool) {
        followButton.setTitle(isFollow ? "Unfollow" : "Follow", for: .normal)
        followButton.setTitleColor(isFollow ? UIColor.systemRed : .systemBlue, for: .normal)
    }
    
}

/** to SetupConstraints
 1 . First element of the relation
 2. Second element of the relation
 3. Anchor of the first element
 4. Anchor of the second element
 5. Constant
    handling a dynamic constraint example:
 var shouldDeclareConstraint = true
 firstLabel.bottomAnchor.constraint(equalTo: secondLabel.topAnchor, constant: 12).isActive = shouldDeclareConstraint
*/
