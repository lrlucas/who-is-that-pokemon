//
//  ViewController.swift
//  who is that pokemon
//
//  Created by Alex Camacho on 01/08/22.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet
    var labelScore: UILabel!
    
    @IBOutlet
    var pokemonImage: UIImageView!
    
    @IBOutlet
    var labelMessage: UILabel!
    
    @IBOutlet
    var answerButtons: [UIButton]!
    
    // agregamos el manager
    lazy var pokemonManager = PokemonManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorationButton()
        pokemonManager.fetchPokemon()
        
    }
    
    @IBAction
    func buttonPressed(_ sender: UIButton) {
        guard let title : String = sender.title(for: .normal) else { return }
        print(title)
        
    }
    
    func decorationButton() {
        for button in answerButtons {
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 10.0
        }
    }
    
    
    
}

extension PokemonViewController : PokemonManagerDelegate {
    
    func didUpdatePokemon(pokemons: [PokemonModel]) {
        print(pokemons)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
