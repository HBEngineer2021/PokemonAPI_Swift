//
//  ModelManager.swift
//  PokemonAPI_Swift
//
//  Created by Motoki Onayama on 2021/10/10.
//

import Foundation
import UIKit
import FMDB

var shareInstace = ModelManager()

class ModelManager {
    
    var database: FMDatabase? = nil
    
    static func getInstance() -> ModelManager {
        if shareInstace.database == nil {
            shareInstace.database = FMDatabase(path: Util.share.getPath(dbName: "PokemonDB.db"))
        }
        return shareInstace
    }
    // Save and delete from here
    func Save(pokemon: Models) -> Bool {
        shareInstace.database?.open()
        
        let isSave = shareInstace.database?.executeUpdate("INSERT INTO pokemon_info(id, name, image) VALUES(?, ?, ?)", withArgumentsIn: [pokemon.id, pokemon.name, pokemon.image])
        
        shareInstace.database?.close()
        return isSave!
    }
    
    func getOokemonsData() -> [Models] {
        shareInstace.database?.open()
        var pokemons = [Models]()
        do {
            let resultset : FMResultSet? = try shareInstace.database?.executeQuery("SELECT * FROM pokemon_info", values: nil)
            if resultset != nil{
                while resultset!.next() {
                    let pokemon = Models(id: Int(((resultset?.int(forColumn: "id"))!)), name: (resultset?.string(forColumn: "name"))!, image: (resultset?.string(forColumn: "image"))!)
                    pokemons.append(pokemon)
                }
            }
        }
        catch let err {
            print(err.localizedDescription)
        }
        shareInstace.database?.close()
        return pokemons
    }
}

