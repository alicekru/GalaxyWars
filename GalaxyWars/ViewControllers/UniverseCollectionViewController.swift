//
//  UniverseCollectionViewController.swift
//  GalaxyWars
//
//  Created by Alice Krutienko on 18.01.2021.
//

import UIKit

class UniverseCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
}

    var numbers = [Int]()
    let universe = Universe()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        universe.eventDelegate = self
        for i in 1...33 {
            numbers.append(i)
        }
        
    
        //let layout = collectionView.collectionViewLayout as? CustomLayout
        //layout?.delegate = self
        }
}

//MARK: UICollectionViewDataSource
extension UniverseCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return universe.galaxies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalaxiesCollectionViewCell
    
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.clipsToBounds = true
        cell.galaxyNameLabel.text = universe.galaxies[indexPath.row].id //String(dataSource[indexPath.item])
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(identifier: "SystemCollectionViewController") as! SystemCollectionViewController
        destination.galaxy = universe.galaxies[indexPath.row]
        self.navigationController?.pushViewController(destination, animated: true)
        //self.performSegue(withIdentifier: Constants.toGalaxyVCSegue, sender: indexPath)
      }
    
}

//MARK: UICollectionViewDelegate
extension UniverseCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                    willDisplay cell: UICollectionViewCell,
                    forItemAt indexPath: IndexPath) {
    
        cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
                cell.transform = .identity
            }, completion: nil)
        }
    }


//extension UniverseViewController: CustomLayoutDelegate {
//func theNumberOfItemsInCollectionView() -> Int {
//    return numbers.count
//   }
//}

extension UniverseCollectionViewController: EventDelegate {
    func systemDidUpdate() {
    }
    
    func timeDidUpdate() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
