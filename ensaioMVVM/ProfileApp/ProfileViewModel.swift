import Foundation

protocol ProfileViewModelProtocol: AnyObject {
    func profileViewModelUpdateProfileView(image: String,
                                           name: String,
                                           age: String,
                                           occupation: String,
                                           gender: String,
                                           isFollow: Bool)
}

public class ProfileViewModel {
    
    internal weak var delegate: ProfileViewModelProtocol?
    private let assembliemanService = AssemblyManService()
    
    private var profile = Profile(
        image: "profile01",
        name: "Thiago R.",
        age: "30",
        address: nil,
        occupation: "developer",
        gender: "Male",
        isFollow: false
    )
    
    internal func loadAssembliemanDataInfo() {
        assembliemanService.getAssembliesmanGeneralInfo { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let assemblieMan = response.dados.first {
                    self.profile = Profile(
                        image: assemblieMan.urlFoto,
                        name: assemblieMan.email,
                        age: "30",
                        address: assemblieMan.email,
                        occupation: assemblieMan.uriPartido,
                        gender: "Male",
                        isFollow: false
                    )
                }
                self.updateView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func profileViewDidPressFollowButton() {
        profile.isFollow = !profile.isFollow
        updateView()
    }
    
    internal func updateView() {
        DispatchQueue.main.async {
            self.delegate?.profileViewModelUpdateProfileView(
                image: self.profile.image,
                name: self.profile.name,
                age: self.profile.age,
                occupation: self.profile.occupation,
                gender: self.profile.gender,
                isFollow: self.profile.isFollow
            )
        }
    }
}

/** Review Model
 
 - Do not import UIKit/SwiftUI
 - Contains only business logic
 - Is testable with Dependency Injection
 - Calls network service
 - Its code coverage should be 100%
 
 */

