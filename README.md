# Payments App

Payments is an iOS app that allows users to perform mobile recharges using their credit cards and processes the transactions through the MercadoPago gateway. The application is built using the MVP (Model-View-Presenter) architecture pattern and follows coding best practices.

## Features

- Mobile recharge using credit card
- Integration with MercadoPago gateway
- MVP architecture pattern
- Good coding practices
- Dark Mode ready

## Getting Started

### Prerequisites

- Xcode
- CocoaPods

### Installation

1. Clone the repository
git clone https://github.com/Schavcovsky/PaymentApp

2. Navigate to the project directory
cd Payments

3. Install the required dependencies using CocoaPods
pod install

4. Create an `Environment.plist` file inside the "Supporting Files" folder with the following content:
   ```
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
       <key>publicKey</key>
       <string>REPLACE-ME-WITH-A-KEY</string>
   </dict>
   </plist>
   ```
5. Open the `Payments.xcworkspace` file in Xcode
6. Add your MercadoPago API keys and credentials to the appropriate configuration files
7. Build and run the project

### Usage
1. Enter the amount you want to recharge
2. Select the payment method (credit card)
3. Choose the bank and installment options
4. Confirm the transaction!
