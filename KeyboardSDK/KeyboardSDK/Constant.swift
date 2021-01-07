

import Foundation




//MARK:- App UserDeaults Key

struct AuthConstant {
    static let authToken = "AuthToken"
}

//MARK:- AMount Constant
struct Amount {
    static var minimumAmount = 10.00
    static var maximumAmount = 2000.00
}

struct KeyBoardKeys{
    static let capsLocked = "capsLocked"
}

struct HistoryStatus {
    static let porCobrar = "POR_COBRAR"
    static let cobrada = "COBRADA"
    static let cancelada = "CANCELADA"
}

//MARK:- Alert Constant
struct AlertMessage {
    static let minAmountAlert = "El monto mínimo es: $"
    static let maxAmountAlert = "El monto máximo es: $"
    static let amountExceedAlert = "Limite de transacción diaria excedido"
    static let networkError = "Por el momento Santander TAP no esta disponible, verifica tu conexión a internet e intenta nuevamente."
    static let cancelPayment = "Cancelación exitosa"//"Cancel Exitiosa"
}


struct dateFormat {
    static let ddMMyyyy = "dd/MM/yyyy"
    static let month = "MMMM"
    static let year = "yyyy"
}

struct arrayType {
    static let popupCharacterArray = ["A", "C", "D", "E", "I", "O", "U", "N", "S",
                                      "a", "c", "d", "e", "i", "o", "u", "n", "s",
                                      "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                                      "-", "/", "$", "&", "\"",
                                      ".", "?", "!", "´",
                                      "%", "="]

    static let rightSideCharacterArray = ["U", "I", "O", "N",
                                          "u", "i", "o", "n",
                                          "9", "0",
                                          "$", "\"",
                                          "´",
                                          "="]
}
