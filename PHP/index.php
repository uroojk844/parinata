<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
    <?php
        include_once("config.php");
        session_start();
        if(isset($_SESSION['email'])){
            header("Location: home.php"); 
        }

        if(isset($_POST['submit'])){
            $email = $_POST['email'];
            $password = md5($_POST['password']);
            $sql = "SELECT `email`,`name`,`pass` FROM `users` WHERE `email` = '$email' and `pass` = '$password'";
            $res = mysqli_query($conn, $sql);

            if(mysqli_num_rows($res)){
                $row = mysqli_fetch_assoc($res);
                $_SESSION['email'] = $row['email']; 
                $_SESSION['name'] = $row['name'];
                header("Location: home.php"); 
            }
        }
    
    ?>

    <main class="row">
        <section class="h-full welcome">
            <div class="jumbo-text">Welcome to <br> Parinata Music Services</div>
        </section>
        <section class="h-full form-container">
            <form class="form" method="post">
                <div class="heading">Create an account</div>
                <input type="email" name="email" placeholder="Email" required>
                <input type="password" name="password" placeholder="Password" required>
                <button name="submit">Login</button>
                <a href="register.php">New here? Create an account</a>
            </form>
        </section>
    </main>
</body>
</html>