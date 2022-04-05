//
//  ThreadsViewController.swift
//  swift-dev-lab
//
//  Created by Sergio Santos on 22/03/22.
//

import Foundation
import UIKit

class ThreadsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Init")
        
        let mainQueue = DispatchQueue.main
        //let concurrentQueue = DispatchQueue(label: "com.test.concurrent", attributes: .concurrent)
        //let serial = DispatchQueue(label: "com.test.serial")
        
        /*mainQueue.async {
            self.printApples()
            self.printCandies()
        }*/
        
        //serialQueueTest()
        
        concurrentQueueTest()
        
        //globalQueueTest()
        
        //let queue = DispatchQueue(label: String, qos: DispatchQoS,attributes: DispatchQueue.Attributes,autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency, target: DispatchQueue?)
    }
    
    func printCandies(){
      for i in 0..<3 {
         print("\(i) => Candy")
       }
    }
    func printApples(){
      for i in 0..<3 {
          print("\(i) => Apple")
       }
    }
    
    func serialQueueTest(){
        print("serialQueueTest")
       let queue = DispatchQueue(label: "com.knowstack.queue1")
       queue.async {
         self.printApples()
       }
       queue.async {
         self.printCandies()
       }
    }
    
    func concurrentQueueTest(){
        print("concurrentQueueTest")
       let queue = DispatchQueue(label: "com.knowstack.queue2", attributes: .concurrent)
       queue.async {
         self.printApples()
       }
       queue.async {
         self.printCandies()
       }
    }
    
    func globalQueueTest(){
        print("globalQueueTest")
       let globalQueue = DispatchQueue.global()
       globalQueue.sync {
           self.printCandies()
       }
       globalQueue.async {
          self.printApples()
       }
       globalQueue.async {
          self.printCandies()
       }
    }

}
