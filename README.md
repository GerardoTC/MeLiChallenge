# MeLiChallenge

**Software utilizado:**
Versión de Xcode  11.6

# Arquitectura:
![VIPER Arch](https://koenig-media.raywenderlich.com/uploads/2020/02/viper.png)
El proyecto fue construido para seguir los lineamientos de la arquitectura **VIPER** el cual es un acrónimo para:

**View**: se encarga de recibir acciones e interacciones por parte del usuario y notifica al Presenter para tomar decisiones sobre estas, muestra la interfaz de usuario con la que interactúa el usuario.

**Interactor:** es un componente que realiza el manejo de la información, esta  puede ser buscada o encontrada remota y/o localmente, usualmente se maneja las reglas de negocio en este componente, el interactor es controlado mediante el presenter.

**Presenter**: Es quien controla gran parte de los componentes, traduce la información entregada por el interactor para tomar decisiones sobre la vista o el en rutamiento (Router) a otra vista.
**Entity:** representa la abstracción de los data objects usados dentro de la aplicación
**Router:** Hace el manejo del enrutamiento/navegación entre las pantallas de la aplicación

# Estructura del proyecto:

El Proyecto cuenta 6 carpetas principales las cuales están organizadas de la siguiente manera:

**LocalStorage:** aqui se definen managers que van a usar información local como por ejemplo User Defaults o CoreData

**Utils:** aqui se definen utilidades comunes dentro de la aplicación como por ejemplo vistas o componentes que pueden ser reusados 

**Constants:** Aqui se definen todas las constantes comunes del proyecto como textos, identificadores, constantes del networking

**Extensions:** Aqui se definen las extensiones a clases propias del sistema para agregar funcionalidades extras a las clases ya existentes

**Networking:** Aqui se maneja la capa de conexión de la aplicación a internet la cual manejará los diferentes clientes API que pueda tener la aplicación

**Sections:** en esta carpeta se encuentran cada uno de los viper para cada vista.



# Gestor de dependencias

Para el proyecto se uso el gestor de dependencias Cocoa pods en su versión 1.9.1



# Dependencias usadas:

- **Kingfisher** para carga de imágenes en su versión 5.15
