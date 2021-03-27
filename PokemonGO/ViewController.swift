//
//  ViewController.swift
//  PokemonGO
//
//  Created by Nelson Antonio Barbosa Margalho Junior on 21/03/21.
//  Copyright © 2021 JuniorMargalho. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    var contador = 0
    var coreDataPokemon: CoreDataPokemon!
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
        //recuperar pokemons
        self.coreDataPokemon = CoreDataPokemon()
        self.pokemons = self.coreDataPokemon.recuperarTodosPokemons()
        
        //Exibir Pokemons
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            if let coordenadas = self.gerenciadorLocalizacao.location?.coordinate {
                let totalPokemons = UInt32(self.pokemons.count)
                let indicePokemonAleatorio = arc4random_uniform(totalPokemons)
                let pokemon = self.pokemons[Int(indicePokemonAleatorio)]
                
                let anotacao = PokemonAnotacao(coordenadas: coordenadas, pokemon: pokemon)
                
                let latAleatoria = (Double(arc4random_uniform(400)) - 200 ) / 100000.0
                let lonAleatoria = (Double(arc4random_uniform(400)) - 200 ) / 100000.0
                
                anotacao.coordinate.latitude += latAleatoria
                anotacao.coordinate.longitude += lonAleatoria
                
                self.mapa.addAnnotation(anotacao)
                
            }
            
        }
        
    }
    
    //exibi imagens no lugar das anotacoes
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let anotacaoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        if annotation is MKUserLocation {
            anotacaoView.image =  UIImage(named: "player.png")
            
        }else {
            let pokemon = (annotation as! PokemonAnotacao).pokemon
            anotacaoView.image =  UIImage(named: pokemon.nomeImagem!)
            
        }
        var frame = anotacaoView.frame
        frame.size.height = 40
        frame.size.width = 40
        anotacaoView.frame = frame
        
        return anotacaoView
        
    }
    
    //metodo que centraliza o usuario na tela
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if contador < 3 {
            self.centralizar()
            contador += 1
        
        }else {
            gerenciadorLocalizacao.stopUpdatingLocation()
            
        }
        
    }
    
    //metodo que verifica se o usuario autorizou o acesso a localizacao
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse && status != .notDetermined {
            let alertController = UIAlertController(title: "Permissão de localização",
                                                    message: "Para que você possa capturar pokemons, precisamos da sua localização!",
                                                    preferredStyle: .alert)
            let acaoConfiguracoes = UIAlertAction(title: "Abrir Configurações", style: .default) { (alertaConfiguracoes) in
                if let configuracoes = NSURL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(configuracoes as URL)
                    
                }
                
            }
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            present(alertController, animated: true, completion: nil)
            
        }
        
    }

    func centralizar() {
        if let coordenadas = gerenciadorLocalizacao.location?.coordinate {
            let regiao = MKCoordinateRegion(center: coordenadas, latitudinalMeters: 400, longitudinalMeters: 400)
            mapa.setRegion(regiao, animated: true)
            
        }
        
    }
    
    @IBAction func centralizaJogador(_ sender: Any) {
        self.centralizar()
        
    }
    
    @IBAction func abrirPokedex(_ sender: Any) {
    }
    
}

