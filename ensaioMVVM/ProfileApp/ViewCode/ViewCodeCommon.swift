public protocol ViewCodeProtocol {
    func buildViewHierarchy() // Establishes the hierarchy for each of your subviews by adding each subview to its parent
    func setupConstraints() // Here, you should define the relationships between each view Set constraints
    func configureViews() // Some data (perhaps some view model content) needs to be filled in a little later.
}

public extension ViewCodeProtocol {
    
    func applyViewCode() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func configureViews() { } // Notice that the configureViews method is optional and applyViewCode triggers
}
