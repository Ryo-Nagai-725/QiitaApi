//
//  QIitaViewController.swift
//  QiitaApi
//
//  Created by 永井涼 on 2020/11/28.
//

import UIKit

struct Qiita: Codable {
    let title: String
    let createdAt: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case createdAt = "created_at"
        case user = "user"
    }
}

struct User: Codable {
    let name: String
    let profileImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case profileImageUrl = "profile_image_url"
        
    
}
}

class QIitaViewController: UIViewController {
    @IBOutlet weak var qittaTableView: UITableView!
    private var qiitas = [Qiita]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Qiita記事"
        getQiitaApi()
        setupTableView()
        
    }
    
    
    private func getQiitaApi() {
        guard let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=100") else {return}
        var request = URLRequest(url:  url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("情報の取得に失敗しました。:", err)
                return
            }
            
            if let data = data {
                do {
//                    let qiita = try j.jsonObject(with: data, options: .fragmentsAllowed)
                    let qiita = try JSONDecoder().decode([Qiita].self, from: data)
                    self.qiitas = qiita
                    DispatchQueue.main.async {
                        self.qittaTableView.reloadData()
                    }
                    print("json :", qiita)
                } catch(let err) {
                    print("情報の取得に失敗しました。:", err)
                }
            }
            
        }
        task.resume()
    }
    
    func setupTableView() {
        qittaTableView.delegate = self
        qittaTableView.dataSource = self
        qittaTableView.register(UINib(nibName: "QiitaTableViewCell", bundle: nil), forCellReuseIdentifier: "QiitaTableViewCell")
    }
    
}



extension QIitaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qiitas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let qiitaTableViewCell = tableView.dequeueReusableCell(withIdentifier: "QiitaTableViewCell", for: indexPath) as? QiitaTableViewCell else {
            return UITableViewCell()
            
        }
        qiitaTableViewCell.qiita = qiitas[indexPath.row]
        
        return qiitaTableViewCell
    }
    
        
        
    }
    


