//
//  ImageDataController.swift
//  BusStops
//
//  Created by HM on 10/2/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import Foundation
import AlamofireImage
import Alamofire

class ImageDataContoller
{
    static let sharedDataController = ImageDataContoller()
    
    let photoCache = AutoPurgingImageCache(memoryCapacity: 100 * 1024 * 1024,
                                           preferredMemoryUsageAfterPurge: 60 * 1024 * 1024)
    
    //MARK: - Image Downloading
    
    func getNetworkImage(urlString: String, completion: @escaping ((UIImage) -> Void)) -> (Request)
    {
        return Alamofire.request(urlString).responseImage { (response) -> Void in
            guard let image = response.result.value else { return }
            completion(image)
            self.cacheImage(image: image, urlString: urlString)
        }
    }
    
    //MARK: - Image Caching
    
    func cacheImage(image: Image, urlString: String)
    {
        photoCache.add(image, withIdentifier: urlString)
    }
    
    func cachedImage(urlString: String) -> Image?
    {
        return photoCache.image(withIdentifier: urlString)
    }
    
}
