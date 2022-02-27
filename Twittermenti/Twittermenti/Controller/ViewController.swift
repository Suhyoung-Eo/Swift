//
//  ViewController.swift
//  Twittermenti
//
//  Created by Suhyoung Eo on 2021/10/25.
//

import UIKit
import SwifteriOS
import CoreML


class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let tweetCount = 100
    
    let sentimentClassifier = try! TweetSentimentClassifier(configuration: MLModelConfiguration.init())
    
    // Instantiation using Twitter's OAuth Consumer Key and secret
    // 해당 secret key는 유출 방지를 위해 .plist에 정의한 후 불러와서 사용하는 것이 좋음
    // 편의상 그냥 진행함
    let swifter = Swifter(consumerKey: "/* consumerKey */", consumerSecret: "/* consumerSecret */", oauthToken: "/* oauthToken */", oauthTokenSecret: "/* oauthTokenSecret */")

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        
        fetchTweets()
        
    }
    
    func fetchTweets() {
        
        if let searchText = textField.text {
            
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended) { results, metadata in
                var tweets = [TweetSentimentClassifierInput]()
                
                for i in 0..<self.tweetCount {
                    if let tweet = results[i]["full_text"].string {
                        let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }
                
                self.makePrediction(with: tweets)
                
            } failure: { error in
                print("There was error with the Twitter API Request, \(error)")
            }
        }
        
    }
    
    func makePrediction(with tweets: [TweetSentimentClassifierInput]) {
        
        do {
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            
            var sentimentScore = 0
            
            for prediction in predictions {
                let sentiment = prediction.label
                
                if sentiment == "Pos" {
                    sentimentScore += 1
                } else if sentiment == "Neg" {
                    sentimentScore -= 1
                }
            }
            
            updateUI(with: sentimentScore)
            
        } catch {
            print("There was an error with making a prediction: \(error)")
        }
        
    }
    
    func updateUI(with sentimentScore: Int) {
        
        if sentimentScore > 20 {
            sentimentLabel.text = "😍"
        } else if sentimentScore > 10 {
            sentimentLabel.text = "😃"
        } else if sentimentScore > 0 {
            sentimentLabel.text = "🙂"
        } else if sentimentScore == 0 {
            sentimentLabel.text = "😐"
        } else if sentimentScore > -10 {
            sentimentLabel.text = "😕"
        } else if sentimentScore > -20 {
            sentimentLabel.text = "😡"
        } else {
            sentimentLabel.text = "🤮"
        }
        
    }
    
}

