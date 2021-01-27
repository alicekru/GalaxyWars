//
//  PlanetAndStarCollectionViewController.swift
//  GalaxyWars
//
//  Created by Alice Krutienko on 18.01.2021.
//


import UIKit

class PlanetAndStarCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
}

    weak var starPlanetarySystem: StarPlanetarySystem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starPlanetarySystem!.eventDelegate = self
        navigationItem.title = starPlanetarySystem!.id

//        let layout = collectionView.collectionViewLayout as? CustomLayout
//        layout?.delegate = self
        }
}

//MARK: UICollectionViewDataSource
extension PlanetAndStarCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return starPlanetarySystem!.stars.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlanetAndStarCollectionViewCell
    
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.clipsToBounds = true
        cell.planetAndStarNameLabel.text = starPlanetarySystem!.stars[indexPath.row].id //String(dataSource[indexPath.item])
    
        return cell
    }
    
}

//MARK: UICollectionViewDelegate
extension PlanetAndStarCollectionViewController: UICollectionViewDelegate {
func collectionView(_ collectionView: UICollectionView,
                    willDisplay cell: UICollectionViewCell,
                    forItemAt indexPath: IndexPath) {
    
    cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    
    UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
        cell.transform = .identity
    }, completion: nil)
    
    }
}


//extension PlanetAndStarCollectionViewController: CustomLayoutDelegate {
//func theNumberOfItemsInCollectionView() -> Int {
//    return numbers.count
//   }
//}

extension PlanetAndStarCollectionViewController: EventDelegate {
    func systemDidUpdate() {
    }
    
    func timeDidUpdate() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
