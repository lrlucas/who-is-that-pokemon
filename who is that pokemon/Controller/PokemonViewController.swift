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
    lazy var imageManager = ImageManager()
    
    var random4Pokemon : [PokemonModel] = []
    var correctAnswer : String = ""
    var correctAnswerImage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonManager.delegate = self
        imageManager.delegate = self
        
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

extension PokemonViewController : ImageManagerDelegate {
    func didFailWithErrorImage(error: Error) {
        print(error)
    }
    
    func didUpdateImage(image: ImageModel) {
        print("IMAGEN: \(image.imageUrl)")
    }
    
    
}

extension PokemonViewController : PokemonManagerDelegate {
    
    func didUpdatePokemon(pokemons: [PokemonModel]) {
        random4Pokemon = pokemons.choose(4)
        let index = Int.random(in: 0...3)
        let imageData = random4Pokemon[index].imageUrl
        imageManager.fetchImage(url: imageData)
        
        print(pokemons.choose(4))
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return ( startIndex <= index && index < endIndex ) ? self[index] : nil
    }
}

extension Collection {
    func choose(_ n: Int) -> Array<Element> {
        Array(shuffled().prefix(n))
    }
}
