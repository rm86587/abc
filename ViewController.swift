//
//  ViewController.swift
//  Exercício Fixação Pokemon
//
//  Created by Usuário Convidado on 23/09/24.
//

import UIKit

var pokemon:UmPokemon!=nil

class ViewController: UIViewController {
    
    
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var ImgFoto: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func exibir(_ sender: Any) {
        loadPokemon()
    }
    
    func loadPokemon(){
        let jsonUrlString = "https://pokeapi.co/api/v2/pokemon/" + txtNome.text!
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {return}
                do {
                    pokemon = try JSONDecoder().decode(UmPokemon.self, from: data)
                    let imagem = self.carregarImagem(urlImagem: pokemon.sprites.front_default)
                    
                    DispatchQueue.main.sync {
                        self.lblId.text = String(pokemon.id)
                        self.lblNome.text = pokemon.name
                        self.ImgFoto.image = imagem
                    }
                }catch let jsonError {
                    print("Error serialization Json", jsonError)
                }
        }
        .resume()
    }
    
    func carregarImagem (urlImagem:String)->UIImage?{
        //Obtendo uma url válida
        guard let url = URL(string: urlImagem)
        else{
            print("Não foi possível criar a URL")
            return nil
        }
        var image:UIImage? = nil
        do{
            //Obtendo os dados válidos
            let data = try Data(contentsOf: url)
            //Criando a imagem
            image = UIImage(data: data)
        }catch{
            print(error.localizedDescription)
        }
        return image
    }
    
}

