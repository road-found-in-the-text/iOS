//
//  AddPostViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/15.
//

import UIKit
import Photos
import AVFoundation

class AddPostViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    var distinctionImage: Int?  //이미지가 메인사진이냐 게시글 사진이냐를 구별, 0이면 메인사진, 1이면 게시글 사진, 2면 카메라로 찍은 사진
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        tapImageView()
    }
    
    //imageView 클릭 시 실행
    func tapImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addTopImage))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    //메인 사진 추가
    @objc func addTopImage() {
        distinctionImage = 0
        checkAlbumPermission()
    }
    
    //게시글에 사진 추가
    func addContentImage() {
        distinctionImage = 1
        checkAlbumPermission()
    }
    
    //게시글에 카메라로 찍은 사진 추가
    func addContentImageByCamera() {
        distinctionImage = 2
        checkCameraPermission()
    }
    
    //사진 갤러리 열기 및 이미지 자르기
    func openPhoto() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    //카메라 열기
    func openCamera() {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    //사진 접근 권한
    func checkAlbumPermission() {
        PHPhotoLibrary.requestAuthorization( { status in
            switch status{
            case .authorized:
                print("Album: 권한 허용")
                DispatchQueue.main.async {
                    self.openPhoto()
                }
            case .denied:
                print("Album: 권한 거부")
                DispatchQueue.main.async {
                    self.photoDeniedAlert()
                }
            case .limited:
                print("Album: 권한 제한")
            case .restricted, .notDetermined:
                print("Album: 선택하지 않음")
            default:
                break
            }
        })
    }
    
    //카메라 접근 권한
    func checkCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { status in
            if status {
                DispatchQueue.main.async {
                    self.openCamera()
                }
            } else {
                DispatchQueue.main.async {
                    self.photoDeniedAlert()
                }
            }
        }
    }
    
    //사진 접근 거부 됐을 때 alert창 띄우기
    func photoDeniedAlert() {
        let sourceType: String?
        if distinctionImage == 0 || distinctionImage == 1 {
            sourceType = "사진 라이브러리"
        } else {
            sourceType = "카메라"
        }
        let alert = UIAlertController(title: "Permission Denied", message: "\(sourceType!)의 사용 권한이 거부되었기 때문에 사용할 수 없습니다. \(sourceType!)의 권한 설정을 변경하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let yesAction = UIAlertAction(title: "YES", style: .default) { action in
            self.openSettings(action: action)
        }
        let noAction = UIAlertAction(title: "NO", style: .cancel)
        alert.addAction(noAction)
        alert.addAction(yesAction)
        present(alert, animated: true)
    }
    
    //환경설정 화면으로 이동
    private func openSettings(action: UIAlertAction) {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }
    
    //post content에 사진 추가하는 alert 기능
    func addImageAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
            self.addContentImageByCamera()
        }
        let imageAction = UIAlertAction(title: "Image", style: .default) { action in
            self.addContentImage()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cameraAction)
        alert.addAction(imageAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    //뒤로가기 버튼
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func addImageToScriptBtnTapped(_ sender: UIBarButtonItem) {
        addImageAlert()
    }
}

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //사진 갤러리에서 사진 선택 완료 시 실행
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            switch distinctionImage {
            case 0:
                imageView.image = image
                imageView.contentMode = .scaleToFill
            case 1:
                print("hi")
            case 2:
                print("hello")
            default:
                return
            }
        }
        dismiss(animated: true)
    }
}
