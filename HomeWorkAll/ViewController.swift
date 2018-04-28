//
//  ViewController.swift
//  HomeWorkAll
//
//  Created by CLINK on 2018/4/23.
//  Copyright © 2018年 CLINK. All rights reserved.
//

import UIKit
enum JSONError: String, Error {
    case unknoweError = "Error: unknowned"
    case noData = "Error: no Data"
    case conversionFailed = "Error: conversion from JSON failed"
}
var pUserData: [mainData] = []
var pUserRoom: [roomData] = []
class ViewController: UIViewController {
    var collectionView_1: UICollectionView!
    var collectionView_2: UICollectionView!
    var screenSize: CGSize!
    var searchText: UITextField!
    var lineView: UIView!
    var lineView_2: UIView!
    
    var scrollableImageView: UIImageView!
    var titleText: UILabel!
    var subText: UILabel!
    
    var scrollableImageView_2: UIImageView!
    var titleText_2: UILabel!
    var subText_2: UILabel!
    
    //var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
         screenSize = UIScreen.main.bounds.size
        pUserRoom=[]
        let request = URLRequest(url: URL(string: "https://www.mocky.io/v2/5ae2e3353100005e00083bf8")!)
        let requestTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    do {
                        guard error == nil else{
                            throw JSONError.unknoweError
                        }
                        guard let data = data else{ //等同 data != nil
                            throw JSONError.noData
                        }
                        //JSON可使用NSDictionary來接收
                        guard let jsonData = try? JSONSerialization.jsonObject(with: data,
                                                                               options: []) as? NSDictionary else{
                                                                       throw JSONError.conversionFailed
                        }
                        //這方法不行
//                        if let plus_Data = jsonData!["plusData"] as? NSArray {
//                            if let Data_1 = plus_Data[1] as? NSDictionary{
//                                print(Data_1[0])
//                            }
//                        }
//
//                        if let room_List = jsonData!["roomList"] as? NSArray {
//                                if let room_1 = room_List[0] as? NSDictionary{
//                                    print(room_1[1])
//                                }
//                        }
                        let decoder = JSONDecoder()
        
                        if let  result = try? decoder.decode(plusDataModel.self,
                                                             from: data){
                          
                            for (index,roominfo) in result.roomList.enumerated(){
                                var UserRoom = roomData()
                                    //thumbnail:roominfo.thumbnail, name: <#String#>, flatType: <#String#>, bedNumber: <#Int#>, price: <#Int#>)
                                UserRoom.name = roominfo.name
                                UserRoom.thumbnail = roominfo.thumbnail
                                UserRoom.flatType = roominfo.flatType
                                UserRoom.bedNumber = roominfo.bedNumber
                                UserRoom.price = roominfo.price
                                UserRoom.rate = roominfo.rate
                                UserRoom.goodHost = roominfo.goodHost
                                UserRoom.rateCount = roominfo.rateCount
                               
                                pUserRoom.append(UserRoom)
                             
                                
        
                            }
                                for (index,pData) in result.plusData.enumerated(){
                                    //let titleLabel = UILabel()
                                    //titleLabel.text = pData.title
                                    var UserData = mainData()
                                    UserData.title = pData.title
                                    UserData.thumbnail = pData.thumbnail
                                     UserData.Description = pData.Description
                                    //正規做法 透過 TableView 將每筆資訊寫道Cell上 根據Cell後續在動態修改
                                    //目前作法放上去後就無法修正
                                   pUserData.append(UserData)
                                    
                            }
                           
        
                    }
//                        if let  result2 = try? decoder.decode(plusDataModel.self,
//                                                             from: data){
//                            // print(result.products)
//                            //print(result.products[1].price)
//
//                            DispatchQueue.main.async(execute:{
//                                for (index,plusData) in result2.Datas.enumerated(){
//                                    let titleLabel = UILabel()
//                                    titleLabel.text = plusData.title
//                                    //正規做法 透過 TableView 將每筆資訊寫道Cell上 根據Cell後續在動態修改
//                                    //目前作法放上去後就無法修正
//
//
//                                }
//                            })
//
//                        }
                } catch let error as JSONError{
                        print(error.rawValue)
                } catch let error as NSError{ //最大眾寫法
                        print(error.debugDescription)
            }
            DispatchQueue.main.async(execute:{
             self.viewInit()
            })
        }
        requestTask.resume()
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func  viewInit()
    {
        let layoutGuide = view.safeAreaLayoutGuide
        
        searchText = UITextField()
        searchText.translatesAutoresizingMaskIntoConstraints = false
       // searchText.layer.shadowOffset = CGSize(5, 5)
        searchText.layer.shadowOpacity = 0.7 //目前陰影位置是異常要找一下資料
        //searchText.layer.shadowRadius = 1
        searchText.placeholder = "試試[台北101]"
        searchText.isEnabled = true
        searchText.borderStyle = .line
        searchText.layer.borderWidth = 1.0
        searchText.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(searchText)
        searchText.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor,
                                            constant: 15).isActive = true
        
        searchText.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor,
                                             constant: -15).isActive = true
        searchText.topAnchor.constraint(equalTo: layoutGuide.topAnchor,
                                        constant: 8).isActive = true
         searchText.heightAnchor.constraint(equalToConstant: 48).isActive = true
      
        lineView = UIView()
        lineView.backgroundColor = UIColor.gray
        lineView.translatesAutoresizingMaskIntoConstraints = false
        //lineView.layer.shadowOffset = CGSize(5, 5)
        lineView.layer.shadowOpacity = 0.7
        lineView.layer.shadowRadius = 3
        view.addSubview(lineView)
        lineView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor,
                                            constant: 0).isActive = true
        
        lineView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor,
                                             constant: 0).isActive = true
        lineView.topAnchor.constraint(equalTo: searchText.bottomAnchor,
                                        constant: 8).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // 使用 FlowLayout 排版 //必須要增加
       
        let layout = UICollectionViewFlowLayout()
        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        // 設置每一行的間距
        layout.minimumLineSpacing = 5
        // 設置每個 cell 的尺寸
        layout.itemSize = CGSize(width: CGFloat(screenSize.width * 2) - 10.0,
                                 height: 400) //這邊高度寫死是否正確？
        layout.scrollDirection = .horizontal
        
        
        // 加入 Collection View
        collectionView_1 = UICollectionView(frame: .zero, //.zero代表的意思是？
                                            collectionViewLayout: layout)
        collectionView_1.translatesAutoresizingMaskIntoConstraints = false
        collectionView_1.delegate = self
        collectionView_1.dataSource = self
        collectionView_1.register(DateCell.self,
                                  forCellWithReuseIdentifier: "cell")
        collectionView_1.showsVerticalScrollIndicator = true
        collectionView_1.showsHorizontalScrollIndicator = true
        collectionView_1.tag = 2
        view.addSubview(collectionView_1)
        
        
        
        collectionView_1.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
       // collectionView_1.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        collectionView_1.topAnchor.constraint(equalTo: lineView.bottomAnchor).isActive = true
        collectionView_1.heightAnchor.constraint(equalToConstant: 440).isActive = true
        collectionView_1.widthAnchor.constraint(equalToConstant: screenSize.width * 2).isActive = true
        
        lineView_2 = UIView()
        lineView_2.backgroundColor = UIColor.gray
        lineView_2.translatesAutoresizingMaskIntoConstraints = false
        //lineView.layer.shadowOffset = CGSize(5, 5)
        lineView_2.layer.shadowOpacity = 0.7
        lineView_2.layer.shadowRadius = 3
        view.addSubview(lineView_2)
        lineView_2.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor,
                                          constant: 0).isActive = true
        
        lineView_2.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor,
                                           constant: 0).isActive = true
       lineView_2.topAnchor.constraint(equalTo: collectionView_1.bottomAnchor,
                                      constant: 8).isActive = true
