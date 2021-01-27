//
//  SystemCollectionViewController.swift
//  GalaxyWars
//
//  Created by Alice Krutienko on 23.01.2021.
//

import UIKit

class SystemCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }

    weak var galaxy: Galaxy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galaxy?.eventDelegate = self
        navigationItem.title = galaxy!.id
    
//        let layout = collectionView.collectionViewLayout as? CustomLayout
//        layout?.delegate = self
    }
}

//MARK: UICollectionViewDataSource
extension SystemCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galaxy!.starPlanetarySystem.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SystemCollectionViewCell
    
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.clipsToBounds = true
        cell.systemNameLabel.text = galaxy?.starPlanetarySystem[indexPath.row].id //String(dataSource[indexPath.item])
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(identifier: "PlanetAndStarCollectionViewController") as! PlanetAndStarCollectionViewController
        destination.starPlanetarySystem = galaxy?.starPlanetarySystem[indexPath.row]
        self.navigationController?.pushViewController(destination, animated: true)
       
      }
}

//MARK: UICollectionViewDelegate
extension SystemCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                    willDisplay cell: UICollectionViewCell,
                    forItemAt indexPath: IndexPath) {
    
        cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            cell.transform = .identity
        }, completion: nil)
    }
}


//extension SystemCollectionViewController: CustomLayoutDelegate {
//func theNumberOfItemsInCollectionView() -> Int {
//    return numbers.count
//   }
//}

extension SystemCollectionViewController: EventDelegate {
    func systemDidUpdate() {
    }
    
    func timeDidUpdate() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
