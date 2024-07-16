//
//  GamesViewModel.swift
//  App675
//
//  Created by IGOR on 16/07/2024.
//

import SwiftUI
import CoreData

final class GamesViewModel: ObservableObject {

    @AppStorage("categories") var categories: [String] = ["All"]
    @Published var currentCategory = ""
    @Published var ccForAdd = ""
    
    @Published var photos: [String] = ["G1", "G2"]
    @Published var currentPhoto = ""
    
    @Published var AchPhotos: [String] = ["Avatar"]
    @Published var curAchPhoto = ""
    
    @AppStorage("gms") var gms: Int = 0
    @AppStorage("ach") var ach: Int = 0

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isAddCat: Bool = false
    @Published var isAddAch: Bool = false

    @Published var gPhoto = ""
    @Published var gName = ""
    @Published var gCat = ""
    @Published var gEv = ""
    @Published var gHours = ""
    @Published var gAch = ""
    @Published var gBeg = ""
    @Published var gEnd = ""
    
    @Published var games: [GamesModel] = []
    @Published var selectedGame: GamesModel?

    func addGame() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "GamesModel", into: context) as! GamesModel

        loan.gPhoto = gPhoto
        loan.gName = gName
        loan.gCat = gCat
        loan.gEv = gEv
        loan.gHours = gHours
        loan.gAch = gAch
        loan.gBeg = gBeg
        loan.gEnd = gEnd

        CoreDataStack.shared.saveContext()
    }

    func fetchGames() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<GamesModel>(entityName: "GamesModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.games = result.filter{($0.gCat ?? "") == currentCategory}

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.games = []
        }
    }

    @Published var pGame = ""
    @Published var pPhoto = ""
    @Published var pName = ""
    
    @Published var achievements: [PartModel] = []
    @Published var selectedAchievement: PartModel?

    func addAchievement() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "PartModel", into: context) as! PartModel

        loan.pGame = pGame
        loan.pPhoto = pPhoto
        loan.pName = pName

        CoreDataStack.shared.saveContext()
    }

    func fetchAchievements() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PartModel>(entityName: "PartModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.achievements = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.achievements = []
        }
    }
    
}
