<?php
namespace App;
use PDO;
use PDOException;
class DB {
    private $host = 'localhost';
    private $db = 'rrvxtxsm_m3';
    private $user = 'rrvxtxsm';
    private $pass = 'Xd11gz';
    private $charset = 'utf8mb4';
    private $pdo;

    public function __construct() {
        $dsn = "mysql:host=$this->host;dbname=$this->db;charset=$this->charset";
        $options = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ];

        try {
            $this->pdo = new PDO($dsn, $this->user, $this->pass, $options);
        } catch (\PDOException $e) {
            throw new \PDOException($e->getMessage(), (int)$e->getCode());
        }
    }

    public function GetById($id, $table) {
        $stmt = $this->pdo->prepare("SELECT * FROM $table WHERE id = :id");
        $stmt->execute(['id' => $id]);
        $row = $stmt->fetch();

        if ($row) {
            $html = '<tr>';
            foreach ($row as $key => $value) {
                $html .= "<td>$value</td>";
            }
            $html .= '</tr>';
            return $html;
        } else {
            return '<tr><td colspan="2">No data found</td></tr>';
        }
    }
    public function GetByIdM($id, $table) {
        $stmt = $this->pdo->prepare("SELECT * FROM $table WHERE id = :id");
        $stmt->execute(['id' => $id]);
        $row = $stmt->fetch();

        if ($row) {
            return array_values($row);
        } else {
            return [];
        }
    }
    public function GetAll($table) {
        $stmt = $this->pdo->prepare("SELECT * FROM $table");
        $stmt->execute();
        $rows = $stmt->fetchAll();

        $result = [];
        foreach ($rows as $row) {
            $result[] = array_values($row);
        }

        return $result;
    }
    public function getTableHeaders($table) {
        $stmt = $this->pdo->prepare("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = :db AND TABLE_NAME = :table");
        $stmt->execute(['db' => $this->db, 'table' => $table]);
        $headers = $stmt->fetchAll(PDO::FETCH_COLUMN);
        return $headers;
    }
    public function getTableHeadersR() {
        // Фиксированные заголовки столбцов для вашего запроса
        $headers = [
            'Номер Заявки',
            'Статус',
            'Номер',
            'Вин номер',
            'model',
            'mark',
            'Фамилия',
            'Имя',
            'Отчество',
            'Описание проблемы',
            'Price'
        ];
    
        return $headers;
    }
    
    public function returnTable($data, $headers = []) {
        $html = '<table border="1">';

        // Добавляем заголовки таблицы
        if (!empty($headers)) {
            $html .= '<tr>';
            foreach ($headers as $header) {
                $html .= "<th>$header</th>";
            }
            $html .= '</tr>';
        }

        // Добавляем строки таблицы
        if (is_array($data) && count($data) > 0) {
            if (is_array($data[0])) {
                // Двумерный массив
                foreach ($data as $row) {
                    $html .= '<tr>';
                    foreach ($row as $cell) {
                        $html .= "<td>$cell</td>";
                    }
                    $html .= '</tr>';
                }
            } else {
                // Одномерный массив
                $html .= '<tr>';
                foreach ($data as $cell) {
                    $html .= "<td>$cell</td>";
                }
                $html .= '</tr>';
            }
        } else {
            $html .= '<tr><td colspan="' . count($headers) . '">No data found</td></tr>';
        }

        $html .= '</table>';
        return $html;
    }
    public function AddUser($lastName, $firstName, $middleName, $phoneNumber, $mail, $login, $password, $permission = 0) {
        // Хеширование пароля
        $passwordHash = password_hash($password, PASSWORD_BCRYPT);
    
        // Проверка наличия пользователя с указанными данными
        $stmt = $this->pdo->prepare("SELECT * FROM Client WHERE PhoneNumber = :phoneNumber OR mail = :mail OR login = :login");
        $stmt->execute([
            'phoneNumber' => $phoneNumber,
            'mail' => $mail,
            'login' => $login
        ]);
    
        $existingUser = $stmt->fetch();
    
        if ($existingUser) {
            // Пользователь с такими данными уже существует
            return [
                'status' => 'error',
                'message' => 'User with the provided phone number, mail, or login already exists.',
                'existingUser' => $existingUser
            ];
        }
    
        // Подготовка SQL-запроса для добавления нового пользователя
        $stmt = $this->pdo->prepare("INSERT INTO Client (LastName, FirstName, MiddleName, PhoneNumber, mail, login, Pass_hash, Permission, RegDate, LogDate) VALUES (:lastName, :firstName, :middleName, :phoneNumber, :mail, :login, :passwordHash, :permission, NOW(), NOW())");
        // Выполнение запроса
        $stmt->execute([
            'lastName' => $lastName,
            'firstName' => $firstName,
            'middleName' => $middleName,
            'phoneNumber' => $phoneNumber,
            'mail' => $mail,
            'login' => $login,
            'passwordHash' => $passwordHash,
            'permission' => $permission
        ]);
    
        return [
            'status' => 'success',
            'userId' => $this->pdo->lastInsertId()
        ];
    }
    public function GetRequests() {
    $stmt = $this->pdo->prepare("
        SELECT
            Requests.Id as 'Номер Заявки',
            Status.status as 'Статус',
            Auto.Number as 'Номер',
            Auto.VinNumber as 'Вин номер',
            Models.Model as 'model',
            Marks.Mark as 'mark',
            Client.LastName as 'Фамилия',
            Client.FirstName as 'Имя',
            Client.MiddleName as 'Отчество',
            Requests.Description as 'Описание проблемы',
            Requests.Price
        FROM Request as Requests
        INNER JOIN Auto ON Requests.AutoId = Auto.Id
        INNER JOIN Client ON Auto.Ownerld = Client.Id
        INNER JOIN Status on Requests.StatusId = Status.Id
        INNER JOIN Models ON Auto.ModelId = Models.Id
        INNER JOIN Marks ON Auto.MarkId = Marks.Id
    ");
    $stmt->execute();
    $rows = $stmt->fetchAll();

    $result = [];
    foreach ($rows as $row) {
        $result[] = array_values($row);
    }

    return $result;
}
    public function addReq($statusId, $autoId, $subDate, $endDate, $description, $price) {
        // Подготовка SQL-запроса
        $stmt = $this->pdo->prepare("INSERT INTO Request (StatusId, AutoId, SubDate, EndDate, Description, Price) VALUES (:statusId, :autoId, :subDate, :endDate, :description, :price)");

        // Выполнение запроса
        $stmt->execute([
            'statusId' => $statusId,
            'autoId' => $autoId,
            'subDate' => $subDate,
            'endDate' => $endDate,
            'description' => $description,
            'price' => $price
        ]);

        return $this->pdo->lastInsertId();
    }
    public function GetTable($requests, $headers){

    }
}

