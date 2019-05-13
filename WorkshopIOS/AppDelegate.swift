//
//  AppDelegate.swift
//  WorkshopIOS
//
//  Created by Paker on 14/2/19.
//  Copyright © 2019 Paker. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

extension Notification.Name {
    static let RecarregarClientes = Notification.Name("RecarregarClientes")
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let navigationController = UINavigationController(rootViewController: ClientesViewController())
        navigationController.navigationBar.barTintColor = UIColor(hex: "#AEC849")
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        window?.rootViewController = navigationController
        window!.makeKeyAndVisible()

        //Enables IQ keyboard manager
        IQKeyboardManager.shared.enable = true

        more()

        return true
    }

    func more() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let insert = webservice.prefix(2)
            webservice = Array(webservice.dropFirst(2))
            tb_clientes.append(contentsOf: insert)

            NotificationCenter.default.post(name: .RecarregarClientes, object: nil)

            if !webservice.isEmpty {
                self.more()
            }
        }
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var rgbValue: UInt32 = 0
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1
        scanner.scanHexInt32(&rgbValue)
        self.init(red: CGFloat(((rgbValue & 0xff0000) >> 16)) / 255.0, green: CGFloat(((rgbValue & 0xff00) >> 8)) / 255.0, blue: CGFloat((rgbValue & 0xff)) / 255.0, alpha: alpha)
    }
}
