<?php
$projectName = $_ENV['PROJECT_NAME'] ?? 'Test Project';
$useSharedDb = $_ENV['USE_SHARED_DB'] ?? 'false';

echo "<h1>🚀 {$projectName}</h1>";
echo "<p>Multi-Project Docker Architecture</p>";
echo "<p><strong>Shared DB:</strong> " . ($useSharedDb === 'true' ? '✅ Yes' : '❌ No') . "</p>";
echo "<p><strong>PHP Version:</strong> " . phpversion() . "</p>";

// Тест подключения к БД
try {
    $dbHost = $_ENV['DB_HOST'] ?? 'localhost';
    $dbName = $_ENV['DB_NAME'] ?? 'test';
    $dbUser = $_ENV['DB_USER'] ?? 'root';
    $dbPass = $_ENV['DB_PASSWORD'] ?? '';

    $pdo = new PDO("mysql:host={$dbHost};dbname={$dbName}", $dbUser, $dbPass);
    echo "<p style='color:green'>✅ Database connected: {$dbHost}</p>";
} catch (Exception $e) {
    echo "<p style='color:red'>❌ Database error: " . $e->getMessage() . "</p>";
}
?>
