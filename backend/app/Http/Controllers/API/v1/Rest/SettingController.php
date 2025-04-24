<?php
declare(strict_types=1);

namespace App\Http\Controllers\API\v1\Rest;

use Throwable;
use App\Models\Language;
use App\Models\Referral;
use App\Models\Settings;
use App\Helpers\FilePaths;
use App\Models\Translation;
use App\Traits\ApiResponse;
use App\Models\EmailSetting;
use App\Helpers\ResponseError;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Cache;
use App\Http\Resources\ReferralResource;
use Illuminate\Support\Facades\Log;

class SettingController extends Controller
{
    use ApiResponse;

    public function settingsInfo(): JsonResponse
    {
        $settings = Settings::where('key', '!=', 'show_ads')->get()->toArray();
        $settings[] = [
            'id' => time(),
            'key' => 'show_ads',
            'value' => FilePaths::adsExists() ? "1" : "0",
            'created_at' => date('Y-m-d H:i:s'),
            'updated_at' => date('Y-m-d H:i:s'),
        ];

        return $this->successResponse(__('errors.' . ResponseError::NO_ERROR, locale: $this->language), array_values($settings));
    }

    public function referral(): JsonResponse
    {
        $active = Settings::where('key', 'referral_active')->first();

        if (!data_get($active, 'value')) {
            return $this->onErrorResponse([
                'code' => ResponseError::ERROR_404
            ]);
        }

        $locale = Language::where('default', 1)->first()?->locale;

        $referral = Referral::with([
            'translation' => fn($query) => $query
                ->where('locale', $this->language),
            'translations',
            'galleries',
        ])
            ->where('expired_at', '>=', now())
            ->first();

        if (empty($referral)) {
            return $this->onErrorResponse(['code' => ResponseError::ERROR_404]);
        }

        return $this->successResponse(
            __('errors.' . ResponseError::NO_ERROR, locale: $this->language),
            ReferralResource::make($referral)
        );
    }

    public function translationsPaginate(): JsonResponse
    {
        $lang = $this->language;
        
        // First try to get translations for the requested language
        $translations = Cache::remember("language-$lang", 86400, function () use ($lang) {
            return Translation::where('locale', $lang)
                ->where('status', 1)
                ->pluck('value', 'key');
        });
        
        // If no translations found, fallback to default language (usually English)
        if ($translations->isEmpty()) {
            $defaultLang = Language::where('default', 1)->first()?->locale ?? 'en';
            
            $translations = Cache::remember("language-$defaultLang", 86400, function () use ($defaultLang) {
                return Translation::where('locale', $defaultLang)
                    ->where('status', 1)
                    ->pluck('value', 'key');
            });
            
            // Log the fallback
            Log::info("No translations found for $lang, falling back to $defaultLang");
        }
        
        // Log translation counts for debugging
        Log::debug("Returned " . $translations->count() . " translations for language: $lang");

        return $this->successResponse(
            __('errors.' . ResponseError::NO_ERROR, locale: $this->language),
            $translations->all()
        );
    }

    /**
     * @return JsonResponse
     */
    public function systemInformation(): JsonResponse
    {
        // get MySql version from DataBase
        $mysql    = DB::selectOne( DB::raw('SHOW VARIABLES LIKE "%innodb_version%"'));
        $error    = '';
        $errors   = '';
        $node     = '';
        $npm      = '';
        $composer = '';

        try {

            $node     = exec('node -v');
            $npm      = exec('npm -v');
            $composer = exec('composer -V');
            $composer = exec('composer -V');

            try {

                foreach (EmailSetting::get() as $item) {

                    $ch = curl_init("$item->host:$item->port");

                    curl_exec($ch);

                    if (!curl_errno($ch)) {

                        $errors .= match ($http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE)) {
                            200     => "$item->host:$item->port",
                            default => "Error code HTTP: $http_code. ",
                        };

                    }

                    curl_close($ch);
                }
            } catch (Throwable $e) {
                $errors = $e->getMessage();
            }

        } catch (Throwable) {
            $error = 'can`t run php command exec';
        }

        return $this->successResponse('success', [
            'PHP Version'      => phpversion(),
            'Laravel Version'  => app()->version(),
            'OS Version'       => php_uname(),
            'MySql Version'    => $mysql->Value,
            'NodeJs Version'   => $node,
            'NPM Version'      => $npm,
            'Project Version'  => env('PROJECT_V'),
            'Composer Version' => $composer,
            'error'            => $error,
            'mail errors'      => $errors,
        ]);
    }

    /**
     * @return JsonResponse
     */
    public function stat(): JsonResponse
    {
        $users = DB::table('users')
            ->select(['id'])
            ->count('id');

        $orders = DB::table('orders')
            ->select(['id', 'status'])
            ->count('id');

        return $this->successResponse(__('errors.' . ResponseError::NO_ERROR, locale: $this->language), [
            'users'  => $users,
            'orders' => $orders
        ]);
    }

    /**
     * @return JsonResponse
     */
    public function projectVersion(): JsonResponse
    {
        return $this->successResponse(__('errors.' . ResponseError::NO_ERROR, locale: $this->language), [
            'version' => env('PROJECT_V')
        ]);
    }

    /**
     * @return JsonResponse
     */
    public function timeZone(): JsonResponse
    {
        return $this->successResponse(__('errors.' . ResponseError::NO_ERROR, locale: $this->language), [
            'timeZone' => config('app.timezone'),
            'time'     => date('Y-m-d H:i:s')
        ]);
    }
}
