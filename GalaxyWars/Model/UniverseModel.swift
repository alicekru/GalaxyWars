//
//  Model.swift
//  GalaxyWars
//
//  Created by Alice Krutienko on 14.01.2021.
//

import Foundation

class Universe: EventDelegate {
    
    var time = 0 {
        didSet {
            print (oldValue)
            galaxies.forEach{$0.addAge()}
            if oldValue % 10 == 0 {
                createGalaxy()
                eventDelegate?.timeDidUpdate()
            }
            if oldValue % 30 == 0 {
                collisionOfGalaxies()
            }
        }
    }

    weak var eventDelegate: EventDelegate?
    var galaxies = [Galaxy]()
    private var timeInterval: TimeInterval = 1.0
        private lazy var timer = Timer(timeInterval: timeInterval)
        
    init() {
        timer.startEvent = {
            self.time += 1
        }
        timer.resume()
    }
    func createGalaxy() {
        let newGalaxy = Galaxy()
        galaxies.append(newGalaxy)
        galaxies.forEach {
            print($0.id)
        }
    }
    func collisionOfGalaxies()  {
        guard galaxies.count > 2 else {return}
        let filterForGalaxy = galaxies.filter{ $0.age > 180 }
        
        guard filterForGalaxy.count > 2 else { return }
        
        let planetsInRandonOrder = filterForGalaxy.shuffled()
        
        guard let firstGalaxy = planetsInRandonOrder.first else { return }
        guard let secondGalaxy = planetsInRandonOrder.last else { return }
        guard let firstGalaxyIndex = galaxies.firstIndex(of: firstGalaxy) else {return}
        guard let secondGalaxyIndex = galaxies.firstIndex(of: secondGalaxy) else {return}

        galaxies.remove(at: firstGalaxyIndex)
        let newGalaxy =  mergeGalaxies(firstGalaxy, secondGalaxy)
        galaxies.insert(newGalaxy, at: firstGalaxyIndex)
        galaxies.remove(at: secondGalaxyIndex)
      }
    
    func timeDidUpdate() {
    }
    
    func systemDidUpdate() {
    }
    
    private func mergeGalaxies(_ first:  Galaxy, _ second:  Galaxy) -> Galaxy  {
        let allStarPlanetarySystem = first.starPlanetarySystem + second.starPlanetarySystem
        let newStarPlanetarySystem = deathStarPlanetarySystem(allStarPlanetarySystem)
        
        if first.weight > second.weight {
            return Galaxy(delegate: self, type: first.type, age: first.age, starPlanetarySystem: newStarPlanetarySystem)
        } else {
            return Galaxy(delegate: self, type: second.type, age: second.age, starPlanetarySystem: newStarPlanetarySystem)
        }
      }
    private func deathStarPlanetarySystem(_ allStarPlanetarySystem: [StarPlanetarySystem]) -> [StarPlanetarySystem] {
        switch allStarPlanetarySystem.count {
            case 0: return [StarPlanetarySystem]()
            case 1: return allStarPlanetarySystem
            case 2...10:
              var newSystems = allStarPlanetarySystem.shuffled()
              let last = newSystems.removeLast()
              print("\(last.id)")
              return newSystems
              
            default:
              let numberSystemsToDestroy = Int(((Double(allStarPlanetarySystem.count * 10)) / 100.0).rounded())
              var newSystems = allStarPlanetarySystem.shuffled()
              for _ in 1...numberSystemsToDestroy {
                let last = newSystems.removeLast()
                print("\(last.id)")
              }
            return newSystems
        }
    }
}


