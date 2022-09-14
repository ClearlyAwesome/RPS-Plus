
//  GameLogic.swift
//  Rock Paper Scissors Plus

//  Created by R C on 10/13/20.


import UIKit

struct GameState {
    enum GameState: String, CaseIterable  {
        case start, win, lose, draw
    }
    enum Sign: String, CaseIterable {
        case rock, paper, scissors, meteor, dynamite, nuclearBomb, cockroach, car, dinosaur, boot
        
        var sign: String {
            switch self {
                case .rock: return "rock"
                case .paper: return "paper"
                case .scissors: return "scissors"
                case .meteor: return "meteor"
                case .dynamite: return "dynamite"
                case .nuclearBomb: return "nuclearBomb"
                case .cockroach: return "cockroach"
                case .car: return "car"
                case .dinosaur: return "dinosaur"
                case .boot: return "boot"
            }
        }
    }
    
    func battle(userSign: Sign, opponentSign: Sign) -> GameState {
        switch (userSign, opponentSign) {
            //Rock is the choice
            case (.rock, .rock): return .draw
            case (.rock, .paper): return .lose
            case (.rock, .scissors): return .win
            //Premium weapons
            case (.rock, .meteor): return .lose
            case (.rock, .car): return .win
            case (.rock, .dynamite): return .lose
            case (.rock, .dinosaur): return .lose
            case (.rock, .nuclearBomb): return .lose
            case (.rock, .cockroach): return .win
            case (.rock, .boot): return .win
                
            //Paper is the choice
            case (.paper, .rock): return .win
            case (.paper, .paper): return .draw
            case (.paper, .scissors): return .lose
            //Premium weapons
            case (.paper, .meteor): return .lose
            case (.paper, .car): return .lose
            case (.paper, .dynamite): return .lose
            case (.paper, .dinosaur): return .lose
            case (.paper, .nuclearBomb): return .lose
            case (.paper, .cockroach): return .win
            case (.paper, .boot): return .lose
            
            //Scissors is the choice
            case (.scissors, .rock): return .lose
            case (.scissors, .paper): return .win
            case (.scissors, .scissors): return .draw
            //Premium weapons
            case (.scissors, .meteor): return .lose
            case (.scissors, .dynamite): return .win
            case (.scissors, .nuclearBomb): return .lose
            case (.scissors, .cockroach): return .win
            case (.scissors, .car): return .win
            case (.scissors, .dinosaur): return .lose
            case (.scissors, .boot): return .win
             
            //Meteor is the choice
            case (.meteor, .rock): return .win
            case (.meteor, .paper): return .win
            case (.meteor, .scissors): return .win
            //Premium weapons
            case (.meteor, .meteor): return .draw
            case (.meteor, .dynamite): return .lose
            case (.meteor, .nuclearBomb): return .lose
            case (.meteor, .cockroach): return .lose
            case (.meteor, .car): return .win
            case (.meteor, .dinosaur): return .win
            case (.meteor, .boot): return .win
            
            //Dynamite is the choice
            case (.dynamite, .rock): return .win
            case (.dynamite, .paper): return .win
            case (.dynamite, .scissors): return .lose
            //Premium weapons
            case (.dynamite, .meteor): return .win
            case (.dynamite, .dynamite): return .draw
            case (.dynamite, .nuclearBomb): return .win
            case (.dynamite, .cockroach): return .win
            case (.dynamite, .car): return .win
            case (.dynamite, .dinosaur): return .win
            case (.dynamite, .boot): return .win
                
            //Nuke is the choice
            case (.nuclearBomb, .rock): return .win
            case (.nuclearBomb, .paper): return .win
            case (.nuclearBomb, .scissors): return .win
            //Premium weapons
            case (.nuclearBomb, .meteor): return .win
            case (.nuclearBomb, .dynamite): return .win
            case (.nuclearBomb, .nuclearBomb): return .draw
            case (.nuclearBomb, .cockroach): return .lose
            case (.nuclearBomb, .car): return .win
            case (.nuclearBomb, .dinosaur): return .win
            case (.nuclearBomb, .boot): return .win
                
            //Cockroach is the choice
            case (.cockroach, .rock): return .lose
            case (.cockroach, .paper): return .lose
            case (.cockroach, .scissors): return .lose
            //Premium weapons
            case (.cockroach, .meteor): return .win
            case (.cockroach, .dynamite): return .lose
            case (.cockroach, .nuclearBomb): return .win
            case (.cockroach, .cockroach): return .draw
            case (.cockroach, .car): return .lose
            case (.cockroach, .dinosaur): return .win
            case (.cockroach, .boot): return .lose
                
            //Car is the choice
            case (.car, .rock): return .lose
            case (.car, .paper): return .win
            case (.car, .scissors): return .lose
            //Premium weapons
            case (.car, .meteor): return .lose
            case (.car, .dynamite): return .lose
            case (.car, .nuclearBomb): return .lose
            case (.car, .cockroach): return .win
            case (.car, .car): return .draw
            case (.car, .dinosaur): return .lose
            case (.car, .boot): return .win
                
            //Dinosaur is the choice
            case (.dinosaur, .rock): return .win
            case (.dinosaur, .paper): return .win
            case (.dinosaur, .scissors): return .win
            //Premium weapons
            case (.dinosaur, .meteor): return .lose
            case (.dinosaur, .dynamite): return .win
            case (.dinosaur, .nuclearBomb): return .lose
            case (.dinosaur, .cockroach): return .win
            case (.dinosaur, .car): return .win
            case (.dinosaur, .dinosaur): return .draw
            case (.dinosaur, .boot): return .win
                
            //Boot is the choice
            case (.boot, .rock): return .lose
            case (.boot, .paper): return .win
            case (.boot, .scissors): return .lose
            //Premium weapons
            case (.boot, .meteor): return .lose
            case (.boot, .dynamite): return .lose
            case (.boot, .nuclearBomb): return .lose
            case (.boot, .cockroach): return .win
            case (.boot, .car): return .lose
            case (.boot, .dinosaur): return .lose
            case (.boot, .boot): return .draw
        }
    }
}




