<?php

namespace App\Http\Controllers\Admin;

use App\CPU\Helpers;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class EmailModuleController extends Controller
{
    public function email_index()
    {
        return view('admin-views.business-settings.mail.index');
    }

    public function email_update(Request $request, $module)
    {
    
        if ($module == 'email_pending') {
            DB::table('business_settings')->updateOrInsert(['type' => 'email_pending'], [
                'type' => 'email_pending',
                'value' => json_encode([
                    'status' => $request['status'],
                    'api_key' => $request['api_key'],
                ]),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
            
        } 
        elseif ($module == 'email_confirmation') {
            DB::table('business_settings')->updateOrInsert(['type' => 'email_confirmation'], [
                'type' => 'email_confirmation',
                'value' => json_encode([
                    'status' => $request['status'],
                    'api_key' => $request['api_key'],
                ]),
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            
        } 
   
        elseif ($module == 'email_processing') {
            DB::table('business_settings')->updateOrInsert(['type' => 'email_processing'], [
                'type' => 'email_processing',
                'value' => json_encode([
                    'status' => $request['status'],
                    'api_key' => $request['api_key'],
                ]),
                'created_at' => now(),
                'updated_at' => now(),
            ]); 
        } 
        elseif ($module == 'email_order_out_for_delivery') {
            DB::table('business_settings')->updateOrInsert(['type' => 'email_order_out_for_delivery'], [
                'type' => 'email_order_out_for_delivery',
                'value' => json_encode([
                    'status' => $request['status'],
                    'api_key' => $request['api_key'],
                ]),
                'created_at' => now(),
                'updated_at' => now(),
            ]); 
        } 
        elseif ($module == 'email_delivered') {
            DB::table('business_settings')->updateOrInsert(['type' => 'email_delivered'], [
                'type' => 'email_delivered',
                'value' => json_encode([
                    'status' => $request['status'],
                    'api_key' => $request['api_key'],
                ]),
                'created_at' => now(),
                'updated_at' => now(),
            ]); 
        } 
  
        elseif ($module == 'email_returned') {
            DB::table('business_settings')->updateOrInsert(['type' => 'celcom_returned'], [
                'type' => 'email_returned',
                'value' => json_encode([
                    'status' => $request['status'],
                    'api_key' => $request['api_key'],
                ]),
                'created_at' => now(),
                'updated_at' => now(),
            ]); 
        } 
        elseif ($module == 'email_failed') {
            DB::table('business_settings')->updateOrInsert(['type' => 'email_failed'], [
                'type' => 'email_failed',
                'value' => json_encode([
                    'status' => $request['status'],
                    'api_key' => $request['api_key'],
                ]),
                'created_at' => now(),
                'updated_at' => now(),
            ]); 
        } 
    
         elseif ($module == 'email_canceled') {
            DB::table('business_settings')->updateOrInsert(['type' => 'email_canceled'], [
                'type' => 'email_canceled',
                'value' => json_encode([
                    'status' => $request['status'],
                    'api_key' => $request['api_key'],
                    'from' => $request['from'],
                    'otp_template' => $request['otp_template']
                ]),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        if ($request['status'] == 1) {
            $config = Helpers::get_business_settings('twilio_sms');
            if (isset($config) && $module != 'twilio_sms') {
                DB::table('business_settings')->updateOrInsert(['type' => 'twilio_sms'], [
                    'type' => 'twilio_sms',
                    'value' => json_encode([
                        'status' => 0,
                        'sid' => $config['sid'],
                        'token' => $config['token'],
                        'from' => $config['from'],
                        'otp_template' => $config['otp_template'],
                    ]),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }

            $config = Helpers::get_business_settings('nexmo_sms');
            if (isset($config) && $module != 'nexmo_sms') {
                DB::table('business_settings')->updateOrInsert(['type' => 'nexmo_sms'], [
                    'type' => 'nexmo_sms',
                    'value' => json_encode([
                        'status' => 0,
                        'api_key' => $config['api_key'],
                        'api_secret' => $config['api_secret'],
                        'signature_secret' => '',
                        'private_key' => '',
                        'application_id' => '',
                        'from' => $config['from'],
                        'otp_template' => $config['otp_template']
                    ]),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }

            $config = Helpers::get_business_settings('2factor_sms');
            if (isset($config) && $module != '2factor_sms') {
                DB::table('business_settings')->updateOrInsert(['type' => '2factor_sms'], [
                    'type' => '2factor_sms',
                    'value' => json_encode([
                        'status' => 0,
                        'api_key' => $config['api_key'],
                    ]),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }

            $config = Helpers::get_business_settings('msg91_sms');
            if (isset($config) && $module != 'msg91_sms') {
                DB::table('business_settings')->updateOrInsert(['type' => 'msg91_sms'], [
                    'type' => 'msg91_sms',
                    'value' => json_encode([
                        'status' => 0,
                        'template_id' => $config['template_id'],
                        'authkey' => $config['authkey'],
                    ]),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }

            $config = Helpers::get_business_settings('releans_sms');
            if (isset($config) && $module != 'releans_sms') {
                DB::table('business_settings')->updateOrInsert(['type' => 'releans_sms'], [
                    'type' => 'releans_sms',
                    'value' => json_encode([
                        'status' => 0,
                        'api_key' => $request['api_key'],
                        'from' => $request['from'],
                        'otp_template' => $request['otp_template']
                    ]),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }

        return back();
    }
}
