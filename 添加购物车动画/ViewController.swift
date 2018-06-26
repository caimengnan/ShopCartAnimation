//
//  ViewController.swift
//  添加购物车动画
//
//  Created by caimengnan on 2018/6/24.
//  Copyright © 2018年 frameworkdemo. All rights reserved.
//

import UIKit

let kWidth = UIScreen.main.bounds.size.width
let kHeight = UIScreen.main.bounds.size.height

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeight))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        return tableView
    }()
    
    
    lazy var suspendBtn:UIButton = {
       let suspendBtn = UIButton(type: .custom)
        suspendBtn.setImage(UIImage(named: "shopcart"), for: .normal)
        suspendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 25.0)
        suspendBtn.frame = CGRect(x: kWidth - 70, y: kHeight - 100, width: 50, height: 50)
        suspendBtn.backgroundColor = UIColor.white
        suspendBtn.layer.cornerRadius = 8
        suspendBtn.addTarget(self, action: #selector(addToShopCart), for: .touchUpInside)
        return suspendBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "添加购物车动画"
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(suspendBtn)

    }
    
    
    @objc func addToShopCart() {
        print("添加购物车")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.myLabel?.text = "\(indexPath.row)"
        cell.myImageView?.image = UIImage(named: "唐嫣.jpg")
        cell.selectionStyle = .none
        cell.clickCallBack = {
            
            let snapImage = cell.myImageView?.snapshotView(afterScreenUpdates: false)
            
            let snapImageFrame = cell.convert((cell.myImageView?.frame)!, to: self.view)
            
            snapImage?.frame = snapImageFrame
            
            self.view.addSubview(snapImage!)
            
            let path = UIBezierPath()
            //设置起始点
            let startPoint = snapImage?.center
            //以起始点为路径的起点
            path.move(to: startPoint!)
            //设置终点
            let endPoint = self.suspendBtn.center
            //设置第一个控制点
            let controlPoint1 = CGPoint(x: kWidth/2, y: snapImageFrame.origin.y-20)
            //设置第二个控制点
            let controlPoint2 = CGPoint(x: kWidth/2+20, y: snapImageFrame.origin.y + 20)
            
            //添加贝塞尔曲线
            path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            
            let time:TimeInterval = 0.7
            UIView.animate(withDuration: time, animations: {
                
                snapImage?.layer.cornerRadius = 34
                snapImage?.layer.masksToBounds = true
                
                let animation = CAKeyframeAnimation(keyPath: "position")
                animation.path = path.cgPath
                animation.duration = time
                animation.repeatCount = 1
                animation.isRemovedOnCompletion = true
                snapImage?.layer.add(animation, forKey: "position")
                
            }) { (completed) in
                
                snapImage?.removeFromSuperview()
                
                let animation = CAKeyframeAnimation(keyPath: "transform")
                animation.duration = 0.3
                var values = [NSValue]()
                let value1 = NSValue(caTransform3D: CATransform3DMakeScale(0.5, 0.5, 1.0))
                let value2 = NSValue(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1.0))
                let value3 = NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
                values.append(value1)
                values.append(value2)
                values.append(value3)
                animation.values = values
                self.suspendBtn.layer.add(animation, forKey: nil)
                
            }
            
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //点击cell截图，获取截图在view上的相对位置，然后添加动画曲线
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

