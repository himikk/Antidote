//
//  ProfileMainController.swift
//  Antidote
//
//  Created by Dmytro Vorobiov on 02/11/15.
//  Copyright © 2015 dvor. All rights reserved.
//

import UIKit

protocol ProfileMainControllerDelegate: class {
    func profileMainControllerLogout(controller: ProfileMainController)
}

class ProfileMainController: StaticTableController {
    weak var delegate: ProfileMainControllerDelegate?

    private let submanagerUser: OCTSubmanagerUser
    private let avatarManager: AvatarManager

    private let avatarModel: StaticTableAvatarModel
    private let userNameModel: StaticTableDefaultModel
    private let statusMessageModel: StaticTableDefaultModel
    private let toxIdModel: StaticTableDefaultModel
    private let profileDetailsModel: StaticTableDefaultModel
    private let logoutModel: StaticTableButtonModel

    init(theme: Theme, submanagerUser: OCTSubmanagerUser) {
        self.submanagerUser = submanagerUser

        avatarManager = AvatarManager(theme: theme)

        avatarModel = StaticTableAvatarModel()
        userNameModel = StaticTableDefaultModel()
        statusMessageModel = StaticTableDefaultModel()
        toxIdModel = StaticTableDefaultModel()
        profileDetailsModel = StaticTableDefaultModel()
        logoutModel = StaticTableButtonModel()

        super.init(theme: theme, model: [
            [
                avatarModel,
            ],
            [
                userNameModel,
                statusMessageModel,
            ],
            [
                toxIdModel,
            ],
            [
                profileDetailsModel,
            ],
            [
                logoutModel,
            ],
        ])

        updateModels()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        updateModels()
        reloadTableView()
    }

    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileMainController {
    func updateModels() {
        avatarModel.avatar = avatarManager.avatarFromString(
                submanagerUser.userName(),
                diameter: StaticTableAvatarModel.Constants.AvatarImageSize)
        avatarModel.userInteractionEnabled = false

        userNameModel.title = String(localized: "name")
        userNameModel.value = submanagerUser.userName()
        userNameModel.showArrow = true
        userNameModel.didSelectHandler = changeUserName

        statusMessageModel.title = String(localized: "status_message")
        statusMessageModel.value = submanagerUser.userStatusMessage()
        statusMessageModel.showArrow = true
        statusMessageModel.didSelectHandler = changeStatusMessage

        toxIdModel.title = String(localized: "my_tox_id")
        toxIdModel.value = submanagerUser.userAddress
        toxIdModel.rightButton = String(localized: "show_qr")
        toxIdModel.rightButtonHandler = showToxIdQR
        toxIdModel.showArrow = false
        toxIdModel.userInteractionEnabled = false

        profileDetailsModel.value = String(localized: "profile_details")
        profileDetailsModel.didSelectHandler = showProfileDetails

        logoutModel.title = String(localized: "logout_button")
        logoutModel.didSelectHandler = logout
    }

    func logout() {
        delegate?.profileMainControllerLogout(self)
    }

    func changeUserName() {
        print("changeUserName")
    }

    func changeStatusMessage() {
        print("changeStatusMessage")
    }

    func showToxIdQR() {
        print("showToxIdQR")
    }

    func showProfileDetails() {
        print("showProfileDetails")
    }
}
