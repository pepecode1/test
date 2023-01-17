//
//  MainVC.swift
//  Prueba
//
//  Created by Pepe Ruiz on 17/01/23.
//

import Kingfisher
import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHistory: UITableView!
    
    var showing = false
    var sv = UIView()
    var page: Int = 1
    var data = [Items]()
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "ViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ViewCell")
    }
    
    @IBAction func button(_ sender: Any) {
        callWS()
    }
    
    func updateProgress(_ enabled: Bool) {
        if !enabled && !showing {
            showing = true
            sv = displaySpinner(onView: self.view)
        } else {
            showing = false
            removeSpinner(spinner: sv)
        }
    }
    
    func displaySpinner(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    func callWS(_ addPage: Bool = false) {
        if let query = textField.text, !query.isEmpty {
            if addPage {
                page += 1
            } else {
                page = 1
                Session.busqueda.append(query)
            }
            updateProgress(false)
            tableViewHistory.isHidden = true
            WebService().search(query: query,
                                page: page) { data in
                if let d = data, let i = d.item.props.pageProps.initialData.searchResult.itemStacks.first {
                    self.data = i.items
                }
                self.tableView.reloadData()
                self.updateProgress(true)
            }
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.tableView:
            return data.count
        case tableViewHistory:
            return Session.busqueda.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.tableView:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewCell") as! ViewCell
            cell.configure(data[indexPath.row])
            return cell
        case tableViewHistory:
            let cell = UITableViewCell()
            cell.textLabel?.text = Session.busqueda[indexPath.row]
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == data.count {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0),
                                       at: .top, animated: true)
            callWS(true)
        }
    }
}

extension MainVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableViewHistory.isHidden = false
        tableViewHistory.reloadData()
    }
}
