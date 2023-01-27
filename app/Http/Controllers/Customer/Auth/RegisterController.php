<?php

namespace App\Http\Controllers\Customer\Auth;

use App\CPU\CartManager;
use App\CPU\Helpers;
use App\CPU\SMS_module;
use App\Http\Controllers\Controller;
use App\Model\BusinessSetting;
use App\Model\PhoneOrEmailVerification;
use App\Model\Wishlist;
use App\User;
use Brian2694\Toastr\Facades\Toastr;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;
use Session;
use function App\CPU\translate;

class RegisterController extends Controller
{
    public function __construct()
    {
        $this->middleware('guest:customer', ['except' => ['logout']]);
    }

    public function register()
    {
        session()->put('keep_return_url', url()->previous());
        return view('customer-view.auth.register');
    }
    public function register_trader()
    {
        session()->put('keep_return_url', url()->previous());
        // return view('customer-view.auth.register-trader');
        return view('customer-view.auth.register');
    }
    public function submit(Request $request)
    {
        $request->validate([
            'f_name' => 'required',
            'l_name' => 'required',
            'gender' => 'required',
            'user_id' => 'required|unique:users',
            'email' => 'required|email|unique:users',
            'phone' => 'unique:users',
            'county' => 'required',
            'user_industry' => 'required',
            'password' => 'required|min:6|same:con_password'
        ], [
            'f_name.required' => 'First name is required',
            'l_name.required' => 'Last name is required',
            'gender.required' => 'Gender is required',
            'user_id.required' => 'National ID is required',
            'email.required' => 'Email is required',
            'phone.required' => 'Phone is required',
            'county.required' => 'County is required',
            'user_industry.required' => 'Industry is required',
    ]);
 
    $user = User::create([
        'f_name' => $request['f_name'],
        'l_name' => $request['l_name'],
        'gender' => $request['gender'],
        'user_id' => $request['user_id'],
        'email' => $request['email'],
        'phone' => $request['phone'],
        'other_phone_number' => $request['other_phone_number'],
        'dob' => $request['dob'],
        'marital_status' => $request['marital_status'],
        'kra_pin' => $request['kra_pin'],
        'physical_address' => $request['physical_address'],
        'user_type_category' => 'Trader',
        'user_type_name' => $request['user_type_name'],
        'business_location' => $request['business_location'],
        'business_name' => $request['business_name'],
        'county' => $request['county'],
        'user_industry' => $request['user_industry'],
        'other_phone_number' => $request['other_phone_number'],
        'is_active' => 1,
        'password' => bcrypt($request['password'])
    ]);

        $phone_verification = Helpers::get_business_settings('phone_verification');
        $email_verification = Helpers::get_business_settings('email_verification');
        if ($phone_verification && !$user->is_phone_verified) {
            return redirect(route('customer.auth.check', [$user->id]));
        }
        if ($email_verification && !$user->is_email_verified) {
            return redirect(route('customer.auth.check', [$user->id]));
        }

        Toastr::success(translate('registration_success_login_now'));
        return redirect(route('customer.auth.login'));
    }

    public static function check($id)
    {
        $user = User::find($id);

        $token = rand(1000, 9999);
        DB::table('phone_or_email_verifications')->insert([
            'phone_or_email' => $user->email,
            'token' => $token,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $phone_verification = Helpers::get_business_settings('phone_verification');
        $email_verification = Helpers::get_business_settings('email_verification');
        $fname=$user->f_name;
        if ($phone_verification && !$user->is_phone_verified) {
            SMS_module::send($user->phone, $token);
            
            $response = translate('please_check_your_SMS_for_OTP');
            Toastr::success($response);
        }
        if ($email_verification && !$user->is_email_verified) {
            try {
                Mail::to($user->email)->send(new \App\Mail\EmailVerification($token, $fname));
                $response = translate('check_your_email');
                Toastr::success($response);
            } catch (\Exception $exception) {
                $response = translate('email_failed');
                Toastr::error($response);
            }
        }
        Toastr::success($response);
        return view('customer-view.auth.verify', compact('user'));
    }

    public static function verify(Request $request)
    {
        Validator::make($request->all(), [
            'token' => 'required',
        ]);

        $email_status = BusinessSetting::where('type', 'email_verification')->first()->value;
        $phone_status = BusinessSetting::where('type', 'phone_verification')->first()->value;

        $user = User::find($request->id);
        $verify = PhoneOrEmailVerification::where(['phone_or_email' => $user->email, 'token' => $request['token']])->first();

        if ($email_status == 1 || ($email_status == 0 && $phone_status == 0)) {
            if (isset($verify)) {
                try {
                    $user->is_email_verified = 1;
                    $user->save();
                    $verify->delete();
                } catch (\Exception $exception) {
                    Toastr::info('Try again');
                }

                Toastr::success(translate('verification_done_successfully'));

            } else {
                Toastr::error(translate('Verification_code_or_OTP mismatched'));
                return redirect()->back();
            }

        } else {
            if (isset($verify)) {
                try {
                    $user->is_phone_verified = 1;
                    $user->save();
                    $verify->delete();
                } catch (\Exception $exception) {
                    Toastr::info('Try again');
                }

                Toastr::success('Verification Successfully Done');
            } else {
                Toastr::error('Verification code/ OTP mismatched');
            }

        }

        return redirect(route('customer.auth.login'));
    }

    public static function login_process($user, $email, $password)
    {
        if (auth('customer')->attempt(['email' => $email, 'password' => $password], true)) {
            session()->put('wish_list', Wishlist::where('customer_id', $user->id)->pluck('product_id')->toArray());
            $company_name = BusinessSetting::where('type', 'company_name')->first();
            $message = 'Welcome to ' . $company_name->value . '!';
            CartManager::cart_to_db();
        } else {
            $message = 'Credentials are not matched or your account is not active!';
        }

        return $message;
    }

}