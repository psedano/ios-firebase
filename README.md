#ios-firebase


#Inicio del proyecto con Cocoapods

Al crear un proyecto nuevo, es necesario cerrar XCode, ir a la terminal en el folder de la aplicación y realizar pod init (Si es necesario, realizar gem install cocoapods para instalar Cocoapods). "pod init" genera el archivo Podfile, en ese archivo se debe de indicar los pods que queramos usar, en este caso:

```swift
pod 'Firebase/Auth'
pod 'Firebase/Core'
pod 'Firebase/Database'
pod 'Firebase/Crash'
pod 'CryptoSwift'
pod 'Alamofire'
```

Al guardar nuestro archivo, podemos usar "pod install" o "pod update" en caso de querer usar las últimas versiones de los Pods.

#Estructura del proyecto en XCode

Contiene los siguientes grupos:

##H2 Frameworks
Contiene los Frameworks externos que no se incluyen en el Podfile. En este caso FBSDKCoreKit.framework y FBSDKLoginKit.framework.

##H2 Util
**Constants.swift:** Contiene los valores constantes usados por toda la app.

##H2 Services
Contiene la referencia (FIRDatabase.database().reference()) para conectarse a Firebase. Esta referencia se toma del GoogleService-Info.plist en la variable DATABASE_URI.

##H2 Resources
Contiene los recursos que se usan para la app, en este caso solamente se tienen las fuentes para la tipografía "San Francisco".

##H2 Controller
Contiene los controladores de la app, en este caso:

* ViewController
* EmailViewController
* MainViewController
* DetailViewController
* PopoverViewController

##H2 View
Contiene todos los archivos de las Custom Views de la app, en este caso estan divididas en las vistas generales y las específicas de las tablas:

* CommentTableView
* CommentTableViewCell
* PlaceTableViewCell
* MaterialViewInsideCell
* ImagePlace

* LoginBackground
* PlaceImage
* MaterialButton
* SwipeSegue
* NavBar
* MaterialTextField
* InfoView

##H2 Model
Contiene los modelos de datos de la app, en este caso:

* Place
* Comment

El archivo GoogleService-Info.plist se genera al entrar al sitio de Firebase y crear un nuevo proyecto para iOS.
