//
//  TCPClient.swift
//  TaipeiCityPark
//
//  Created by ChenAlan on 2018/6/29.
//  Copyright © 2018年 ChenAlan. All rights reserved.
//

import Foundation

class TCPClient {

    func taskForGETSpot(completionHandlerForSpot: @escaping (_ spots: [Spot]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812") else {
            print("Cannot make URL by given string.")
            return
        }

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error ?? "Error Found")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("The request return a statusCode other than 2xx")
                return
            }

            guard let data = data else {
                print("No data was returned by the request")
                return
            }

            do {
                let root = try JSONDecoder().decode(Root.self, from: data)
                let result = root.result
                let spots = result.spots
                completionHandlerForSpot(spots, nil)
            } catch let error {
                completionHandlerForSpot(nil, error)
            }
        }

        task.resume()
    }
}
