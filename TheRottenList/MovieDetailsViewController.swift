//
//  MovieDetailsViewController.swift
//  TheRottenList
//
//  Created by Andrew Chao on 9/15/14.
//  Copyright (c) 2014 Andrew Chao. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieDetailsView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var criticsScoreLabel: UILabel!
    @IBOutlet weak var audienceScoreLabel: UILabel!

    var movie: NSDictionary = {return NSDictionary()}()

    convenience init(movie: NSDictionary){
        self.init()
        self.movie = movie
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var title = movie["title"] as String
        var year = movie["year"] as NSNumber
        navigationBar.title = title
        titleLabel.text = title + " (\(year))"

        var ratings = movie["ratings"] as NSDictionary

        var criticsScore = ratings["critics_score"] as NSNumber
        var audienceScore = ratings["audience_score"] as NSNumber
        criticsScoreLabel.text = "Critics Score: \(criticsScore)"
        audienceScoreLabel.text = "Audience Score: \(audienceScore)"
        synopsis.text = movie["synopsis"] as? String

        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["original"] as String

        // use the low res image first for faster display
        // but this isn't ideal since we already grabbed the image in the previous controller
        poster.setImageWithURL(NSURL(string: posterUrl))

        // use the correct high rest img url
        let fixedPosterUrl = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        poster.setImageWithURL(NSURL(string: fixedPosterUrl))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
