<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class ShowAdminCredentials extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'admin:credentials';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Show admin credentials';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $admin = DB::table('users')
            ->where('email', 'admin@example.com')
            ->select('email', 'id')
            ->first();

        if ($admin) {
            $this->info('Admin Email: ' . $admin->email);
            $this->info('Admin ID: ' . $admin->id);
            $this->info('Default Password: githubit');
        } else {
            $this->error('No admin user found');
        }

        return 0;
    }
}
