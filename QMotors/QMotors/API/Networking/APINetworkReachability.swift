//
//  APINetworkReachability.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 19.07.22.
//

import Foundation
import Alamofire

class APINetworkReachability {
  static let shared = APINetworkReachability()
  let offlineAlertController: UIAlertController = {
    UIAlertController(title: "No Network", message: "Please connect to network and try again", preferredStyle: .alert)
  }()

  func showOfflineAlert() {
    let rootViewController = UIApplication.shared.windows.first?.rootViewController
    rootViewController?.present(offlineAlertController, animated: true, completion: nil)
  }

  func dismissOfflineAlert() {
    let rootViewController = UIApplication.shared.windows.first?.rootViewController
    rootViewController?.dismiss(animated: true, completion: nil)
  }
}
