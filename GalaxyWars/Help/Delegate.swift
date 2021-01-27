//
//  Delegate.swift
//  GalaxyWars
//
//  Created by Alice Krutienko on 23.01.2021.
//

import Foundation

protocol EventDelegate: AnyObject {
    func timeDidUpdate()
    func systemDidUpdate()
}

protocol GalaxyDelegate: AnyObject {
    func blackHoleBornedInStellarSystemWithHostStar(_ starPlanetarySystem: StarPlanetarySystem)
}

protocol StarPlanetarySystemDelegate: AnyObject {
    func starBecomeBlackHole()
}

protocol TimerHandler {
    func timerTick()
}
