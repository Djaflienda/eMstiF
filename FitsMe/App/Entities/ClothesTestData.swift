//
//  ClothesTestData.swift
//  FitsMe
//
//  Created by Sergey Romanchuk on 12/02/2019.
//  Copyright © 2019 Тигран Хачатурян. All rights reserved.
//
//Этот файл надо распечатать и сжеч так как он нужен только для отладки пока не готово API с карточками
import Foundation

class ClothesTestData{
    var count: Int
    var next: Int
    var previous: Int
    var materials:[String]
    var descriptions:[String]
    var photos:[String]
    
    init() {
        self.count = 3000
        self.next = 2
        self.previous = 0
        self.materials = [
            "шерсть",
            "синтетика",
            "кожа",
            "нубук",
            "хлопок",
            "кожзам",
        ]
        self.descriptions = [
            "Струящаяся юбка-парео. Застежка сбоку с поясом из той же ткани.",
            "Дутая куртка в стиле колор блок boohooMAN",
            "Коричневое пальто из искусственной замши с подкладкой из искусственного меха boohooMAN",
            "Облегающее платье в рубчик с молнией сбоку COLLUSION",
            "Платье-комбинация с цветочным принтом и кружевной отделкой ASOS DESIGN",
        ]
        self.photos = [
            "https://images.asos-media.com/products/plate-kombinatsiya-s-tsvetochnym-printom-i-kruzhevnoj-otdelkoj-asos-design/9663079-1-floralprint?$n_480w$&wid=476",
            "https://images.asos-media.com/products/plate-dzhemper-midi-s-v-obraznym-vyrezom-asos-design/9403016-1-camel?$n_480w$&wid=476",
            "https://images.asos-media.com/products/plate-midi-s-tsvetochnoj-vyshivkoj-glamorous/10825651-1-white?$n_480w$&wid=476",
            "https://images.asos-media.com/products/temno-sinee-plate-midi-s-otkrytymi-plechami-ax-paris/11195384-1-blue?$n_480w$&wid=476",
            "https://images.asos-media.com/products/plate-midi-na-odno-plecho-v-polosku-talulah/10628942-1-multistripe?$n_320w$&wid=317&fit=constrain",
        ]
    }
    
//    func get_card() -> Cloth {
//        var materials = [self.materials.randomElement(), self.materials.randomElement(), self.materials.randomElement(), self.materials.randomElement()]
//        var tmp_pics:[[String:Any]] = [["id":1, "url":self.photos.randomElement()]]
////        let pic: [[String:Any]] = [].append(tmp_pics)
//        let card = Cloth(id:11, brand:"ZARA", name:"ОДЕЖА", description:self.descriptions.randomElement()!,  material:materials as! Array<String>, pics:tmp_pics)
//        return card
//    }
    
}

