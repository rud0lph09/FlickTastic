## FlickTastic

FlickTastick es una app en la que puedes ver que peliculas son las mas populares, las mejor calificadas y las proximas a estrenarse.

Aprende detalles de tus peliculas favoritas, ve clips y mas.





### Capas:

Arch Pattern: MVVM

Modelo: La definicion basica de las abstracciones del listado de peliculas y sus caracterizticas

Clases: MovieModel, MovieListServiceResponseModel, MovieClipModel, MovieClipsServiceResponseModel, MovieServiceErrorModel

Repositorios: Los repositorios se encargan del manejo de los modelos y su actualizacion

Clases: Repository, MovieListRepository, MovieListRepositoryDelegate, MovieClipsRepository: MovieClipsRepositoryDelegate

Modelos de vista: Contienen toda la informacion a ser presentada al usuario

Clases: MovieListViewModel, MovieDetailsViewModel

Vista: El usuario interactua con ellas y los modelos de vista le dicen que presentar a la vista.

Clases: MovieDetailsViewController, MovieListViewController

Reponsabilidades:

Modelos: Contener información.
Repositorio: Entregar Información
ViewModel: Contener los modelos y mas informacion sobre la vista. Decirle a la Vista que de esa informacion presentar
Views: Manejar interacciones y avisar al ViewModel de sucesos para que el ViewModel determine si debe modificar algo


Principio de Responsabilidad Unica:
Cada clase/modulo debe tener una sola responsabilidad sobre el feature desarrollado

Un buen codigo, es reutilizable, mantenible y mejorable.






