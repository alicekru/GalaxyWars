//
//  PlanetAndStarModel.swift
//  GalaxyWars
//
//  Created by Alice Krutienko on 25.01.2021.
//

import Foundation

enum NumberOfSatellites: CaseIterable {
    case zero
    case one
    case two
    case three
    case four
    case five
}

enum Temperature: CaseIterable {
    case O
    case B
    case A
    case F
    case G
    case K
    case M
}

enum Evolution: CaseIterable {
    case protostar
    case subgiant
    case whiteDwarfs
    case blackHole
}

class Planet {
    
    let id: String
    var age = 0
    let hostStar: Star?
    let planetMass = Int.random(in: 70...100)
    let planetRadius = Int.random(in: 80...100)
    var satellitesNumber: NumberOfSatellites = NumberOfSatellites.allCases.randomElement()!
    weak var delegate: StarPlanetarySystemDelegate?
    init(delegate: StarPlanetarySystemDelegate, star: Star) {
        self.delegate = delegate
        self.hostStar = star
        self.id = "Planet \(Int.random(in: 3000...9000))"
    }
    func addAge() {
        age += 1
      }
    
}

class Star {
    var age = 0 {
        willSet {
          if newValue % 10 == 0 {
            evolutionFunc()
          }
        }
    }
    let id: String
    let stellarRadius = Int.random(in: 80...100)
    let stellarLuminosity = Int.random(in: 1...100)
    var stellarMass = Int.random(in: 70...100)
    var stellarMassLimit: Int = 0
    var stellarRadiusLimit: Int = 0
    var temp: Temperature = Temperature.allCases.randomElement()!
    var evolution: Evolution = .protostar
    
    weak var delegate: StarPlanetarySystemDelegate?
    init(stellarMassLimit: Int, stellarRadiusLimit: Int) {
        self.stellarMassLimit = 101
        self.stellarRadiusLimit = 101
        self.id = "id"
    }
    
    func addAge() {
        age += 1
    }
}

extension Star {
    func evolutionFunc() {
        guard evolution == .blackHole else { return }
        
        age += 1
        
        if age.isMultiple(of: 60) {
            switch evolution {
            case .protostar:
                evolution = .subgiant
            case .subgiant:
                if stellarMass < stellarMassLimit && stellarRadius < stellarRadiusLimit {
                    evolution = .whiteDwarfs
                    return
                } else {
                    evolution = .blackHole
                }
            case .whiteDwarfs, .blackHole: return
            }
        }
    }
}