// Пример использования
//$db = new DB();



//echo $db->GetById(1, 'Client');

//print_r($db->GetByIdM(1, 'Client'));

//print_r($db->GetAll('Client')); // Выводит двумерный массив

//$db = new DB();
//$tableName = 'Client';
//$dataByIdM = $db->GetByIdM(1, $tableName);
//$dataAll = $db->GetAll($tableName);

// Получаем заголовки таблицы из базы данных
//$headers = $db->getTableHeaders($tableName);

//echo $db->returnTable($dataByIdM, $headers); // Выводит таблицу для одной строки
//echo $db->returnTable($dataAll, $headers); // Выводит таблицу для всех строк

// Добавление нового пользователя
//$newUserId = $db->AddUser('Doe', 'John', 'Middle', '1234567890', 'john.doe@example.com', 'johndoe', 'password123');
//echo "New user added with ID: $newUserId";

// Получение заявок из таблицы Request
//echo 1;
//$requests = $db->GetRequests();
//$headers = $db->getTableHeadersR();
//echo $db->returnTable($requests, $headers);

// Добавление новой заявки
//$newReqId = $db->addReq(1, 1, '2023-10-01', '2023-10-10', 'Шина бабах', 1000);
//echo "создана новая заявка с ID: $newReqId";

?>
