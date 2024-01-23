//
//  CreditCardDetailsViewModel.swift
//  PersonData
//
//  Created by Dhritiman Saha on 27/12/23.
//

import Foundation

enum CardType: String {
    case Visa = "Visa"
    case MasterCard = "Master Card"
    case ContactLessDebitCard = "Contact-less Debit Card"
    case RuPayDebitCard = "RuPay Debit Card"
    case VisaCreditCard = "Visa Credit Card"
    case BusinessCreditCard = "Business Credit Card"
    case MaestroCard = "Maestro Card"
    case none
}

class CreditCardDetailsViewModel {
    private var selectedCardType: CardType = .none
    private let persistentStorage = PersistantStorage.shared
    
    init() {
    }
    
    func validateDetails(cardNo: String,
                         type: CardType = .none,
                         holderName: String?) -> (Bool, String) {
        guard let _ = Int(cardNo),
                cardNo.count == 16 else {
            return (false, "Please enter valid card no.")
        }
        
        guard type != .none else {
            return (false, "Please select card type")
        }
        
        guard let _ = holderName else {
            return (false, "Please enter holder name")
        }
        return (true, "Success")
    }
    
    func setCardType(_ index: Int) {
        switch index {
        case 0:
            selectedCardType = .Visa
        case 1:
            selectedCardType = .MasterCard
        default:
            selectedCardType = .none
        }
    }
    
    func getCardType() -> CardType {
        return selectedCardType
    }
    
    func saveCreditCard(cardNo: String, cardType: CardType, user: Employees) {
        let card = Cards(context: persistentStorage.context)
        card.id = UUID()
        card.cardNo = Int64(cardNo) ?? 0
        card.type = cardType.rawValue
        card.cardToEmployee = user
        persistentStorage.saveContext()
    }
    
    func fetchAllCards() -> [Cards]? {
        let sortDescriptor = NSSortDescriptor(key: "cardToEmployee.name", ascending: true)
        let fetchRequest = Cards.fetchRequest()
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let result = try persistentStorage.context.fetch(fetchRequest)
            return result
        } catch {
            print("ERROR in fetch cards : \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteSelectedCard(_ selectedCard: Cards) {
        persistentStorage.context.delete(selectedCard)
        persistentStorage.saveContext()
    }
}
