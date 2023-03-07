//
//  HomeViewModel.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 07/03/23.
//

import Foundation

//MARK: - Protocols
protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    func fetchPopularGames()
    func searchGames(_ keyword: String)
    func getGameCount() -> Int
    func getGame(at index: Int) -> RawgModel?
    func getGameId(at index: Int) -> Int?
    func orderList(opt:Int)
}

protocol HomeViewModelDelegate: AnyObject {
    func gamesLoaded()
}

//MARK: - Classes
final class HomeViewModel: HomeViewModelProtocol {
    weak var delegate: HomeViewModelDelegate?
    private var games: [RawgModel]?
    private var tempGames: [RawgModel]?
    
    func fetchPopularGames() {
        RawgClient.getPopularGames { [weak self] games, error in
            guard let self = self else { return }
            if let error{
                NotificationCenter.default.post(name: NSNotification.Name("popularGamesErrorMessage"), object: error.localizedDescription)
                self.delegate?.gamesLoaded()
                return
            }
            self.games = games
            self.tempGames = games
            self.delegate?.gamesLoaded()
        }
    }
    
    func searchGames(_ keyword: String) {
        RawgClient.searchGames(gameName: keyword) { [weak self] games, error in
            guard let self = self else { return }
            if let error{
                NotificationCenter.default.post(name: NSNotification.Name("searchGamesErrorMessage"), object: error.localizedDescription)
                self.delegate?.gamesLoaded()
                return
            }
            self.games = games
            self.tempGames = games
            self.delegate?.gamesLoaded()
        }
    }
    
    
    func getGameCount() -> Int {
        games?.count ?? 0
    }
    
    func getGame(at index: Int) -> RawgModel? {
        games?[index]
    }
    
    func getGameId(at index: Int) -> Int? {
        games?[index].id
    }
    
    func orderList(opt:Int){
        switch opt {
        case 1:
            games = tempGames?.sorted{$0.name ?? "-" < $1.name ?? "-"}
        case 2:
            games = tempGames?.sorted{$0.released ?? "9" < $1.released ?? "9"}
        case 3:
            games = tempGames?.sorted{$0.metacritic ?? 0 > $1.metacritic ?? 0}
        default:
            self.games = self.tempGames
        }
        delegate?.gamesLoaded()
    }
    
}
