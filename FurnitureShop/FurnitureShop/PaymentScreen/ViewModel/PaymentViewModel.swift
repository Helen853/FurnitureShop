//
//  PaymentViewModel.swift
//  FurnitureShop

import Foundation

final class PaymentViewModel: ObservableObject {
    
    @Published public var showPassword = false
    @Published public var showAlert = false
    private let maxCount = 3
    
    /// Обновление филда CVC
    public func updateField() {
        showPassword.toggle()
    }
    
    /// Форматирование введенного номера карты
    public func formatNumber(with mask: String, numberCard: String) -> String {
        let numbers = numberCard.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for char in mask where index < numbers.endIndex {
            if char == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
    
    public func checkCvc(inputCode: String) {
        if inputCode.count < 3 {
            showAlert = true
        } else {
            showAlert = false
        }
    }
}
