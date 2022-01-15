<?php
class Adatbazis
{
    private $host    = "localhost";
    private $user    = "root";
    private $pass    = "";
    private $db_name = "access_levels";
    private $conn;

    /*
        php-ban magic method a konstruktor
    */
    public function __construct()
    {
        $this->kapcsolodas();
    }

    private function kapcsolodas()
    {
        $this->conn = new mysqli($this->host, $this->user, $this->pass, $this->db_name);
        $this->conn->set_charset("utf8");
        if ($this->conn->connect_error) {
            die($this->conn->connect_error);
        } else{
            //echo "Sikeres kapcsolódás";
        }
    }

    public function vevo_regisztracio($nev, $password, $cim)
    {
        $sql = "INSERT INTO `vevo`(`vnev`, `password`, `vcim`) VALUES (?,?,?)";
        try {
            $stmt = $this->conn->prepare($sql);
            $pass = password_hash($password, PASSWORD_DEFAULT);

            $stmt->bind_param("sss", $nev, $pass, $cim);
            if($stmt->execute()){
                return true;
            } else {
                return false;
            }
        } catch (Exception $exc) {
            echo $exc->getTraceAsString();
        }
    }
    public function reset() {
        $sql = "UPDATE `vevo` SET `password`='".password_hash('1234', PASSWORD_DEFAULT)."' "; 
        if ($this->conn->query($sql) === TRUE) {
            echo "Record updated successfully";
        } else {
            echo "Error updating record: " . $conn->error;
        }
    }
    public function user_check($nev, $password)
    {
        $sql = 'SELECT `vazon` as id,`vnev` as username,`role_name`,`role_mask`, `password` FROM `users` WHERE `vnev`=?';
        try {
            $stmt = $this->conn->prepare($sql);
            $stmt->bind_param("s", $nev);
            
            if($stmt->execute()){
                $result = $stmt->get_result()->fetch_assoc();
                if($stmt->affected_rows == 1 && password_verify($password, $result['password'])){
                    //-- eredményes a lekérdezés
                    $_SESSION['login'] = true;
                    unset($result['password']);
                    $_SESSION['user'] = $result; // fetch data
                    return true;
                } else {
                    return false;
                }
            } else {
                //-- valami nagyon nem stimmel
                return false;
            }
        } catch (Exception $exc) {
            echo $exc->getTraceAsString();
        }



        
    }

    public function regisztraltak_lekerdezese()
    {
        $sql = "SELECT * FROM `regisztraltak`";
        $result = $this->conn->query($sql);
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    /*
        Destruktor, akkor fut le amikor a php futása befejeződik és létrejön a végleges html dokumentum.
    */
    public function __destruct()
    {
        $this->conn->close();
        //echo "Destruct";
    }

}
