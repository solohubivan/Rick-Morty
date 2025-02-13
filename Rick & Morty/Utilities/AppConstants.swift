//
//  AppConstants.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 13.02.2025.
//

import Foundation

enum AppConstants {
    
    enum Fonts {
        static let openSansBold = "OpenSans-Bold"
        static let openSansSemibold = "OpenSans-Semibold"
        static let openSansRegular = "OpenSans-Regular"
    }
    
    enum AlertFactory {
        static let titleNoInternetConnection = "No internet connection"
        static let messagePleaseEnableInternetAccessOrUseTheAppInOffline = "Please enable internet access or use the app in offline mode."
        static let settingsButtonText = "Settings"
        static let titleInternetRestored = "Internet Restored"
        static let messageInternetRestored = "Your internet connection is back. Would you like to switch to online mode?"
        static let useOnlineButtonText = "Use online"
        static let keepOfflineButtonText = "Use offline"
        static let messageNoInternetConnection = "We suggest adding the news to your saved items and viewing it in detail once an internet connection is established."
    }
    
    enum CharacterParameters {
        static let gender: String = "Gender"
        static let origin: String = "Origin"
        static let lastLocation: String = "Last location"
        static let participatedEpisodesAmount: String = "Participated episodes amount"
        static let alive: String = "alive"
        static let dead: String = "dead"
    }
    
    enum MainScreenViewController {
        static let selfTitle: String = "Rick and Morty"
    }
    
    enum Identifiers {
        static let charactersCollectionViewCellID: String = "CellID"
        static let charactersCollectionViewNibName: String = "MainScreenCollectionViewCell"
    }
}
