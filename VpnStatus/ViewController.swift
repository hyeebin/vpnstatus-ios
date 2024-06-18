//
//  ViewController.swift
//  VpnStatus
//
//  Created by FuturetekICT on 6/17/24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var lbResult: UILabel = {
        let lbResult = UILabel()
        lbResult.translatesAutoresizingMaskIntoConstraints = false
        lbResult.text = "VPN 상태"
        lbResult.numberOfLines = 0
        lbResult.textAlignment = .center
        lbResult.font = UIFont.systemFont(ofSize: 28)
        return lbResult
    }()
    
    lazy var btnStatus: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("VPN 상태 확인", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(clickStatus), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addViews()
        applyConstraints()
    }
    
    fileprivate func addViews() {
        view.addSubview(lbResult)
        view.addSubview(btnStatus)
    }
    
    fileprivate func applyConstraints() {
        let lbResultConstraints = [
            lbResult.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lbResult.topAnchor.constraint(equalTo: view.topAnchor,constant: 300),
         ]
        
        let btnStatusConstraints = [
            btnStatus.topAnchor.constraint(equalTo: lbResult.bottomAnchor,constant: 60),
            btnStatus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            btnStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            btnStatus.heightAnchor.constraint(equalToConstant: 50)
         ]
        
        NSLayoutConstraint.activate(btnStatusConstraints)
        NSLayoutConstraint.activate(lbResultConstraints)
    }

    @objc fileprivate func clickStatus() {
        getVpnStatus()
    }
    
    func getVpnStatus() {
        let checkVpnStatus = CheckVpnStatus()
        let status = checkVpnStatus.isVPNConnected() ? "Connected" : "Not Connected"
        DispatchQueue.main.async { [self] in
            lbResult.text = "VPN 상태: \(status)"
        }
    }
}

