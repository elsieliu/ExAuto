//
//  ExControlCenter.swift
//  ExAuto
//
//  Created by  mapbar_ios on 16/4/20.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import UIKit

public let notiName = "Notification"
public let userInfoKey = "order"
/// 显示层代理需要遵循的协议
public protocol ExDisplayControlProtocol:class {
        /// 二屏mainview
    var secondScreenView:UIView?{get set}
    
    //MARK: - 将来抽成SDK要考虑是否变成optional
    func confirm()//用户按了确认键
    func back()//用户按了back键
    func voiceChange(voiceAmountScale:Float)//音量改变
    func showMenu()//显示菜单
    func hideMenu()//收起菜单
    func showSiri()//显示语音界面
    func hideSiri()//收起语音界面
}

/**
 蓝牙连接状态
 
 - connected:    已连接
 - connecting:   正在连接
 - disconnected: 已断开连接
 */
public enum ExBleConnectionState {
    case connected
    case connecting
    case disconnected
}
/**
 手机蓝牙状态
 
 - available:   已打开
 - unavailabel: 已关闭
 */
public enum ExLocalBleState {
    case available
    case unavailabel
}
/**
 可以识别的语音指令
 
 - backOrder:  返回
 - musicOrder: 播放音乐
 - naviOrder:  导航
 - telOrder:   打电话
 */
public enum ExVROrder {
    case backOrder
    case musicOrder
    case naviOrder
    case telOrder
}
/// 控制中心类
public class ExControlCenter {
    
    //MARK:- 私有变量
        /// CC单例
    private static var singleton:ExControlCenter?
    
        /// 焦点控制
    lazy private var focusManager = ExFocusManager.init()

    
    //MARK:- 公有变量
    //MARK: Focus
        /// 是否显示焦点，默认显示
    public var focusHidden:Bool = false {
        didSet {
            //TODO: 隐藏或者显示焦点
        }
    }
    /**
     当前焦点所在的view上(readonly)
     */
    public var focusView:UIView?{
        get {
            return focusManager.currentItem
        }
    }
    //MARK: BLE:探测到的可用外设列表
    public var availablePeripherals:NSMutableArray = []
    /// Ble与手机的连接状态
    public var bleConnectionState:ExBleConnectionState = .disconnected
    /// 手机的蓝牙状态
    public var localBleState:ExLocalBleState = .unavailabel
        /// 显示层代理
    public weak var displayControlDelegate:ExDisplayControlProtocol?
    //MARK:- 私有方法
    
    //MARK:- 公有方法
    /**
     获取控制中心的单例
     
     - returns: 控制中心的单例
     */
    public class func sharedInstance() -> ExControlCenter? {
        
        if nil == singleton {
            
            singleton = ExControlCenter()
            
        }
        return singleton
    }
    
    //MARK:- BLE方面的方法
    /**
     连接指定BLE设备，待商榷
     */
    public func connectToPeripheral(){
        //TODO:连接指定BLE设备
    
    }
    
    //MARK:要交给DC处理的action
    /**
     遥控器向上
     */
    public func performUp(){
        if !focusHidden {
            focusManager.lookup_Up()
        }
    }
    /**
     遥控器向左
     */
    public func performLeft(){
        if !focusHidden {
            focusManager.lookup_Left()
        }
    }
    /**
     遥控器向右
     */
    public func performRight(){
        if !focusHidden {
            focusManager.lookup_Right()
        }
    }
    /**
     遥控器向下
     */
    public func performDown(){
        if !focusHidden {
            focusManager.lookup_Down()
        }
    }
    /**
     点击确认按钮
     */
    public func confirm() {
        
        if !focusHidden {
            displayControlDelegate?.confirm()
        }
        
    }
    
    /**
     返回
     */
    public func back(){
        
        if !focusHidden {
            displayControlDelegate?.back()
        }
    }
    /**
     指定焦点到view上
     
     - parameter view: 要指定焦点的view
     */
    public func setFocusForView(view:UIView?){
        
        if view != nil && !focusHidden{
            focusManager.setFocusForView(view)
        }
    }
    /**
     打开菜单
     */
    public func showMenu(){
        displayControlDelegate?.showMenu()
    }
    /**
     关闭菜单
     */
    public func hideMenu(){
        displayControlDelegate?.hideMenu()
    }
    /**
     音量调整
     
     - parameter voiceAmoutScale: 调整到的音量比例(0~1)
     */
    public func voiceChange(voiceAmoutScale:Float){

        displayControlDelegate?.voiceChange(voiceAmoutScale)
    }
    
    //MARK:语音指令
    /**
     语音发送命令
     
     - parameter str: 翻译过来的文字
     */
    public func performOrderWithString(order:ExVROrder, str:String?){
        //TODO: 语音命令
    }
    /**
     开启语音
     */
    public func openVR(){
        displayControlDelegate?.showSiri()
    }
    /**
     关闭语音
     */
    public func closeVR(){
        displayControlDelegate?.hideSiri()
    }

}
