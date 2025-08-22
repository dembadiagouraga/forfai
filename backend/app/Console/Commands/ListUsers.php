<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;

class ListUsers extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'users:list {--limit=50 : Number of users to display}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'List latest users with basic columns';

    /**
     * Execute the console command.
     */
    public function handle(): int
    {
        $limit = (int) $this->option('limit');
        if ($limit <= 0) {
            $limit = 50;
        }

        $users = User::select('id','uuid','firstname','lastname','email','phone','active','created_at')
            ->orderBy('id','desc')
            ->limit($limit)
            ->get();

        if ($users->isEmpty()) {
            $this->info('No users found.');
            return self::SUCCESS;
        }

        $rows = $users->map(function ($u) {
            return [
                $u->id,
                (string)$u->uuid,
                trim(($u->firstname ?? '').' '.($u->lastname ?? '')),
                (string)($u->email ?? ''),
                (string)($u->phone ?? ''),
                $u->active ? 'true' : 'false',
                (string)$u->created_at,
            ];
        })->toArray();

        $this->table([
            'ID','UUID','Name','Email','Phone','Active','Created At'
        ], $rows);

        return self::SUCCESS;
    }
}
