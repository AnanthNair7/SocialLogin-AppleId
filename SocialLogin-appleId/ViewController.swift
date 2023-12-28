//
//  ViewController.swift
//  SocialLogin-appleId
//
//  Created by Ananth Nair on 12/12/23.
//

import AuthenticationServices
import UIKit

class ViewController: UIViewController {
    
    private let authenticateButton = ASAuthorizationAppleIDButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(authenticateButton)
        authenticateButton.addTarget(self, action: #selector(didAuthenticateTapped), for: .touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        authenticateButton.frame=CGRect(x: 0, y: 0, width: 250, height: 50)
        authenticateButton.center = view.center
    }
    
    @objc func  didAuthenticateTapped() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
        
    }
    
    
}
extension ViewController : ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Failed")
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential :
            let firstName = credentials.fullName?.givenName
            let lastName = credentials.fullName?.familyName
            let email = credentials.email
            break
        default :
            break
        }
    }
}

extension ViewController : ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
}

