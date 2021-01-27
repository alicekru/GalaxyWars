//
//  GalaxyModel.swift
//  GalaxyWars
//
//  Created by Alice Krutienko on 24.01.2021.
//

import Foundation

enum HubbleSequence: CaseIterable {
    case elliptical
    case spiral
    case lenticular
    case irregular
}

class Galaxy: Equatable, GalaxyDelegate {
    
    var starPlanetarySystem = [StarPlanetarySystem]()
    var age = 0 {
        willSet {
            if newValue % 10 == 0 {
                createSystem()
                eventDelegate?.systemDidUpdate()
                }
            }
    }
    var weight: Int {
        var totalWeight = 0
        starPlanetarySystem.forEach{totalWeight += $0.systemMass}
        return totalWeight
    }
    weak var eventDelegate: EventDelegate?
    var type: HubbleSequence = HubbleSequence.allCases.randomElement()!
    //let dataSource: [String] = ["Andromeda Galaxy", "Antennae Galaxies", "Black Eye Galaxy", "Backward galaxy", "Bode's Galaxy", "Messier 81", "NGC 3031", "Butterfly Galaxies", "Siamese Twins"]
    
    let id = "Galaxy \(Int.random(in: 3000...9000))"
    init() {
        print(id)
    }
    
    init(delegate: EventDelegate, type: HubbleSequence, age: Int, starPlanetarySystem: [StarPlanetarySystem]) {
        self.eventDelegate = delegate
        self.type = type
        self.age = age
        self.starPlanetarySystem = [StarPlanetarySystem]()
    }
    
    func addAge() {
        age += 1
        starPlanetarySystem.forEach{$0.addAge()}
        //blackHole.forEach{$0.addAge()}
    }
    
    func createSystem() {
        let newSystem = StarPlanetarySystem()
        starPlanetarySystem.append(newSystem)
        starPlanetarySystem.forEach {
            print($0.id)
        }
    }
    
    func blackHoleBornedInStellarSystemWithHostStar(_ starPlanetarySystem: StarPlanetarySystem) {
//        guard let starPlanetarySystemIndex = starPlanetarySystem.firstIndex(of: starPlanetarySystem) else { return }
//            starPlanetarySystem.remove(at: starPlanetarySystemIndex)
//            let blackHole = BlackHole(id: "BlackHole_\(starPlanetarySystem.id)")
//            blackHoles.append(blackHole)
//            eventsDelegate?.blackHolesCountDidUpdate()
    }
    
    static func == (lhs: Galaxy, rhs: Galaxy) -> Bool {
        return lhs.id == rhs.id
    }
    
}
