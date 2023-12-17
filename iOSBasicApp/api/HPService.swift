import Foundation

protocol HPService {
    
    //Lambdas that can return either a List of Characters or an Error
    //Information can be sent back up by calling the function (i.e. from the result of a network request)
    
    func getCharacters(completion: @escaping ([Character]?, Error?) -> Void)
    func getSpells(completion: @escaping ([Spell]?, Error?) -> Void)
}
