<?php
$projectName = getenv('PROJECT_NAME') ?: 'Тестовый проект';

echo "<h1>🚀 {$projectName}</h1>";
echo "<p><strong>Версия PHP:</strong> " . phpversion() . "</p>";

// Тест подключения к БД
try {
    $dbHost = getenv('DB_HOST');
    $dbName = getenv('DB_NAME');
    $dbUser = getenv('DB_USER');
    $dbPass = getenv('DB_PASSWORD');

    $pdo = new PDO("mysql:host={$dbHost};dbname={$dbName}", $dbUser, $dbPass);
    echo "<p style='color:green'>✅ База данных подключена: {$dbHost}</p>";
} catch (Exception $e) {
    echo "<p style='color:red'>❌ Ошибка базы данных: " . $e->getMessage() . "</p>";
}
?>
