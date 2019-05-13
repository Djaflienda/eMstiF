//
//  SavingManager.swift
//  FitsMe
//
//  Created by MacBook-Игорь on 19/04/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//

import Foundation

class ClothDataManager {
    
    static let shared = ClothDataManager()
    
    private init() {}
    
    var clothArray  = [Cloth]()
    
    func save() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("ClothArray.plist")
        print(path)
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(clothArray)
            try data.write(to: path, options: .atomic)
        } catch {
            print("Error encoding otem array")
        }
    }
    
    func loadFromFile() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("ClothArray.plist")
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                clothArray = try decoder.decode([Cloth].self, from: data)
            } catch {
                print("Error decoding item array")
            }
        }
    }
    
    func deleteFileWith() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("ClothArray.plist")
        do {
            try FileManager.default.removeItem(at: path)
        } catch {
            print("Error while deleting category nested list")
        }
    }
}
