public protocol ViewCodeProtocol: AnyObject {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
}

public extension UIView: ViewCodeProtocol {
    override viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()
    }
    
    func applyViewCode() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
