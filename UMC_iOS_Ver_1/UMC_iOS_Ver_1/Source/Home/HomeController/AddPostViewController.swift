//
//  AddPostViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/15.
//

import UIKit
import Photos

class AddPostViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        tapImageView()
    }
    
    //imageView 클릭 시 실행
    func tapImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func touchToPickPhoto() {
        checkAlbumPermission()
    }
    
    //사진 갤러리 열기
    func openPhoto() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    func checkAlbumPermission(){
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
    
    func photoDeniedAlert() {
        let alert = UIAlertController(title: "Permission Denied", message: "사진 라이브러리의 사용 권한이 거부되었기 때문에 사용할 수 없습니다. 사진 라이브러리의 권한 설정을 변경하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let yesAction = UIAlertAction(title: "YES", style: .default) { action in
            self.openSettings(action: action)
        }
        let noAction = UIAlertAction(title: "NO", style: .cancel)
        alert.addAction(noAction)
        alert.addAction(yesAction)
        present(alert, animated: false)
    }
    
    private func openSettings(action: UIAlertAction) {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }
    
    //뒤로가기 버튼
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //사진 갤러리에서 사진 선택 완료 시 실행
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = image
            imageView.contentMode = .scaleToFill
        }
        dismiss(animated: true)
    }
}
