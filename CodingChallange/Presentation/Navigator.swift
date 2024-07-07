//
//
// Navigator.swift
// CodingChallange
//
// Created by Caio Mansho on 07/07/24
// Copyright © 2024 Caio Mansho. All rights reserved.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
        

import Foundation
import UIKit


protocol Navigatable {
    var navigator: Navigator! { get set }
}

class Navigator {
    static var `default` = Navigator()

    // MARK: - segues list, all app scenes
    enum Scene {
        case tabs(viewModel: ConnectivityVM)
    }

    enum Transition {
        case root(in: UIWindow)
        case navigation(type: HeroDefaultAnimationType)
        case customModal(type: HeroDefaultAnimationType)
        case modal
        case detail
        case alert
        case custom
    }

    // MARK: - get a single VC
    func get(segue: Scene) -> UIViewController? {
        switch segue {
        case .tabs(let viewModel):
            let rootVC = HomeTabBarController(viewModel: viewModel, navigator: self)
            let detailVC = InitialSplitViewController(viewModel: nil, navigator: self)
            let detailNavVC = NavigationController(rootViewController: detailVC)
            let splitVC = SplitViewController()
            splitVC.viewControllers = [rootVC, detailNavVC]
            return splitVC

        case .search(let viewModel): return SearchViewController(viewModel: viewModel, navigator: self)
        case .languages(let viewModel): return LanguagesViewController(viewModel: viewModel, navigator: self)
        case .users(let viewModel): return UsersViewController(viewModel: viewModel, navigator: self)
        case .userDetails(let viewModel): return UserViewController(viewModel: viewModel, navigator: self)
        case .repositories(let viewModel): return RepositoriesViewController(viewModel: viewModel, navigator: self)
        case .repositoryDetails(let viewModel): return RepositoryViewController(viewModel: viewModel, navigator: self)
        case .contents(let viewModel): return ContentsViewController(viewModel: viewModel, navigator: self)
        case .source(let viewModel): return SourceViewController(viewModel: viewModel, navigator: self)
        case .commits(let viewModel): return CommitsViewController(viewModel: viewModel, navigator: self)
        case .branches(let viewModel): return BranchesViewController(viewModel: viewModel, navigator: self)
        case .releases(let viewModel): return ReleasesViewController(viewModel: viewModel, navigator: self)
        case .pullRequests(let viewModel): return PullRequestsViewController(viewModel: viewModel, navigator: self)
        case .pullRequestDetails(let viewModel): return PullRequestViewController(viewModel: viewModel, navigator: self)
        case .events(let viewModel): return EventsViewController(viewModel: viewModel, navigator: self)
        case .notifications(let viewModel): return NotificationsViewController(viewModel: viewModel, navigator: self)
        case .issues(let viewModel): return IssuesViewController(viewModel: viewModel, navigator: self)
        case .issueDetails(let viewModel): return IssueViewController(viewModel: viewModel, navigator: self)
        case .linesCount(let viewModel): return LinesCountViewController(viewModel: viewModel, navigator: self)
        case .theme(let viewModel): return ThemeViewController(viewModel: viewModel, navigator: self)
        case .language(let viewModel): return LanguageViewController(viewModel: viewModel, navigator: self)
        case .acknowledgements: return AcknowListViewController()
        case .contacts(let viewModel): return ContactsViewController(viewModel: viewModel, navigator: self)

        case .whatsNew(let block):
            if let versionStore = block.2 {
                return WhatsNewViewController(whatsNew: block.0, configuration: block.1, versionStore: versionStore)
            } else {
                return WhatsNewViewController(whatsNew: block.0, configuration: block.1)
            }

        case .safari(let url):
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return nil

        case .safariController(let url):
            let vc = SFSafariViewController(url: url)
            return vc

        case .webController(let url):
            let vc = WebViewController(viewModel: nil, navigator: self)
            vc.load(url: url)
            return vc
        }
    }

    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController()
        }
    }

    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }

    // MARK: - invoke a single segue
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition)
        }
    }

    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        switch transition {
        case .root(in: let window):
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                window.rootViewController = target
            }, completion: nil)
            return
        case .custom: return
        default: break
        }

        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }

        if let nav = sender as? UINavigationController {
            // push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        }

        switch transition {
        case .navigation(let type):
            if let nav = sender.navigationController {
                // push controller to navigation stack
                nav.hero.navigationAnimationType = .autoReverse(presenting: type)
                nav.pushViewController(target, animated: true)
            }
        case .customModal(let type):
            // present modally with custom animation
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                nav.hero.modalAnimationType = .autoReverse(presenting: type)
                sender.present(nav, animated: true, completion: nil)
            }
        case .modal:
            // present modally
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.present(nav, animated: true, completion: nil)
            }
        case .detail:
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.showDetailViewController(nav, sender: nil)
            }
        case .alert:
            DispatchQueue.main.async {
                sender.present(target, animated: true, completion: nil)
            }
        default: break
        }
    }

}

