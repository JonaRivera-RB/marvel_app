//
//  ViewController.swift
//  Marvel app
//
//  Created by Misael Rivera on 24/11/19.
//  Copyright © 2019 Misael Rivera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let heroeAPI = HeroeAPI()
    var heroes = [Heroe]()
    var totalHeroesInArray = 0
    var startPage = 10
    var totalHeroes = 0
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        downloadHeroes()
    }
    
    private func downloadHeroes() {
        let showLoader = showAlertWithLoadingIndicator(toTittle: "Downloading heroes", toMessage: "wait a moment")
        heroeAPI.getHeroes(toPage: nil) { (success, heroes, totalHeroes, error)   in
            DispatchQueue.main.async {
                if success {
                    showLoader.dismiss(animated: true, completion: nil)
                    guard let heroes = heroes, let totalHeroes = totalHeroes else { return }
                    self.heroes = heroes
                    self.totalHeroes = totalHeroes
                    self.tableView.reloadData()
                }else {
                    showLoader.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == heroes.count - 1 {
            if heroes.count < totalHeroes {
                loadMoreHeroes()
            }
        }
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "heroeCell", for: indexPath) as! HeroeCell
        let heroe = heroes[indexPath.row]
        cell.updateHeroeCell(heroeName: heroe.name!, heroeImage: heroe.urlImage!, imageExt: heroe.imageExt!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == heroes.count - 1 {
                   if heroes.count < totalHeroes {
                       loadMoreHeroes()
                   }
               }
    }
    
    private func loadMoreHeroes() {
        if startPage < totalHeroes {
            let showLoader = showAlertWithLoadingIndicator(toTittle: "Downloading heroes", toMessage: "wait a moment")
            self.heroeAPI.getHeroes(toPage: String(startPage)) { (success, heroes,totalHeroes, error) in
                DispatchQueue.main.async {
                    if success {
                        showLoader.dismiss(animated: true, completion: nil)
                        guard let heroes = heroes, let totalHeroes = totalHeroes else { return }
                        self.heroes.append(contentsOf: heroes)
                        self.totalHeroes = totalHeroes
                        self.tableView.reloadData()
                        self.startPage = self.startPage + 10
                    }
                }
            }
        }
    }
    
}
