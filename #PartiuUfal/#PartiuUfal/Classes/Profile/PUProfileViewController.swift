//
//  PUProfileViewController.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 27/07/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit

class PUProfileViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var lblUserNickname: UILabel!
    @IBOutlet weak var lblDislikeCount: UILabel!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblRideCount: UILabel!
    @IBOutlet weak var lblFavoritePosition: UILabel!
    @IBOutlet weak var lblFavoriteTarget: UILabel!
    @IBOutlet weak var lblFavoriteFriend: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCurrentUser()
    }
    
    func setupLayout() {
        self.userImageView.layer.cornerRadius = userImageView.layer.bounds.height/2
        self.userImageView.layer.masksToBounds = true
        self.logoutBtn.layer.cornerRadius = self.logoutBtn.frame.height/2
        self.logoutBtn.layer.masksToBounds = true
    }
    
    func setupNavigationBar() {
        self.title = "Perfil"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let btEditProfile = UIBarButtonItem.init(title: "Editar Perfil", style: .plain, target: self, action: #selector(openEditProfile))
        self.navigationItem.rightBarButtonItem = btEditProfile
    }
    
    func setupCurrentUser() {
        PUUser.current()?.picture?.fetchIfNeededInBackground(block: { (result, error) in
            if error == nil {
                PUUser.current()?.picture?.image.getDataInBackground(block: {
                    (data, error) in
                    if data != nil {
                        self.userImageView.image = UIImage(data: data!)
                    }
                })
            }
        })
        
        if let nickname = PUUser.current()?.nickname {
            self.lblUserNickname.text = nickname
        }
        
        if let likesCnt = PUUser.current()?.likesCount {
            self.lblLikeCount.text = String(describing: likesCnt)
        }
        
        if let dislikeCnt = PUUser.current()?.dislikesCount {
            self.lblDislikeCount.text = String(describing: dislikeCnt)
        }
        
        if let ridesCount = PUUser.current()?.ridesHistory?.count {
            self.lblRideCount.text = String(ridesCount)
        } else {
            self.lblRideCount.text = "O usuário não tem caronas suficientes para calcular esta informação."
        }
        
        if let favoritePosition = PUUser.current()?.favoritePosition {
            self.lblFavoritePosition.text = favoritePosition
        } else {
            self.lblFavoritePosition.text = "O usuário não tem caronas suficientes para calcular esta informação."
        }
        
        if let favoriteTarget = PUUser.current()?.favoriteTarget {
            self.lblFavoriteTarget.text = favoriteTarget
        } else {
            self.lblFavoriteTarget.text = "O usuário não tem caronas suficientes para calcular esta informação."
        }
        
        if let favoriteFriend = PUUser.current()?.favoriteFriend {
            self.lblFavoriteFriend.text = favoriteFriend
        } else {
            self.lblFavoriteFriend.text = "O usuário não tem caronas suficientes para calcular esta informação."
        }
    }
    
    func openEditProfile() {
        let controller = PUEditProfileViewController(cameFromProfile: true)
        controller.title = "Editar Perfil"
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        PUUser.logOutInBackground { (error) in
            if error == nil {
                PUNavigationManager.switchRootViewController(PULoginViewController(), animated: true, completion: nil)
            }
        }
    }
    
}
