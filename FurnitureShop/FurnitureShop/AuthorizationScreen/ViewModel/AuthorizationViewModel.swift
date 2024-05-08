//
//  AuthorizationViewModel.swift
//  FurnitureShop

import Foundation

final class AuthorizationViewModel: ObservableObject {
    private let phoneFormat = "+X (XXX) XXX-XX-XX"
    
    @Published public var showPassword = false
    @Published public var showPasswordKeyboard = false
    @Published public var showNumberKeyboard = true
    
    /// Обновление филда пароля
    public func updateField() {
        showPassword.toggle()
    }
    
    /// Проверка введенного номера
    public func checkNumber(count: Int) {
        if count == phoneFormat.count {
            showNumberKeyboard = false
            showPasswordKeyboard = true
        }
    }
    
    /// Проверка введенного пароля
    public func checkPassword(count: Int) {
        if count == 15 {
            showPasswordKeyboard = false
        }
    }
    
    /// Форматирование введенного номера
    public func formatPhoneNumber(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
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
}
