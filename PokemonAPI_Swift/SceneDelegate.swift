//
//  SceneDelegate.swift
//  PokemonAPI_Swift
//
//  Created by Motoki Onayama on 2021/10/09.
//

import UIKit
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var pokemonList = [Models]()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene as! UIWindowScene)
        self.window = window
        
        window.backgroundColor = .white
        
        PokemonData()
        
        let backGround = UIImageView()
        
        backGround.image = UIImage(named: "Picturebook.jpg")
        
        backGround.frame.size = CGSize(width: window.frame.width, height: window.frame.height/2 - 100)
        
        backGround.center = window.center
        
        window.addSubview(backGround)
        
        let indicator = UIActivityIndicatorView()
        
        indicator.center = window.center
        
        indicator.style = .large
        
        indicator.color = .red
        
        window.addSubview(indicator)
        
        let view = UIView()
        
        view.frame.size = CGSize(width: window.frame.width, height: window.frame.height)
        
        view.backgroundColor = .systemGray
        
        view.alpha = 0.5
        
        window.addSubview(view)
        
        let getInfoLbl = UILabel()
        getInfoLbl.frame.size = CGSize(width: window.bounds.width/2 + 150, height: window.bounds.height/2 + 200)
        getInfoLbl.bounds.size = CGSize(width: window.bounds.width/2, height: window.bounds.height/2)
        getInfoLbl.textAlignment = .center
        getInfoLbl.textColor = .black
        getInfoLbl.text = "情報を取得中です..."
        window.addSubview(getInfoLbl)
        indicator.stopAnimating()
        
        indicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 13.5) {
            view.frame.size = CGSize(width: window.frame.width, height: window.frame.height)
            view.backgroundColor = .white
            window.addSubview(view)
            let Lbl = UILabel()
            Lbl.frame.size = CGSize(width: 200, height: 400)
            Lbl.bounds.size = CGSize(width: window.bounds.width/2, height: window.bounds.height/2)
            Lbl.textAlignment = .center
            Lbl.center = window.center
            Lbl.textColor = .black
            Lbl.text = "情報の取得完了です！"
            getInfoLbl.isHidden = true
            window.addSubview(Lbl)
            indicator.stopAnimating()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 16.0) {
            
            let dest = TableViewController.init(nibName: "TableViewController", bundle: nil)
            let nc = UINavigationController(rootViewController: dest)
            window.rootViewController = nc
        }
        window.makeKeyAndVisible()
    }
    
    func PokemonData() {
        
        for i in 1 ... 899 {
            let path = "\(i)"
            
            let prams: Parameters = [:]
            
            APIRequest.shared.get(path: path, prams: prams, type: Pokemon.self) { response in
                //print(response.id)
                //print(response.name)
                //print(response.sprites.frontDefault)
                //print(response.typeList)
                let save = ModelManager.getInstance().Save(pokemon: Models(id: response.id, name: response.name, image: response.sprites.frontDefault))
                print("save", save)
            }
        }
        pokemonList = ModelManager.getInstance().getOokemonsData()
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

