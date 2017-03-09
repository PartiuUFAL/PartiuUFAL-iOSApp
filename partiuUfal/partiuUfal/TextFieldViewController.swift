// Existem algumas formas de esconder o teclado no iOS
// Aqui vamos ver algumas delas!
// 1. Implementando o UITextFieldDelegate e quando o usuário
//     apertar no RETURN do teclado, terminamos a edição.

import UIKit

class TextFieldViewController: UIViewController, UITextFieldDelegate {
    // Outlet do textField
    var textField = UITextField() {
        didSet {
            // Definimos que o delegate do textField
            // é a própria classe
            self.textField.delegate = self
        }
    }
    
    // Método chamado quando o usuário aperta RETURN no teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Agora fazemos o text field deixar de ser o first responder
        // Isso faz com que o teclado se esconda
        textField.resignFirstResponder()
        
        return true
    }
}

// 2. Isso faz com que o teclado seja escondido quando vc toca fora dele
class TouchesViewController: UIViewController {
    
    // Sobreescrevemos o metodo touchesBegan(_: with:) que é chamado quando tocamos na tela. Isso faz com que você possa para a edição
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Chamamos a view para forçar que a edição pare
        self.view.endEditing(true)
    }
}
