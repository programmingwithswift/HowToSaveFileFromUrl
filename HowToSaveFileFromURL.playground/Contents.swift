import UIKit

// I am assuming that the first element of urls exists, this is a dangerous way to do it
let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask)[0]
let imageName = documentDirectory.appendingPathComponent("myImage.png")

let urlString = "https://raw.githubusercontent.com/programmingwithswift/HowToSaveFileFromUrl/master/testFile.png"

// 1
if let imageUrl = URL(string: urlString) {
    // 2
    URLSession.shared.downloadTask(with: imageUrl) { (tempFileUrl, response, error) in
        
        // 3
        if let imageTempFileUrl = tempFileUrl {
            do {
                // Write to file
                let imageData = try Data(contentsOf: imageTempFileUrl)
                try imageData.write(to: imageName)
                
                checkSavedImage()
            } catch {
                print("Error")
            }
        }
    }.resume()
}

func checkSavedImage() {
    do {
        let savedImageData = try Data(contentsOf: imageName)
        
        if let savedImage = UIImage(data: savedImageData) {
            savedImage
        }
    } catch {
        print("Cannot read saved")
    }
}
