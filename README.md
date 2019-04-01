# flutter_app_products

![Codigo Alpha Flutter]
![alt text](https://github.com/codigoalphacol/FlutterFirebaseCRUD/blob/master/assets/images/crudfirebase.png) 

<p align="center"> <img src="https://github.com/codigoalphacol/FlutterFirebaseCRUD/blob/master/assets/images/producto1.jpg" width="300"/> <img src="https://github.com/codigoalphacol/FlutterFirebaseCRUD/blob/master/assets/images/producto2.jpg" width="300"/>
<img src="https://github.com/codigoalphacol/FlutterFirebaseCRUD/blob/master/assets/images/producto3.jpg" width="300"/> </p> 
Note:
check
//steps for implement imagen
in the Storage rules
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write;
    }
  }
}

verify in Database realtime Database up link image
ProductImage: "https://firebasestorage.googleapis.com/v0/b/fl...
see line 195 file product_screen.dart change for each project

Creacion de un CRUD DE Productos, podemos hacer todas las cinco funciones del crud como son
crear productos, listar, editar o actualizar, eliminar,

Todo el codigo explicado, incluyendo consola Firebase 

Marzo 2/2019 - Actualizamos  el boton de eliminar, con una AlertDialog, 
que nos pregunte si estamos seguros de eliminar el registro

los inivitamos para que se suscriban en el canal de Youtube Codigo Alpha

https://www.youtube.com/watch?v=uzkpDEG_4R4

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