//        lineView_2.topAnchor.constraint(equalTo: layoutGuide.topAnchor,
//                                        constant: 500).isActive = true
        lineView_2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let layout_2 = UICollectionViewFlowLayout()
        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        layout_2.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        // 設置每一行的間距
        layout_2.minimumLineSpacing = 5
        // 設置每個 cell 的尺寸
        layout_2.itemSize = CGSize(width: CGFloat(screenSize.width / 2) - 10.0,
                                 height:  150) //這邊高度寫死是否正確？
        layout_2.scrollDirection = .vertical
        // 加入 Collection View
        collectionView_2 = UICollectionView( frame: .zero,
                                            collectionViewLayout: layout_2)
        collectionView_2.translatesAutoresizingMaskIntoConstraints = false
        collectionView_2.delegate = self
        collectionView_2.dataSource = self
        collectionView_2.register(RoomCell.self,
                                  forCellWithReuseIdentifier: "cell2")
        collectionView_2.showsVerticalScrollIndicator = true
        collectionView_2.showsHorizontalScrollIndicator = true
        collectionView_2.tag = 1
        view.addSubview(collectionView_2)



        collectionView_2.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        collectionView_2.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        collectionView_2.topAnchor.constraint(equalTo: lineView_2.bottomAnchor).isActive = true
        //必須給高度才能產生為什麼？另外這邊高度寫死是否正確
        collectionView_2.heightAnchor.constraint(equalToConstant: 940).isActive = true
    
        //無法在第二個collectionView做到上下滑動
        //請問怎麼將在這頁取到的陣列或結構資料 傳給DataCell跟 RoomCell呢？
        //目前只想到設定成全域變數
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberItem: Int = 0
        switch collectionView.tag {
        case 2:
            numberItem = pUserData.count
        case 1:
            numberItem = pUserRoom.count
        default:
           numberItem = 1
        }
        return numberItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //var cell: UICollectionViewCell!
        var cell: UICollectionViewCell = UICollectionViewCell()
        switch collectionView.tag {
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                               for: indexPath)
             let dateCell = cell as! DateCell
            
            dateCell.label.text = pUserData[indexPath.item].title
            dateCell.label2.text = pUserData[indexPath.item].Description
            
            let request = URLRequest(url: URL(string: pUserData[indexPath.item].thumbnail)!)
            let configiguration = URLSessionConfiguration.default
                    configiguration.timeoutIntervalForRequest = .infinity //讀取時間永久
            let urlSession = URLSession(configuration: configiguration)
                    //這邊有出入
            let requestTask = urlSession.downloadTask(with: request) { (url, response, error) in
            
                        do {
                            guard error == nil else {
                                throw JSONError.unknoweError
                            }
                            if let url = url {
                               let downimage = UIImage(data: try Data(contentsOf: url))
            
            
                                DispatchQueue.main.async(execute: {
                                    //dateCell.lableImageView.image =  downimage
                                    //imageView.frame = CGRect(x: 0, y: 60, width: 300, height: 300)
                                    //imageView.contentMode = .scaleAspectFit
                                    //self.view.addSubview(imageView)
                                })
                            }
                        } catch let error as JSONError{
                            print(error.rawValue)
                        } catch let error as NSError{ //最大眾寫法
                            print(error.debugDescription)
                        }
            }
            requestTask.resume()
            
           //dateCell.lableImageView
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2",
                                               for: indexPath)
            let dateCell = cell as! RoomCell
            
            dateCell.label.text = pUserRoom[indexPath.item].name
            dateCell.label2.text = pUserRoom[indexPath.item].flatType
            //dateCell.label3.text = pUserRoom[indexPath.item].price
            //dateCell.label4.text = pUserRoom[indexPath.item].rate
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! DateCell
        }
        
        
        return cell
    }
    //有註冊header跟footer才用
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        let reusableView = UICollectionReusableView() //被重複使用 是該ＶＩＥＷ的最上層

//        return reusableView
//    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

