//
//  PokemonAnotacao.swift
//  PokemonGO
//
//  Created by Nelson Antonio Barbosa Margalho Junior on 27/03/21.
//  Copyright © 2021 JuniorMargalho. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnotacao: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    
    init(coordenadas: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coordenadas
        self.pokemon = pokemon
        
    }
    
}
