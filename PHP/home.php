<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Parinata Music Services</title>
</head>
<body>
    <?php
        session_start();
        $name = $_SESSION['name'];
    ?>

    <h1>Hello, <?php echo $name; ?></h1>

    <a href="logout.php">Logout</a>
</body>
</html>