<?php
// scripts/list_users.php

// Boot Laravel
require __DIR__ . '/../vendor/autoload.php';
$app = require __DIR__ . '/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\User;

// Fetch latest 50 users with selected columns
$users = User::select('id','uuid','firstname','lastname','email','phone','active','created_at')
    ->orderBy('id','desc')
    ->limit(50)
    ->get();

// Print as a simple table
$header = [
    'id','uuid','name','email','phone','active','created_at'
];

printf("%5s | %-36s | %-30s | %-30s | %-15s | %-6s | %-20s\n",
    $header[0],$header[1],$header[2],$header[3],$header[4],$header[5],$header[6]
);
print str_repeat('-', 160) . "\n";

foreach ($users as $u) {
    $name = trim(($u->firstname ?? '') . ' ' . ($u->lastname ?? ''));
    printf("%5d | %-36s | %-30s | %-30s | %-15s | %-6s | %-20s\n",
        $u->id,
        (string)$u->uuid,
        $name,
        (string)($u->email ?? ''),
        (string)($u->phone ?? ''),
        ($u->active ? 'true' : 'false'),
        (string)$u->created_at
    );
}

// Also output JSON (optional)
// echo $users->toJson(JSON_PRETTY_PRINT), PHP_EOL;
