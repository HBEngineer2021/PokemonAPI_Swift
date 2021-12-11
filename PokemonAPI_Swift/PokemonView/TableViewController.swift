//
//  TableViewController.swift
//  PokemonAPI_Swift
//
//  Created by Motoki Onayama on 2021/10/09.
//

import UIKit
import Alamofire

class TableViewController: UIViewController {
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    var pokemonList = [Models]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //PokemonData()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.pokemonTableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        pokemonList = ModelManager.getInstance().getOokemonsData()
        self.pokemonTableView.reloadData()
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.numberLbl.text = "No." + "\(pokemonList[indexPath.row].id)"
        cell.pokemonName.text = pokemonList[indexPath.row].name
        cell.pokemonImage.image = UIImage(url: pokemonList[indexPath.row].image)
        
        return cell
    }
    
    
}
extension UIImage {
    public convenience init(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}
