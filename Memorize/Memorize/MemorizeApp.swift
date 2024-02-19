//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Douglas Morais on 27/12/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup{
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
