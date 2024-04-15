//
//  CameraViewController.swift

//
//  Created by Ananaya on 01/04/24.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    //Capture Session
    var session : AVCaptureSession?
    //Photo Session
    let output = AVCapturePhotoOutput()
    //Video Preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    //Shutter button
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x:0 , y:0 , width :100, height : 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.magenta.cgColor
        return button
    }()
    
    var eventName: String?
       var selectedFriends: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        checkCameraPermissions()
        setupNavigationBar()
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    }
    private func checkCameraPermissions(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
            
        case .notDetermined:
            //request
            AVCaptureDevice.requestAccess(for: .video){
                [weak self] granted in
                guard granted else{
                    return
                }
                DispatchQueue.main.async{
                    self?.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 150)
    }
  func setupNavigationBar() {
           let endEventButton = UIBarButtonItem(title: "End Event", style: .plain, target: self, action: #selector(endEvent))
      navigationItem.rightBarButtonItem = endEventButton

          let infoButton = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showEventInfo))
         navigationItem.leftBarButtonItem = infoButton
       }
    private func setUpCamera(){
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video){
            do{
                let input = try AVCaptureDeviceInput(device : device)
                if session.canAddInput(input){
                    session.addInput(input)
                }
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                session.startRunning()
                self.session = session
            }
            catch{
                print(error)
            }
        }
        
    }
    
    @objc private func didTapTakePhoto(){
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        
    }
}
extension CameraViewController:AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo :  AVCapturePhoto , error : Error?) {
        guard let data = photo.fileDataRepresentation() else{
            return
        }
        let image = UIImage(data: data)
        
        session?.stopRunning()
        let imageView = UIImageView(image : image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }
    @objc func endEvent() {
        let alert = UIAlertController(title: "End Event", message: "Are you sure you want to end \(eventName ?? "the event")?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "End", style: .destructive, handler: { _ in
            self.handleEndEvent()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func handleEndEvent() {
        // Implement logic for ending the event here
        print("Event ended.")
    }
    
    @objc func showEventInfo() {
        if let eventName = eventName {
            let message = "Event Name: \(eventName)\n\nFriends:\n\(selectedFriends.joined(separator: "\n"))"
            let alert = UIAlertController(title: "Event Information", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Event Information", message: "No event data available.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
