//
//  HttpUtility.swift
//  FavoriteListingDemo
//
//  Created by Admin on 25/02/22.
//

import Foundation
import Combine
class HttpUtility
{
    private var cancellables = Set<AnyCancellable>()
    
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type)-> Future<[T], Error> {
        return Future <[T], Error> { [weak self] promise in
            
            guard let self = self, let url = URL(string: requestUrl.absoluteString) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            print("url is \(requestUrl.absoluteString)")
            URLSession.shared.dataTaskPublisher(for: requestUrl)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...209 ~= httpResponse.statusCode else
                    {
                        throw NetworkError.responseError

                    }
                    return data
                }
                .decode(type: [T].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink {
                    (completion) in
                    switch completion
                    {
                    case .finished :
                        print("completed")
                    case .failure(let error) :
                        print(error.localizedDescription)
                    }
                    print(completion)
                }
        receiveValue: {
                    promise(.success($0))}
                .store(in : &self.cancellables)

        }
}
    

    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completeionHandler:@escaping(_ result: T?) -> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { responseData, httpUrlResponse, error in
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
             
                let decoder = JSONDecoder()
                do
                {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _ = completeionHandler(result)
                }
                catch let error
                {
                    debugPrint("error occure while decoding = \(error.localizedDescription)")
                }
            }
        }.resume()
        
    }
}

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}
