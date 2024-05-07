//
//  AuthorizationViewModel.swift
//  FurnitureShop

import Foundation

class AuthorizationViewModel: ObservableObject {
    private let phoneFormat = "+X (XXX) XXX-XX-XX"
    
    @Published public var showPassword = false
    @Published public var showPasswordKeyboard = false
    @Published public var showNumberKeyboard = true
    
    public func updateField() {
        showPassword.toggle()
    }
    
    public func checkNumber(count: Int) {
        if count == phoneFormat.count {
            showNumberKeyboard = false
            showPasswordKeyboard = true
        }
    }
    
    public func checkPassword(count: Int) {
        if count == 15 {
            showPasswordKeyboard = false
        }
    }
    
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
