//
//  ViewController.swift
//  MovieDescriptor
//
//  Created by smurthy3 on 1/19/16.
//  Copyright © 2016 edu.asu.msse.smurthy3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textHere: UITextField!
    //@IBOutlet weak var rating: UITextField!
    @IBOutlet weak var released: UITextField!
    @IBOutlet weak var actors: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var plot: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func click(sender: AnyObject) {
    let s:Movie = Movie(jsonStr: "{\"Title\":\"Frozen\",\"Year\":\"2013\",\"Rated\":\"PG\",\"Released\":\"27 Nov 2013\",\"Actors\":[\"Kristen Bell, Idina Menzel, Jonathan Groff, Josh Gad\"],\"Plot\":\"When the newly crowned Queen Elsa accidentally uses her power to turn things into ice to curse her home in infinite winter, her sister, Anna, teams up with a mountain man, his playful reindeer, and a snowman to change the weather condition.\",\"Rating\":\"7.6\"}")
        
        
        //let n: String = " Movie: \(s.name) Rating:  \(s.rated) Released on: \(s.released) Actors: \(s.actors) plot: \(s.plot)"
        textHere.text = s.name
        //rating.text = s.rated
        released.text = s.released
        actors.text = "Actors are \(s.actors)"
        year.text = s.year
        plot.text = s.plot
        
        
    }
    class Movie {
        var name: String
        var year: String
        var plot: String
        //var rated: String
        var released: String
        var actors: Array<String>
        init (jsonStr: String){
            self.name = ""
            self.plot = ""
            //self.rated = ""
            self.released = ""
            self.year = ""
            self.actors = [String]()
            if let data: NSData = jsonStr.dataUsingEncoding(NSUTF8StringEncoding){
                do{
                    let dict = try NSJSONSerialization.JSONObjectWithData(data,options:.MutableContainers) as?[String:AnyObject]
                    self.name = (dict!["Title"] as? String)!
                    //self.rated = (dict!["Rating"] as? String)!
                    self.released = (dict!["Released"] as? String)!
                    self.plot = (dict!["Plot"] as? String)!
                   self.year = (dict!["Year"] as? String)!
                    self.actors = (dict!["Actors"] as? Array<String>)!
                } catch {
                    print("unable to convert to dictionary")
                    
                }
            }
        }
        
        func toJsonString() -> String {
            var jsonStr = "";
            let dict = ["name": name, "year": year, "takes":actors,"released": released, "plot": plot]
            do {
                let jsonData = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
                // here "jsonData" is the dictionary encoded in JSON data
                jsonStr = NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
            } catch let error as NSError {
                print(error)
            }
            return jsonStr
        }
    }
    

}

