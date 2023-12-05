<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create an account</title>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
    <?php
        include_once("config.php");
        if(isset($_POST['submit'])) {
            $name = $_POST['name'];
            $email = $_POST['email'];
            $mobile = $_POST['mobile'];
            $adress = $_POST['address'];
            $pass = md5($_POST['password']);
            $sql = "INSERT INTO `users`(`name`, `mobile`, `email`, `pass`, `address`) values('$name','$mobile','$email','$pass', '$adress');";
            if(mysqli_query($conn, $sql)){
                header("location: index.php");
            }
        }
    ?>

    <main class="row">
        <section class="h-full welcome">
            <div class="jumbo-text">Welcome to <br> Parinata Music Services</div>
        </section>
        <section class="h-full form-container">
            <form class="form" method="post">
                <div class="heading">Login to continue</div>
                <input type="text" name="name" placeholder="Name" required>
                <input type="email" name="email" placeholder="Email" required>
                <input type="tel" name="mobile" placeholder="Mobile number" required>
                <textarea rows="3" type="text" name="address" placeholder="Address" required></textarea>
                <input type="password" name="password" placeholder="Password" required>
                <input type="password" name="password" placeholder="Confirm password" required>
                <button name="submit">Create account</button>
                <a href="index.php">Already have an account? Login</a>
            </form>
        </section>
    </main>
</body>
</html>