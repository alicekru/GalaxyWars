//
//  SystemModel.swift
//  GalaxyWars
//
//  Created by Alice Krutienko on 24.01.2021.
//

import Foundation


enum OrbitalDynamics: CaseIterable {
    case resonant
    case nonResonantInteracting
    case hierarchical
}

class StarPlanetarySystem: Equatable, StarPlanetarySystemDelegate {
   
    private weak var delegate: GalaxyDelegate?
    weak var eventDelegate: EventDelegate?
    
    var hostStar: Star! = nil
    var stars = [Star]()
    var planets = [Planet]()
    
    var type: OrbitalDynamics = OrbitalDynamics.allCases.randomElement()!
    
    var age = 0 {
        willSet {
          if newValue % 10 == 0 {
            
          }
        }
      }
   
    var systemMass: Int {
        var totalMass = hostStar!.stellarMass
        planets.forEach{ totalMass += $0.planetMass}
        return totalMass
      }
    
    let id = "System \(Int.random(in: 1...2999))"
    init() {
        print(id)
    }
    
    init(delegate: GalaxyDelegate, type: OrbitalDynamics, age: Int, stars: [Star]) {
        self.delegate = delegate
        self.type = type
        self.age = age
        self.hostStar = createStar()
    }
    
    func addAge() {
        age += 1
        hostStar?.addAge()
        planets.forEach{$0.addAge()}
    }
    
    func starBecomeBlackHole() {
        planets = []
        delegate?.blackHoleBornedInStellarSystemWithHostStar(self)
    }
    
    private func createStar() -> Star {
        let newStar = Star(stellarMassLimit: Int.random(in: 1...100), stellarRadiusLimit: Int.random(in: 1...100))
        stars.append(newStar)
        stars.forEach {
            print($0.id)
        }
    return newStar
    }
    
    static func == (lhs: StarPlanetarySystem, rhs: StarPlanetarySystem) -> Bool {
        return lhs.id == rhs.id
    }
}


