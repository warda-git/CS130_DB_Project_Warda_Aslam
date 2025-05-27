<?php
$pdo = new PDO("mysql:host=localhost;dbname=inventory_db", "root", "");
$table = $_GET['table'] ?? 'items';

function getRecords($pdo, $table) {
    $stmt = $pdo->query("SELECT * FROM $table");
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

$records = getRecords($pdo, $table);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inventory Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="https://via.placeholder.com/40" alt="Logo" class="me-2"> Inventory System
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link <?= $table == 'categories' ? 'active' : '' ?>" href="?table=categories">Categories</a></li>
                <li class="nav-item"><a class="nav-link <?= $table == 'products' ? 'active' : '' ?>" href="?table=products">Products</a></li>
                <li class="nav-item"><a class="nav-link <?= $table == 'suppliers' ? 'active' : '' ?>" href="?table=suppliers">Suppliers</a></li>
                <li class="nav-item"><a class="nav-link <?= $table == 'sales' ? 'active' : '' ?>" href="?table=sales">Sales</a></li>
                <li class="nav-item"><a class="nav-link <?= $table == 'items' ? 'active' : '' ?>" href="?table=items">Items</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container py-4">
    <h1 class="text-center mb-4">Inventory Management System</h1>

    <div class="d-flex justify-content-between mb-3">
        <h3><?= ucfirst($table) ?> List</h3>
        <a href="add_new.php?table=<?= $table ?>" class="btn btn-success">Add New</a>
    </div>

    <?php if ($records): ?>
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                    <tr>
                        <?php foreach (array_keys($records[0]) as $column): ?>
                            <th><?= ucfirst($column) ?></th>
                        <?php endforeach; ?>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($records as $row): ?>
                        <tr>
                            <?php foreach ($row as $cell): ?>
                                <td><?= htmlspecialchars($cell) ?></td>
                            <?php endforeach; ?>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    <?php else: ?>
        <div class="alert alert-info">No records found in <?= ucfirst($table) ?>.</div>
    <?php endif; ?>
</div>
</body>
</html>
