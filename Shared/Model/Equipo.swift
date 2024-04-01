import Foundation
import SwiftUI

class Equipo : ObservableObject{
    var id: String
    private var nombre: String
    private var escudo: Image?
    private var urlEscudo: String?
    private var jugadores: [Jugador]?
    private var partidos: [Partido]?
    private var colores: [Int]?
    
    init() {
        self.id = ""
        self.nombre = ""
    }
    
    init(nombre: String, jugadores: [Jugador]?, partidos: [Partido]?) {
        self.id = ""
        self.nombre = nombre
        self.jugadores = jugadores
        self.partidos = partidos
    }
    
    init(id: String, nombre: String, urlEscudo: String?, jugadores: [Jugador]?, partidos: [Partido]?, colores: [Int]?) {
        self.id = id
        self.nombre = nombre
        self.urlEscudo = urlEscudo
        self.jugadores = jugadores
        self.partidos = partidos
        self.colores = colores
    }
    
    init?(data: [String: Any]) {
        guard let nombre = data["nombre"] as? String,
              let id = data["id"] as? String
        else {
            return nil
        }
        
        self.nombre = nombre
        self.id = id
        self.urlEscudo = data["urlEscudo"] as? String
        self.partidos = data["partidos"] as? [Partido]
        self.colores = data["colores"] as? [Int]
        
        guard let jugadoresData = data["jugadores"] as? [[String: Any]] else {
                return nil
            }

        var jugadoresArray: [Jugador] = []
        for jugadorData in jugadoresData {
            if let jugador = Jugador(data: jugadorData) {
                jugadoresArray.append(jugador)
            }
        }
        self.jugadores = jugadoresArray
        
       
        /*if let urlString = urlEscudo {
            loadImage(from: urlString)
        }*/
    }
    
    
    
    func loadImage(from urlString: String, completion: @escaping () -> Void) {
        if let imageUI = loadImageFromFile(filename: urlString) {
            escudo = Image(uiImage: imageUI)
            print("Escudo cargado exitosamente")
            completion()
        } else {
            if escudo == nil{
                guard let url = URL(string: urlString) else {
                    completion()
                    return
                }
                
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url),
                       let uiImage = UIImage(data: data)?.resize(withSize: CGSize(width: 30, height: 30)) {
                        DispatchQueue.main.async {
                            self.escudo = Image(uiImage: uiImage)
                            let uiImage: UIImage = self.escudo.asUIImage()
                            self.saveImageToFile(image: uiImage, filename: urlString)
                        }
                    }
                    completion()
                }
            }
        }
    }
    
    func saveImageToFile(image: UIImage, filename: String) {
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(filename)
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                try? imageData.write(to: fileURL)
            }
        }
    }
    
    
    func loadImageFromFile(filename: String) -> UIImage? {
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(filename)
            if let imageData = try? Data(contentsOf: fileURL) {
                return UIImage(data: imageData)
            }
        }
        return nil
    }
    
    
    
    func getNombre() -> String {
        return nombre
    }
    
    func setNombre(nombre: String) {
        self.nombre = nombre
    }
    
    func getEscudo() -> Image {
        return escudo ?? Image(systemName: "shield.fill")
    }
    
    func setEscudo(escudo: Image) {
        self.escudo = escudo
    }
    
    func getJugadores() -> [Jugador]? {
        return jugadores
    }
    
    func getPartidos() -> [Partido]? {
        return partidos
    }
    
    func setJugadores(jugadores: [Jugador]?) {
        self.jugadores = jugadores
    }
    
    func setPartidos(partidos: [Partido]?) {
        self.partidos = partidos
    }
    
    func addJugador(jugador: Jugador) {
        if jugadores == nil {
            jugadores = []
        }
        jugadores?.append(jugador)
    }
    
    func addPartido(partido: Partido) {
        if partidos == nil {
            partidos = []
        }
        partidos?.append(partido)
    }
    
    func getId() -> String? {
        return id
    }
    
    func setId(id: String) {
        self.id = id
    }
    
    func getUrlEscudo() -> String? {
        return urlEscudo
    }
    
    func setUrlEscudo(urlEscudo: String?) {
        self.urlEscudo = urlEscudo
    }
    
    func buscarJugadorPorId(id: String) -> Jugador? {
        return jugadores?.first(where: { $0.getId() == id })
    }
    
    func getColores() -> [Int]? {
        return colores
    }
    
    func setColores(colores: [Int]?) {
        self.colores = colores
    }
}

extension UIImage {
    func resize(withSize newSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}

extension View {
// This function changes our View to UIView, then calls another function
// to convert the newly-made UIView to a UIImage.
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
 // Set the background to be transparent incase the image is a PNG, WebP or (Static) GIF
        controller.view.backgroundColor = .clear
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
// here is the call to the function that converts UIView to UIImage: `.asUIImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
