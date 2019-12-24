import UIKit
import Flutter
import MomoiOSSwiftSdk

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate{
    var resultReturn: FlutterResult?
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "samples.flutter.dev/battery", binaryMessenger: controller.binaryMessenger)

    viewDidLoad()
    batteryChannel.setMethodCallHandler({
        [weak self](call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        self?.resultReturn = result
        if(call.method == "getBatteryLevel" ) {
            self!.createInitFile(result: result)

        } else if(call.method == "abc" ) {
            self?.receiveBatteryLevel(result: result)
        } else {
            result(FlutterMethodNotImplemented)
            return
        }
        
        
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func receiveBatteryLevel(result: FlutterResult) {
        let dictionary : NSDictionary = [
            "anObject" : "abc",
            "abc" : "123",
            "name" : "hoang",
            "birthday" : "12/11/117",
            "age" : 22,
        ]
        result(dictionary)
    }
    
    func viewDidLoad() {
//        // Do any additional setup after loading the view.
              NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "NoficationCenterTokenReceived"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.NoficationCenterTokenReceived(notif:)), name:NSNotification.Name(rawValue: "NoficationCenterTokenReceived"), object: nil)
    }
    
    func createInitFile(result: FlutterResult) {
        let paymentinfo = NSMutableDictionary()
           paymentinfo["merchantcode"] = "CGV01"
           paymentinfo["merchantname"] = "CGV Cinemas"
           paymentinfo["merchantnamelabel"] = "Service"
           paymentinfo["orderId"] = "012345XXX"
           paymentinfo["orderLabel"] = "OrderID"
           paymentinfo["amount"] = 20000
           paymentinfo["fee"] = 0
           paymentinfo["description"] = "Thanh toán vé xem phim"
           paymentinfo["extra"] = "{\"key1\":\"value1\",\"key2\":\"value2\"}"
           paymentinfo["username"] = "payment_username" //user id/user identify/user email
           paymentinfo["appScheme"] = "partnerSchemeId"   //partnerSchemeId provided by MoMo , get from business.momo.vn
           MoMoPayment.createPaymentInformation(info: paymentinfo)
           print(paymentinfo)
        let dictionary : NSDictionary = [
            "anObject" : "xxxx",
            "abc" : "eeee",
            "name" : "zzzz",
            "birthday" : "12/11/117",
            "age" : 22,
        ]
        openAppMoMo()
    }
    @objc func openAppMoMo() {
            MoMoPayment.requestToken()
        }
    @objc func NoficationCenterTokenReceived(notif: NSNotification) {
                //Token Replied - Call Payment to MoMo Server
                print("::MoMoPay Log::Received Token Replied::\(notif.object!)")
                //lblMessage.text = "RequestToken response:\n  \(notif.object as Any)"

                let response:NSMutableDictionary = notif.object! as! NSMutableDictionary
                let _reference_orderId = response["orderId"] as! String
                let _statusStr = "\(response["status"] as! String)"
                let _messageStr = "\(response["message"] as! String)"
        let dictionary : NSDictionary = [
                "anObject" : "abc",
                "abc" : "123",
                "name" : "hoang",
                "birthday" : "12/11/117",
                "age" : 22,
            ]
            resultReturn(dictionary)
    }

}



    





