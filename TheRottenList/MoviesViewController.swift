//
//  MoviesViewController.swift
//  TheRottenList
//
//  Created by Andrew Chao on 9/15/14.
//  Copyright (c) 2014 Andrew Chao. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var networkMessageLabel: UILabel!

    var movies:[NSDictionary] = []
    var refreshControl:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationTitle.title = "Movies"
        tableView.delegate = self
        tableView.dataSource = self


        view.showActivityViewWithLabel("Loading...")
        reloadTableView(true)

        //set up pull to refresh
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "reloadTableView:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }

    // Reloads the Table View with Box Office Movies
    func reloadTableView(sender:AnyObject)
    {
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=mubw7shrmp96ejf9huvdz33p"
        var request = NSURLRequest(URL: NSURL(string: url))

        networkMessageLabel.hidden = true
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let httpResponse = response as NSHTTPURLResponse
            if error != nil || httpResponse.statusCode != 200{
                self.networkMessageLabel.hidden = false
                self.networkMessageLabel.text = "Network Error."
            } else {
                var object =  NSJSONSerialization.JSONObjectWithData(data, options:nil, error: nil) as NSDictionary
                self.movies = object["movies"] as [NSDictionary]

                self.tableView.reloadData()
            }

            self.view.hideActivityView()
            self.refreshControl.endRefreshing()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell

        var movie = movies[indexPath.row]

        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        cell.ratingLabel.text = movie["mpaa_rating"] as? String

        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String

        cell.posterView.setImageWithURL(NSURL(string: posterUrl))
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "movieDetailsSegue" {
            var indexPath = tableView.indexPathForSelectedRow() as NSIndexPath!
            var vc = segue.destinationViewController as MovieDetailsViewController
            vc.movie = movies[indexPath.row] as NSDictionary
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
        }
    }
}
