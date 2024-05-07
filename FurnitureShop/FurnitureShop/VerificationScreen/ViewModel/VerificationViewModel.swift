//
//  VerificationViewModel.swift
//  FurnitureShop

import Foundation

final class VerificationViewModel: ObservableObject {
    @Published var code = [String]()
    @Published var codeAll = String()
    
    func returnNewCode() {
        code.removeAll()
        codeAll.removeAll()
        for _ in 1...4 {
            let numberRandom = Int.random(in: 0..<9)
            code.append(String(numberRandom))
            codeAll.append(String(numberRandom))
        }
    }
}
