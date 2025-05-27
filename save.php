<?php
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = $_POST['item_name'];
    $category = $_POST['item_category'];
    $quantity = $_POST['quantity'];

    $sql = "INSERT INTO items (item_name, item_category, quantity) VALUES ('$name', '$category', '$quantity')";
    $result = mysqli_query($conn, $sql);

    if ($result) {
        header("Location: index.php?table=items");
        exit;
    } else {
        echo "Error: " . mysqli_error($conn);
    }
}
?>
