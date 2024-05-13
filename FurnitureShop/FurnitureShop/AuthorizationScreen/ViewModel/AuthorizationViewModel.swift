//
//  AuthorizationViewModel.swift
//  FurnitureShop

import Foundation

/// ViewModel для экрана автооризации
final class AuthorizationViewModel: ObservableObject {
    private let phoneFormat = "+X (XXX) XXX-XX-XX"
    
    @Published public var showPassword = false
    @Published public var showPasswordKeyboard = false
    @Published public var showNumberKeyboard = true
    @Published public var showAnimationNumber = false
    @Published public var showAnimationPassword = false
    
    /// Обновление филда пароля
    public func updateField() {
        showPassword.toggle()
    }
    
    /// Проверка введенного номера
    /// - Parameters:
    /// - count: Кол-во символов в веденном номере
    public func checkNumber(count: Int) {
        if count == phoneFormat.count {
            showNumberKeyboard = false
            showPasswordKeyboard = true
        }
    }
    
    /// Проверка номера на минимальное кол-во символов
    /// - Parameters:
    /// - count: Кол-во символов в веденном номере
    public func checkMinCountNumber(count: Int) {
        if count < phoneFormat.count {
            showAnimationNumber = true
        }
    }
    
    /// Проверка введенного пароля на минимально допустимое кол-во
    /// - Parameters:
    /// - count: Кол-во символов в веденном пароле
    public func checkMinCountPassword(count: Int) {
        if count < 6 {
            showAnimationPassword = true
        }
    }
    
    /// Проверка введенного пароля на максимально допустимое кол-во
    /// - Parameters:
    /// - count: Кол-во символов в веденном пароле
    public func checkPassword(count: Int) {
        if count == 15 {
            showPasswordKeyboard = false
        }
    }
    
    /// Форматирование введенного номера
    /// - Parameters:
    /// - mask: Маска
    /// - phone: Введенный номер
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
