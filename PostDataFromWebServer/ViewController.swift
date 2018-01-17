//
//  ViewController.swift
//  PostDataFromWebServer
//
//  Created by NguyenCuong on 1/17/18.
//  Copyright © 2018 NguyenCuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let url_to_request = "http://www.kaleidosblog.com/tutorial/nsurlsession_tutorial.php"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        upload_request()
        download_request()
        data_request()
    }
    
    func upload_request() {
        let url = URL(string: url_to_request)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let data = "data=Hi".data(using: String.Encoding.utf8)
        let task = session.uploadTask(with: request, from: data) { (data, reponse, error) in
            guard let _: Data = data, let _:URLResponse = reponse, error == nil else{
                return
            }
            let dataString = String(data: data!, encoding: String.Encoding.utf8)
            print(dataString)
        }
        task.resume()
        
    }
    
    func download_request() {
        let url: URL = URL(string: url_to_request)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "data=Hello"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.downloadTask(with: url, completionHandler: { ( location, reponse, error) in
            guard let _:URL = location, let _: URLResponse = reponse, error == nil else{
                return
            }
            
            let urlContents = try! String(contentsOf: location!, encoding: String.Encoding.utf8)
            
            guard let _: String = urlContents else {
                return
            }
            print(urlContents)
        })
        task.resume()
    }
    

    func data_request() {
        let url = URL(string: url_to_request)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "data=Hello"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request) { (data, reponse, error) in
            guard let _:Data = data, let _: URLResponse = reponse, error == nil else{
                return
            }
            let dataString = String(data: data!, encoding: String.Encoding.utf8)
            print(dataString)
            
        }
        task.resume()
    }


}

