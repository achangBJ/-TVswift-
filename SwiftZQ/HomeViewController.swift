//
//  HomeViewController.swift
//  SwiftZQ
//
//  Created by XGJ on 16/7/22.
//  Copyright © 2016年 XGJ. All rights reserved.
//

import UIKit
import MediaPlayer
class HomeViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var collection : UICollectionView?
    var array : NSArray?
    var v = CollectionGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        self.navigationItem.title = "首页"
        self.array = []
        let REQUE:RequestNetwork = RequestNetwork()
        setUI()
        REQUE.GET("http://www.zhanqi.tv/api/static/live.index/recommend-apps.json?", parameters: nil) { (dict) in
//            print(dict);
            self.array=dict
            self.collection?.reloadData()
        }
    }
    func setUI() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
        //设置头视图高度
        collection = UICollectionView(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height), collectionViewLayout: layout)
        //注册一个cell
        collection! .registerClass(LiveCollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        //注册一个headView
        collection! .registerClass(CollectionGroup.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        collection!.delegate = self;
        collection!.dataSource = self;
        collection!.backgroundColor = UIColor.whiteColor()
        //设置每一个cell的宽高
        layout.itemSize = CGSizeMake((self.view.bounds.size.width-30)/2, 150)
        self.view .addSubview(collection!)
        collection?.snp_makeConstraints(closure: { (make) in
            make.top.left.bottom.right.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        })
        
    }
//    分区高度
    func collectionView(collectionView:UICollectionView,layout:UICollectionViewLayout,referenceSizeForHeaderInSection:NSInteger) -> CGSize {
        return CGSizeMake(300, 50)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        //分区
        if kind == UICollectionElementKindSectionHeader{
            v = (collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headView", forIndexPath: indexPath) as?CollectionGroup)!
            v.backgroundColor = UIColor.whiteColor()
            var model = HListModel()
            model = self.array![indexPath.section] as! HListModel
            v.setTItle(model.title)
        }
        return v
        
        
        
    }
    override func didReceiveMemoryWarning() {
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return (self.array?.count)!
    }
    //返回多少个cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let arrassy = self.array![section]["lists"]
        let model:HListModel = self.array![section] as! HListModel
//        var listmodel = model.lists
        
        return (model.lists.count)
    }
    //返回自定义的cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:LiveCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! LiveCollectionViewCell
        let model:HListModel = (self.array![indexPath.section]as?HListModel)!
        let listmodel:ListClassModel = model.lists[indexPath.row] as! ListClassModel
        cell.setdataS(listmodel);
        cell.backgroundColor = UIColor.clearColor();
        return cell
    }
    
    //返回cell 上下左右的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(5, 10, 5, 10)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        print(indexPath.row);
        let model:HListModel = (self.array![indexPath.section]as?HListModel)!
        let listmodel:ListClassModel = model.lists[indexPath.row] as! ListClassModel
        self.open(listmodel.videoId)
        
    }
    

//:MARK
    var rootViewController:UIViewController {
        return (UIApplication.sharedApplication().keyWindow?.rootViewController)!;
    }
    //遮罩层
    lazy var maskLayer:UIView =  {
        let maskLayer = UIView.init(frame: UIScreen.mainScreen().bounds);
        maskLayer.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5);
        maskLayer.alpha = 0;
        let closeButton = UIButton.init(frame: maskLayer.bounds);
        closeButton.addTarget(self, action: #selector(HomeViewController.close), forControlEvents: .TouchUpInside);
        maskLayer.addSubview(closeButton);
        //        let url = NSURL.init(string:"http://dlhls.cdn.zhanqi.tv/zqlive/"+videoID+".m3u8")
        //        moviePlayer.contentURL = url
        //        moviePlayer.prepareToPlay()
        
        return maskLayer;
    }()
    private lazy var moviePlayer : MPMoviePlayerController = {
        let player = MPMoviePlayerController()
        player.view.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height/2)
        // 设置自动播放
        player.shouldAutoplay = true
        // 设置源类型
        player.movieSourceType = .Unknown
        // 取消下面的控制视图: 快进/暂停等...
        player.controlStyle = .None
        return player
        
    }()

  
    //MARK: 开启
    func open(str:String)
    {
        //添加视图
        let url = NSURL.init(string:"http://dlhls.cdn.zhanqi.tv/zqlive/"+str+".m3u8")
        moviePlayer.contentURL = url
        moviePlayer.prepareToPlay()
        self.rootViewController.view .addSubview(self.maskLayer);
        moviePlayer.view.layer.anchorPoint = CGPointMake(0.5, 0.5)
        UIApplication.sharedApplication().keyWindow?.addSubview(moviePlayer.view);
        UIApplication.sharedApplication().keyWindow?.backgroundColor = UIColor.blackColor();
        
        //计算位置
        
        var frame = moviePlayer.view.frame;
        
        frame.origin.y -= frame.size.height;
        
        //第一步动画
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.rootViewController.view.layer.transform = self.getFirstTransform();
            
        }) { (finished) -> Void in
            //第二步动画
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.rootViewController.view.layer.transform = self.getSecondTransform();
                self.maskLayer.alpha = 1;
                self.moviePlayer.view.frame = frame;
                
                }, completion: { (finished) -> Void in
                    
            })
        };
    }
    //MARK: 关闭
    func close()
    {
        var frame = self.moviePlayer.view.frame;
        moviePlayer.stop()
        frame.origin.y += frame.size.height;
        UIView.animateWithDuration(0.05, animations: { () -> Void in
            self.rootViewController.view.layer.transform = self.getFirstTransform();
            self.moviePlayer.view.frame = frame;
            
            
        }) { (finished) -> Void in
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.rootViewController.view.layer.transform = CATransform3DIdentity;
                self.maskLayer.alpha = 0;
                }, completion: { (finished) -> Void in
                    self.maskLayer.removeFromSuperview();
                    self.moviePlayer.stop()
                    UIApplication.sharedApplication().keyWindow?.backgroundColor = UIColor.whiteColor();
            })
        }
    }
    
    //MARK: 获取第一次转换
    func getFirstTransform() -> CATransform3D
    {
        var transform = CATransform3DIdentity;
        transform.m34 = 1.0 / -900.0;
        transform = CATransform3DScale(transform, 0.095, 0.95, 1);
        transform = CATransform3DRotate(transform, CGFloat(15.0*M_PI/180.0), 1, 0, 0);
        transform = CATransform3DTranslate(transform, 0, 0, -100.0)
        return transform;
    }
    
    //MARK: 获取第二次转换
    func getSecondTransform() -> CATransform3D
    {
        var transform = CATransform3DIdentity;
        transform.m34 = self.getFirstTransform().m34;
        transform = CATransform3DTranslate(transform, 0, (self.view.frame.size.height) * -0.08, 0);
        transform = CATransform3DScale(transform, 0.8, 0.8, 1.0);
        return transform;
    }
    
    

    
    


}
