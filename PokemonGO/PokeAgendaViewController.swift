//
//  PokeAgendaViewController.swift
//  PokemonGO
//
//  Created by Nelson Antonio Barbosa Margalho Junior on 27/03/21.
//  Copyright © 2021 JuniorMargalho. All rights reserved.
//

import UIKit

class PokeAgendaViewController: UIViewController {
    var pokemonsCapturados: [Pokemon] = []
    var pokemonsNaoCapturados: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let coreDataPokemon = CoreDataPokemon()
        self.pokemonsCapturados = coreDataPokemon.recuperarPokemonsCapturados(capturado: true)
        self.pokemonsNaoCapturados = coreDataPokemon.recuperarPokemonsCapturados(capturado: false)
        
        print(String(self.pokemonsNaoCapturados.count))

    }
    
    @IBAction func voltarMapa(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
}
