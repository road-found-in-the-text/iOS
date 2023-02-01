//
//  AddPostViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/15.
//

import UIKit

class AddPostViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        tapImageView()
    }
    
<<<<<<< HEAD
    //imageView 클릭 시 실행
=======
>>>>>>> parent of a7db6f8 (init: 초기 업로드)
    func tapImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func touchToPickPhoto() {
        openPhoto()
<<<<<<< HEAD
    }
    
    //사진 갤러리 열기
=======
        print("HI")
    }
    
>>>>>>> parent of a7db6f8 (init: 초기 업로드)
    func openPhoto() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
<<<<<<< HEAD
    //뒤로가기 버튼
=======
>>>>>>> parent of a7db6f8 (init: 초기 업로드)
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
<<<<<<< HEAD
    //사진 갤러리에서 사진 선택 완료 시 실행
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
=======
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
>>>>>>> parent of a7db6f8 (init: 초기 업로드)
            imageView.image = image
            imageView.contentMode = .scaleToFill
        }
        dismiss(animated: true)
    }
}
