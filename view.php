<?php
include 'db.php';

$result = mysqli_query($conn, "SELECT * FROM items");
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inventory List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body class="bg-light">

<div class="container py-5">
    <h2 class="text-center mb-4">Inventory List</h2>

    <table class="table table-bordered shadow">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Item Name</th>
                <th>Category</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($row = mysqli_fetch_assoc($result)) { ?>
                <tr>
                    <td><?= $row['id'] ?></td>
                    <td><?= $row['item_name'] ?></td>
                    <td><?= $row['item_category'] ?></td>
                    <td><?= $row['quantity'] ?></td>
                </tr>
            <?php } ?>
        </tbody>
    </table>

    <div class="text-center mt-4">
        <a href="index.php" class="btn btn-primary">Go Back</a>
    </div>
</div>

</body>
</html>
