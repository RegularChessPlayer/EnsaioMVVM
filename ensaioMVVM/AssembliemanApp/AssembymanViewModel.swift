import Foundation

protocol AssembliemanViewModelProtocol: AnyObject {
    func profileViewModelUpdateProfileView(
        image: String,
        name: String,
        age: String,
        occupation: String,
        gender: String,
        isFollow: Bool
    )
}

public class AssembliemanViewModel {
    
    internal weak var delegate: AssembliemanViewModelProtocol?
    private let assembliemanService = AssemblyManService()
    
    private var profile = Assemblieman(
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
                    self.profile = Assemblieman(
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
    
    internal func loadAssembliemanDataInfoNetworkingRequest() {
        NetwokingRequest.load(Assemblyman.all) { [weak self] result in
            guard let self = self else  { return }
            switch result {
            case .success((let statusCode, let dataDecoder)):
                print(dataDecoder)
            case .failure(let error):
                print(error)
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

