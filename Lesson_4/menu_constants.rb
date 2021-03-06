module MenuConstants

  MAIN_MENU = "
 ------------------------------------------------------------
|                Главное меню                                |
 ------------------------------------------------------------
|Для перехода в подменю поезда введите [1]                   |
|Для перехода в подменю станции введите [2]                  |
|Для перехода в подменю маршрути введите [3]                 |
|Для вывода более подробной информации введите [4]           |  
|Для выхода введите [0]                                      | 
 ------------------------------------------------------------\n   
"

  TRAINS_MENU = "
 -------------------------------------------------------
|                 Меню поезда                           |
 -------------------------------------------------------
|Для создания нового поезда введите  [1]                |
|Для для вывода всех поездов [2]                        |
|Чтоби установить маршрут введите [3]                   |  
|Чтоби вывести текущий маршрут введите [4]              |
|Для добавления или удаления вагонов введите [5]        |
|Чтоби переместить поезд введите [6]                    |
|Для для возврата в главное меню введите [0]            |
 -------------------------------------------------------\n   
"

  STATIONS_MENU = "
 -------------------------------------------------------
|                 Меню станций                          |
 -------------------------------------------------------
|Для создания новой станции введите  [1]                |
|Для для вывода всех станций [2]                        |
|Для вывода всех поездов на станции [3]                 |  
|Для для возврата в главное меню введите [0]            |
 -------------------------------------------------------\n   
"

  ROUTES_MENU = "
 -------------------------------------------------------
|                 Меню маршрутов                        |
 -------------------------------------------------------
|Для создания нового маршрута введите  [1]              |
|Для для вывода всех маршрутов [2]                      |
|Чтобы добавить или удалить станции в маршруте [3]      |  
|Для для возврата в главное меню введите [0]            |
 -------------------------------------------------------\n   
"

  HELP = "
1  - Создавать станции [2][1]
2  - Создавать поезда [1][1] 
3  - Создавать маршруты и [3][1]
   - управлять станциями в нем (добавлять, удалять) [3][3]}
4  - Назначать маршрут поезду [1][3]
5  - Добавлять вагоны к поезду [1][5][1]
6  - Отцеплять вагоны от поезда [1][5][2]
7  - Перемещать поезд по маршруту вперед и назад [1][6]
8  - Просматривать список станций и список поездов на станции 
   - Список всех станций [2][2]
   - Список всех станций в маршруте поезда [1][4]
   - Список всех поездов на станции [2][3]
"
  INVALID_INDEX = "Не существующий индекс"

end
