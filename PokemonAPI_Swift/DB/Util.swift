//
//  Util.swift
//  PokemonAPI_Swift
//
//  Created by Motoki Onayama on 2021/10/10.
//

import Foundation
import UIKit

class Util {
   
   static let share = Util()
   
   func getPath(dbName: String) -> String {
       let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
       let fileUrl = documentDirectory.appendingPathComponent(dbName)
    print(fileUrl)
       return fileUrl.path
   }
   
   func copyDatabase(dbName: String) {
       let dbPath = getPath(dbName: "PokemonDB.db")
       let fileManager = FileManager.default
       
       if !fileManager.fileExists(atPath: dbPath) {
           let bundle = Bundle.main.resourceURL
           let file = bundle?.appendingPathComponent(dbName)
           do {
               try fileManager.copyItem(atPath: file!.path, toPath: dbPath)
           }
           catch let err {
               print(err.localizedDescription)
           }
       }
   }
}

