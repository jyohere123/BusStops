//
//  BusStopCell.swift
//  BusStops
//
//  Created by HM on 10/2/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class BusStopCell: UITableViewCell
{
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var busNumberLabel: UILabel!
    @IBOutlet weak var busName: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var request: Request?
    var indexPath : NSIndexPath?

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    var busStop: BusStopsList.ViewModel.BusStop?
    {
        didSet
        {
            self.reset()
            self.loadImage()
            self.busNumberLabel?.text = busStop?.id
            self.busName?.text = busStop?.title
        }
    }
    
    func reset()
    {
        mapImageView.image = nil
        request?.cancel()
    }
    
    func loadImage()
    {
        if let image = ImageDataContoller.sharedDataController.cachedImage(urlString: (self.busStop?.imageURL)!)
        {
            populateCell(image)
            return
        }
        downloadImage()
    }
    
    func downloadImage()
    {
        activityIndicator.startAnimating()
        let urlString = self.busStop?.imageURL
        request = ImageDataContoller.sharedDataController.getNetworkImage(urlString: urlString!) { image in
            self.populateCell(image)
        }
    }
    
    func populateCell(_ image: UIImage)
    {
        activityIndicator.stopAnimating()
        self.mapImageView.image = image
    }

    
    
}
