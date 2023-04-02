//
//  Constants.swift
//  Payments
//
//  Created by Alejandro Villalobos on 31-03-23.
//

struct ViewStringConstants {
    struct AmountEntry {
        static let title = "Inicio"
        static let amountPlaceholder = "Ingresa monto a recargar"
        static let amountErrorLabel = "Sólo se puede recargar montos entre $ 500 y $ 2.500.000"
        static let continueButton = "Continuar"
        static let alertTitle = "Recarga exitosa"
        static let alertPrimaryButton = "OK"
        static let alertContentAmount = "Monto:"
        static let alertContentPaymentMethod = "Método de Pago:"
        static let alertContentBank = "Banco:"
        static let alertContentInstallments = "Cuotas:"
        static let alertContentAmountInterest = "Monto total con interés:"
    }
    
    struct PaymentType {
        static let title = "Métodos de Pago"
        static let paymentCardTitle = "Estas recargando"
    }
    
    struct BankSelection {
        static let title = "Banco"
        static let paymentCardTitle = "Estas recargando"
    }
    
    struct InstallmentsSelection {
        static let title = "Cuotas"
        static let paymentCardTitle = "Estas recargando"
    }
    
    struct ConfirmPayment {
        static let paymentCardTitle = "Estas recargando"
        static let continueButton = "Confirmar"
    }
}
