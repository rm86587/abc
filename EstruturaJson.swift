//
//  EstruturaJson.swift
//  Exercício Fixação Pokemon
//
//  Created by Usuário Convidado on 23/09/24.
//

import Foundation

struct UmPokemon:Decodable{
    var id: Int
    var name: String
    var sprites: Sprites
}

struct Sprites:Decodable{
    var front_default:String
}
