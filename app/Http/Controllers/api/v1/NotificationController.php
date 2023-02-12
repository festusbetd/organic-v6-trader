<?php

namespace App\Http\Controllers\api\v1;
use Illuminate\Mail\Mailable;

use Illuminate\Support\Facades\DB;
use App\CPU\Helpers;
use App\Model\Cart;
use App\User;
use App\Model\Product;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Str;
use function App\CPU\translate;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Config;
use App\Model\MpesaTransaction;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Mail;

use Illuminate\Support\Facades\Validator;

class NotificationController extends Controller
{
    public function get_notifications()
    {
        try {
            return response()->json(Notification::active()->orderBy('id','DESC')->get(), 200);
        } catch (\Exception $e) {
            return response()->json([], 200);
        }
    }

    public function orderConfirmationMsg(Request $request)
    {
        $celcom_confirmation = Helpers::get_business_settings("celcom_confirmation");

       if ($celcom_confirmation["status"]==1){
        $url = \Config::get("app.CELCOM_URL");
        $celcom_short_code = \Config::get("app.CELCOM_SHORT_CODE");
        $celcome_api_key = \Config::get("app.CELCOM_API_KEY");
        $celcom_pass_type = \Config::get("app.CELCOM_PASS_TYPE");

        $validator = Validator::make($request->all(), [
            "phone" => "required",
            'name' => 'required',
            'order_number' => 'required',
            "phone.required" => "The Phone Number field is required.",
            'name.required' => 'The Name field is required.',
            'order_number.required' => 'The Order Number field is required.',
        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }
        $phone = $request["phone"];
        $name = $request["name"];
        $order_number = $request["order_number"];
        $first_string_confirmation_message = ", We are glad to inform you that we have received your order ";
        $second_string_confirmation_message =",and will process it very soon.Thank you.";
        $shortcode = $request["shortcode"];

        $order_number = $request["order_number"];
        $greetings ="Dear ";
        $message = "$greetings\t" ."$name" .  "$first_string_confirmation_message\t".  "$order_number".  "$second_string_confirmation_message";

        $curl_post_data = [
            "partnerID" => "731",
            "apikey" => $celcome_api_key,
            "mobile" => $phone,
            "message" => $message,
            "shortcode" => $celcom_short_code,
            "pass_type" => $celcom_pass_type,
        ];
        $data = json_encode($curl_post_data);

        $headers = ["Content-Type: application/json"];

        $curl = curl_init($url);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_POST, 1);
        curl_setopt($curl, CURLOPT_HEADER, 0);
        //for debug only!
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);

        return curl_exec($curl);
    }else
    return response()->json(
        ["errors" => "Disabled"],
        403
    );
    }
    //for seller
    public function orderSellerConfirmationMsg(Request $request)
    {
        $celcom_confirmation = Helpers::get_business_settings("celcom_confirmation");

       if ($celcom_confirmation["status"]==1){
        $url = \Config::get("app.CELCOM_URL");
        $celcom_short_code = \Config::get("app.CELCOM_SHORT_CODE");
        $celcome_api_key = \Config::get("app.CELCOM_API_KEY");
        $celcom_pass_type = \Config::get("app.CELCOM_PASS_TYPE");

        $validator = Validator::make($request->all(), [
            "phone" => "required",
            'name' => 'required',
            'order_number' => 'required',
            "phone.required" => "The Phone Number field is required.",
            'name.required' => 'The Name field is required.',
            'order_number.required' => 'The Order Number field is required.',
        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }
        $phone = $request["phone"];
        $name = $request["name"];
        $order_number = $request["order_number"];
        $first_string_confirmation_message = ", We are glad to inform you that you have received order ";
        $second_string_confirmation_message =",kindly process it.Thank you.";
        $shortcode = $request["shortcode"];

        $order_number = $request["order_number"];
        $greetings ="Dear ";
        $message = "$greetings\t" ."$name" .  "$first_string_confirmation_message\t".  "$order_number".  "$second_string_confirmation_message";

        $curl_post_data = [
            "partnerID" => "731",
            "apikey" => $celcome_api_key,
            "mobile" => $phone,
            "message" => $message,
            "shortcode" => $celcom_short_code,
            "pass_type" => $celcom_pass_type,
        ];
        $data = json_encode($curl_post_data);

        $headers = ["Content-Type: application/json"];

        $curl = curl_init($url);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_POST, 1);
        curl_setopt($curl, CURLOPT_HEADER, 0);
        //for debug only!
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);

        return curl_exec($curl);
    }else
    return response()->json(
        ["errors" => "Disabled"],
        403
    );
}


    public function orderPendingMsg(Request $request)
    {
        $celcomPending = Helpers::get_business_settings("celcom_pending");
        if ($celcomPending["status"]==1){
        $url = \Config::get("app.CELCOM_URL");
        $celcom_short_code = \Config::get("app.CELCOM_SHORT_CODE");
        $celcome_api_key = \Config::get("app.CELCOM_API_KEY");
        $celcom_pass_type = \Config::get("app.CELCOM_PASS_TYPE");

        $validator = Validator::make($request->all(), [
            "phone" => "required",
            'name' => 'required',
            'order_number' => 'required',
            "phone.required" => "The Phone Number field is required.",
            'name.required' => 'The Name field is required.',
            'order_number.required' => 'The Order Number field is required.',
        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }
        $phone = $request["phone"];
        $name = $request["name"];
        $order_number = $request["order_number"];
        $first_string_pending_message = ",please login to your account to complete your pending order";
        $second_string_pending_message =".Thank you.";
        $shortcode = $request["shortcode"];

        $order_number = $request["order_number"];
        $greetings ="Dear ";
        $message = "$greetings\t" ."$name" .  "$first_string_pending_message\t".  "$order_number".  "$second_string_pending_message";


        $curl_post_data = [
            "partnerID" => "731",
            "apikey" => "1d0d5dc316e7731d3ad32ccec442391c",
            "mobile" => $phone,
            "message" => $message,
            "shortcode" => $celcom_short_code,
            "pass_type" => $celcom_pass_type,
        ];
        $data = json_encode($curl_post_data);
        $headers = ["Content-Type: application/json"];

        $curl = curl_init($url);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 0);
        curl_setopt($curl, CURLOPT_POST, 1);
        curl_setopt($curl, CURLOPT_HEADER, 0);
        //for debug only!
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);

        return curl_exec($curl);
    }
    else
    return response()->json(
        ["errors" => "Disabled"],
        403
    );
    }
    
    public function orderProcessingMsg(Request $request)
    {
        $celcom_ProcessingMsg = Helpers::get_business_settings("celcom_processing");
        if ($celcom_ProcessingMsg["status"]==1){
        $url = \Config::get("app.CELCOM_URL");
        $celcom_short_code = \Config::get("app.CELCOM_SHORT_CODE");
        $celcome_api_key = \Config::get("app.CELCOM_API_KEY");
        $celcom_pass_type = \Config::get("app.CELCOM_PASS_TYPE");

        $validator = Validator::make($request->all(), [
            "phone" => "required",
            'name' => 'required',
            'order_number' => 'required',
            "phone.required" => "The Phone Number field is required.",
            'name.required' => 'The Name field is required.',
            'order_number.required' => 'The Order Number field is required.',
        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }
        $phone = $request["phone"];
        $name = $request["name"];
        $order_number = $request["order_number"];
        $first_string_processing_message = ",We’re glad to inform you that your order";
        $second_string_processing_message =",is now being processed and soon will be delivered to your shipping address. Thank you.";
        $shortcode = $request["shortcode"];

        $order_number = $request["order_number"];
        $greetings ="Dear ";
        $message = "$greetings\t" ."$name" .  "$first_string_processing_message\t".  "$order_number".  "$second_string_processing_message";

        $curl_post_data = [
            "partnerID" => "731",
            "apikey" => $celcome_api_key,
            "mobile" => $phone,
            "message" => $message,
            "shortcode" => $celcom_short_code,
            "pass_type" => $celcom_pass_type,
        ];
        $data = json_encode($curl_post_data);

        $headers = ["Content-Type: application/json"];

        $curl = curl_init($url);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_POST, 1);
        curl_setopt($curl, CURLOPT_HEADER, 0);
        //for debug only!
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);

        return curl_exec($curl);
    }
    else
    return response()->json(
        ["errors" => "Disabled"],
        403
    );
    }
    public function orderDeliveryMsg(Request $request)
    {
        $celcom_DeliveryMsg = Helpers::get_business_settings("celcom_order_delivery");
        if ($celcom_DeliveryMsg["status"]==1){
        $url = \Config::get("app.CELCOM_URL");
        $celcom_short_code = \Config::get("app.CELCOM_SHORT_CODE");
        $celcome_api_key = \Config::get("app.CELCOM_API_KEY");
        $celcom_pass_type = \Config::get("app.CELCOM_PASS_TYPE");

        $validator = Validator::make($request->all(), [
            "phone" => "required",
            'name' => 'required',
            'order_number' => 'required',
            "phone.required" => "The Phone Number field is required.",
            'name.required' => 'The Name field is required.',
            'order_number.required' => 'The Order Number field is required.',
        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }
        $phone = $request["phone"];
        $name = $request["name"];
        $order_number = $request["order_number"];
        $first_string_delivery_message = ",this is to notify you that your order";
        $second_string_delivery_message =" is being shipped to the delivery location. Thank you.";
        $shortcode = $request["shortcode"];

        $order_number = $request["order_number"];
        $greetings ="Dear ";
        $message = "$greetings\t" ."$name" .  "$first_string_delivery_message\t".  "$order_number".  "$second_string_delivery_message";

        $curl_post_data = [
            "partnerID" => "731",
            "apikey" => $celcome_api_key,
            "mobile" => $phone,
            "message" => $message,
            "shortcode" => $celcom_short_code,
            "pass_type" => $celcom_pass_type,
        ];
        $data = json_encode($curl_post_data);

        $headers = ["Content-Type: application/json"];

        $curl = curl_init($url);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_POST, 1);
        curl_setopt($curl, CURLOPT_HEADER, 0);
        //for debug only!
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);

        return curl_exec($curl);
    }
    else
    return response()->json(
        ["errors" => "Disabled"],
        403
    );
    }
    public function orderDeliveredMsg(Request $request)
    {
        $celcom_DeliveredMsg = Helpers::get_business_settings("celcom_delivered");
        if ($celcom_DeliveredMsg["status"]==1){
        $url = \Config::get("app.CELCOM_URL");
        $celcom_short_code = \Config::get("app.CELCOM_SHORT_CODE");
        $celcome_api_key = \Config::get("app.CELCOM_API_KEY");
        $celcom_pass_type = \Config::get("app.CELCOM_PASS_TYPE");

        $validator = Validator::make($request->all(), [
            "phone" => "required",
            'name' => 'required',
            'order_number' => 'required',
            "phone.required" => "The Phone Number field is required.",
            'name.required' => 'The Name field is required.',
            'order_number.required' => 'The Order Number field is required.',
        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }
        $phone = $request["phone"];
        $name = $request["name"];
        $order_number = $request["order_number"];
        $first_string_delivered_message = ",your order";
        $second_string_delivered_message =" has been delivered at Today.Thank you for choosing us for your purchase.";
        $shortcode = $request["shortcode"];

        $order_number = $request["order_number"];
        $greetings ="Dear ";
        $message = "$greetings\t" ."$name" .  "$first_string_delivered_message\t".  "$order_number".  "$second_string_delivered_message";

        $curl_post_data = [
            "partnerID" => "731",
            "apikey" => $celcome_api_key,
            "mobile" => $phone,
            "message" => $message,
            "shortcode" => $celcom_short_code,
            "pass_type" => $celcom_pass_type,
        ];
        $data = json_encode($curl_post_data);

        $headers = ["Content-Type: application/json"];

        $curl = curl_init($url);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_POST, 1);
        curl_setopt($curl, CURLOPT_HEADER, 0);
        //for debug only!
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);

        return curl_exec($curl);
    }
    else
    return response()->json(
        ["errors" => "Disabled"],
        403
    );
    }
    public function orderReturenedMsg(Request $request)
    {
        $celcom_ReturenedMsg = Helpers::get_business_settings("celcom_returned");
        if ($celcom_ReturenedMsg["status"]==1){
        $url = \Config::get("app.CELCOM_URL");
        $celcom_short_code = \Config::get("app.CELCOM_SHORT_CODE");
        $celcome_api_key = \Config::get("app.CELCOM_API_KEY");
        $celcom_pass_type = \Config::get("app.CELCOM_PASS_TYPE");

        $validator = Validator::make($request->all(), [
            "phone" => "required",
            'name' => 'required',
            'order_number' => 'required',
            "phone.required" => "The Phone Number field is required.",
            'name.required' => 'The Name field is required.',
            'order_number.required' => 'The Order Number field is required.',
        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }
        $phone = $request["phone"];
        $name = $request["name"];
        $order_number = $request["order_number"];
        $first_string_returened_message = ",we have received your returned order";
        $second_string_returened_message =" Today.We hope to serve you better. Thank you.";
        $shortcode = $request["shortcode"];

        $order_number = $request["order_number"];
        $greetings ="Dear ";
        $message = "$greetings\t" ."$name" .  "$first_string_returened_message\t".  "$order_number".  "$second_string_returened_message";

        $curl_post_data = [
            "partnerID" => "731",
            "apikey" => $celcome_api_key,
            "mobile" => $phone,
            "message" => $message,
            "shortcode" => $celcom_short_code,
            "pass_type" => $celcom_pass_type,
        ];
        $data = json_encode($curl_post_data);

        $headers = ["Content-Type: application/json"];

        $curl = curl_init($url);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_POST, 1);
        curl_setopt($curl, CURLOPT_HEADER, 0);
        //for debug only!
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);

        return curl_exec($curl);
    }
    else
    return response()->json(
        ["errors" => "Disabled"],
        403
    );
    }
    public function orderFailedMsg(Request $request)
    {
        $celcom_FailedMsg = Helpers::get_business_settings("celcom_failed");
        if ($celcom_FailedMsg["status"]==1){
        $url = \Config::get("app.CELCOM_URL");
        $celcom_short_code = \Config::get("app.CELCOM_SHORT_CODE");
        $celcome_api_key = \Config::get("app.CELCOM_API_KEY");
        $celcom_pass_type = \Config::get("app.CELCOM_PASS_TYPE");
        $mpesa_short_Code = \Config::get("app.mpesa_short_Code");

        $validator = Validator::make($request->all(), [
            "phone" => "required",
            'name' => 'required',
            'order_number' => 'required',
            'amount' => 'required',
         
            "phone.required" => "The Phone Number field is required.",
            'name.required' => 'The Name field is required.',
            'order_number.required' => 'The Order Number field is required.',
            'amount.required' => 'The amount field is required.',
            'order_number.required' => 'The Order Number field is required.',
        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }
        $phone = $request["phone"];
        $name = $request["name"];
        $order_number = $request["order_number"];
        $amount = $request["amount"];
        $first_string_failed_message = ",To complete your payment,use MPESA PayBill No:";
        $second_string_failed_message =",Account No:";
        $third_string_failed_message =",Amount:";
        $fourth_string_failed_message =".Ignore this message if already paid. Thank you.";
        $shortcode = $request["shortcode"];

        $order_number = $request["order_number"];
        $greetings ="Dear ";
        $message = "$greetings\t" ."$name" .  "$first_string_failed_message".  "$mpesa_short_Code". 
         "$second_string_failed_message".  "$order_number".  " $third_string_failed_message".  "$amount".  "$fourth_string_failed_message";

        $curl_post_data = [
            "partnerID" => "731",
            "apikey" => $celcome_api_key,
            "mobile" => $phone,
            "message" => $message,
            "shortcode" => $celcom_short_code,
            "pass_type" => $celcom_pass_type,
        ];
        $data = json_encode($curl_post_data);

        $headers = ["Content-Type: application/json"];

        $curl = curl_init($url);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_POST, 1);
        curl_setopt($curl, CURLOPT_HEADER, 0);
        //for debug only!
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);

        return curl_exec($curl);
    }
    else
    return response()->json(
        ["errors" => "Disabled"],
        403
    );

    }

    public function emailPending(Request $request)
    {
        $emailPending = Helpers::get_business_settings("email_pending");
        if ($emailPending["status"]==1){
        $validator = Validator::make($request->all(), [
            "name" => "required",
            "email" => "required",
            "phone" => "required",
            "order_id" => "required",
            "product_name" => "required",
            "quantity" => "required",
            "price" => "required",
            "total_price" => "required",
            "shipping_cost" => "required",
            "status" => "required",
            "date" => "required",
            "street" => "required",
            "city" => "required",
            "code" => "required",
            "country" => "required",
        
            "name.required" => "Name field is required.",
            "email.required" => "Email field is required.",
            "phone.required" => "Phone field is required.",
            "order_id.required" => "Order Id field is required.",
            "product_name.required" => "Product Name field is required.",
            "quantity.required" => "Quantity field is required.",
            "price.required" => "Price field is required.",
            "shipping_cost.required" => "Shipping Cost field is required.",
            "total_price.required" => "total_price field is required.",
            "status.required" => "status field is required.",
            "date.required" => "date field is required.",
            "street.required" => "street field is required.",
            "city.required" => "city field is required.",
            "code.required" => "code field is required.",
            "country.required" => " field is required.",

        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }

        $name = $request["name"];
        $email = $request["email"];
        $phone = $request["phone"];
        $order_id = $request["order_id"];
        $product_name = $request["product_name"];
        $quantity = $request["quantity"];
        $price = $request["price"];
        $total_price = $request["total_price"];
        $shipping_cost = $request["shipping_cost"];
        $status = $request["status"];
        $date = $request["date"];
        $street = $request["street"];
        $city = $request["city"];
        $code = $request["code"];
        $country = $request["country"];
        $name = $request["name"];

        Mail::to($email)->send(
            new \App\Mail\OrderPending(
                $name ,
                $email,
                $phone ,
                $order_id,
                $product_name,
                $quantity ,
                $price ,
                $total_price,
                $shipping_cost,
                $status,
                $date ,
                $street,
                $city ,
                $code ,
                $country,
             
            )
        );
        return response()->json(["message" => "emailPending Sent"], 200);
    }
    else
    return response()->json(
        ["errors" => "Disabled"],
        403
    );
    }


    public function emailConfirmation(Request $request)
    {
        $emailConfirmation = Helpers::get_business_settings("email_confirmation");
        if ($emailConfirmation["status"]==1){
        $validator = Validator::make($request->all(), [
            "name" => "required",
            "email" => "required",
            "phone" => "required",
            "order_id" => "required",
            "product_name" => "required",
            "quantity" => "required",
            "price" => "required",
            "total_price" => "required",
            "shipping_cost" => "required",
            "status" => "required",
            "date" => "required",
            "street" => "required",
            "city" => "required",
            "code" => "required",
            "country" => "required",
        
            "name.required" => "Name field is required.",
            "email.required" => "Email field is required.",
            "phone.required" => "Phone field is required.",
            "order_id.required" => "Order Id field is required.",
            "product_name.required" => "Product Name field is required.",
            "quantity.required" => "Quantity field is required.",
            "price.required" => "Price field is required.",
            "total_price.required" => "total_price field is required.",
            "shipping_cost.required" => "Shipping Cost field is required.",
            "status.required" => "status field is required.",
            "date.required" => "date field is required.",
            "street.required" => "street field is required.",
            "city.required" => "city field is required.",
            "code.required" => "code field is required.",
            "country.required" => " field is required.",

        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }

        $name = $request["name"];
        $email = $request["email"];
        $phone = $request["phone"];
        $order_id = $request["order_id"];
        $product_name = $request["product_name"];
        $quantity = $request["quantity"];
        $price = $request["price"];
        $total_price = $request["total_price"];
        $shipping_cost = $request["shipping_cost"];
        $status = $request["status"];
        $date = $request["date"];
        $street = $request["street"];
        $city = $request["city"];
        $code = $request["code"];
        $country = $request["country"];
        $name = $request["name"];

        Mail::to($email)->send(
            new \App\Mail\OrderConfirmation(
                $name ,
                $email,
                $phone ,
                $order_id,
                $product_name,
                $quantity ,
                $price ,
                $total_price,
                $shipping_cost,
                $status,
                $date ,
                $street,
                $city ,
                $code ,
                $country,
             
            )
        );
        return response()->json(["message" => "emailConfirmation Sent"], 200);
    }
    else
    return response()->json(
        ["errors" => "Disabled"],
        403
    );
    }
    public function emailProcessing(Request $request)
    {
        $emailProcessing = Helpers::get_business_settings("email_confirmation");
        if ($emailProcessing["status"]==1){
        $validator = Validator::make($request->all(), [
            "name" => "required",
            "email" => "required",
            "phone" => "required",
            "order_id" => "required",
            "product_name" => "required",
            "quantity" => "required",
            "price" => "required",
            "total_price" => "required",
            "shipping_cost" => "required",
            "status" => "required",
            "date" => "required",
            "street" => "required",
            "city" => "required",
            "code" => "required",
            "country" => "required",
        
            "name.required" => "Name field is required.",
            "email.required" => "Email field is required.",
            "phone.required" => "Phone field is required.",
            "order_id.required" => "Order Id field is required.",
            "product_name.required" => "Product Name field is required.",
            "quantity.required" => "Quantity field is required.",
            "price.required" => "Price field is required.",
            "total_price.required" => "total_price field is required.",
            "shipping_cost.required" => "Shipping Cost field is required.",
            "status.required" => "status field is required.",
            "date.required" => "date field is required.",
            "street.required" => "street field is required.",
            "city.required" => "city field is required.",
            "code.required" => "code field is required.",
            "country.required" => " field is required.",

        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }

        $name = $request["name"];
        $email = $request["email"];
        $phone = $request["phone"];
        $order_id = $request["order_id"];
        $product_name = $request["product_name"];
        $quantity = $request["quantity"];
        $price = $request["price"];
        $total_price = $request["total_price"];
        $shipping_cost = $request["shipping_cost"];
        $status = $request["status"];
        $date = $request["date"];
        $street = $request["street"];
        $city = $request["city"];
        $code = $request["code"];
        $country = $request["country"];
        $name = $request["name"];

        Mail::to($email)->send(
            new \App\Mail\OrderProcessing(
                $name ,
                $email,
                $phone ,
                $order_id,
                $product_name,
                $quantity ,
                $price ,
                $total_price,
                $shipping_cost,
                $status,
                $date ,
                $street,
                $city ,
                $code ,
                $country,
             
            )
        );
        return response()->json(["message" => "emailProcessing Sent"], 200);
    }
    else
    return response()->json(
        ["errors" => "Disabled"],
        403
    ); 
    }
    public function emailOut_for_delivery(Request $request)
    {
        $emailOut_for_delivery = Helpers::get_business_settings("email_order_out_for_delivery");
        if ($emailOut_for_delivery["status"]==1){
            $validator = Validator::make($request->all(), [
                "name" => "required",
                "email" => "required",
                "phone" => "required",
                "order_id" => "required",
                "product_name" => "required",
                "quantity" => "required",
                "price" => "required",
                "total_price" => "required",
                "shipping_cost" => "required",
                "status" => "required",
                "date" => "required",
                "street" => "required",
                "city" => "required",
                "code" => "required",
                "country" => "required",
            
                "name.required" => "Name field is required.",
                "email.required" => "Email field is required.",
                "phone.required" => "Phone field is required.",
                "order_id.required" => "Order Id field is required.",
                "product_name.required" => "Product Name field is required.",
                "quantity.required" => "Quantity field is required.",
                "price.required" => "Price field is required.",
                "total_price.required" => "total_price field is required.",
                "shipping_cost.required" => "Shipping Cost field is required.",
                "status.required" => "status field is required.",
                "date.required" => "date field is required.",
                "street.required" => "street field is required.",
                "city.required" => "city field is required.",
                "code.required" => "code field is required.",
                "country.required" => " field is required.",
    
            ]);
    
            if ($validator->fails()) {
                return response()->json(
                    ["errors" => Helpers::error_processor($validator)],
                    403
                );
            }
    
            $name = $request["name"];
            $email = $request["email"];
            $phone = $request["phone"];
            $order_id = $request["order_id"];
            $product_name = $request["product_name"];
            $quantity = $request["quantity"];
            $price = $request["price"];
            $total_price = $request["total_price"];
            $shipping_cost = $request["shipping_cost"];
            $status = $request["status"];
            $date = $request["date"];
            $street = $request["street"];
            $city = $request["city"];
            $code = $request["code"];
            $country = $request["country"];
            $name = $request["name"];
    
            Mail::to($email)->send(
                new \App\Mail\Out_for_delivery(
                    $name ,
                    $email,
                    $phone ,
                    $order_id,
                    $product_name,
                    $quantity ,
                    $price ,
                    $total_price,
                    $shipping_cost,
                    $status,
                    $date ,
                    $street,
                    $city ,
                    $code ,
                    $country,
                 
                )
            );
            return response()->json(["message" => "emailOut_for_delivery Sent"], 200);
        }
        else
        return response()->json(
            ["errors" => "Disabled"],
            403
        ); 
    }
    public function emailDelivered(Request $request)
    {
        $emailDelivered = Helpers::get_business_settings("email_delivered");
        if ($emailDelivered["status"]==1){
        $validator = Validator::make($request->all(), [
            "name" => "required",
            "email" => "required",
            "phone" => "required",
            "order_id" => "required",
            "product_name" => "required",
            "quantity" => "required",
            "price" => "required",
            "total_price" => "required",
            "shipping_cost" => "required",
            "status" => "required",
            "date" => "required",
            "street" => "required",
            "city" => "required",
            "code" => "required",
            "country" => "required",
          
        
            "name.required" => "Name field is required.",
            "email.required" => "Email field is required.",
            "phone.required" => "Phone field is required.",
            "order_id.required" => "Order Id field is required.",
            "product_name.required" => "Product Name field is required.",
            "quantity.required" => "Quantity field is required.",
            "price.required" => "Price field is required.",
            "total_price.required" => "total_price field is required.",
            "shipping_cost.required" => "Shipping Cost field is required.",
            "status.required" => "status field is required.",
            "date.required" => "date field is required.",
            "street.required" => "street field is required.",
            "city.required" => "city field is required.",
            "code.required" => "code field is required.",
            "country.required" => " field is required.",

        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }

        $name = $request["name"];
        $email = $request["email"];
        $phone = $request["phone"];
        $order_id = $request["order_id"];
        $product_name = $request["product_name"];
        $quantity = $request["quantity"];
        $price = $request["price"];
        $total_price = $request["total_price"];
        $shipping_cost = $request["shipping_cost"];
        $status = $request["status"];
        $date = $request["date"];
        $street = $request["street"];
        $city = $request["city"];
        $code = $request["code"];
        $country = $request["country"];
        $name = $request["name"];

        Mail::to($email)->send(
            new \App\Mail\OrderDelivered(
                $name ,
                $email,
                $phone ,
                $order_id,
                $product_name,
                $quantity ,
                $price ,
                $total_price,
                $shipping_cost,
                $status,
                $date ,
                $street,
                $city ,
                $code ,
                $country,
             
            )
        );
        return response()->json(["message" => "emailDelivered Sent"], 200);
    }
    else
    return response()->json(
        ["errors" => "Disabled"],
        403
    );
    }
    public function emailReturned(Request $request)
    {
        $emailReturned = Helpers::get_business_settings("email_returned");
        if ($emailReturned["status"]==1){
            $validator = Validator::make($request->all(), [
                "name" => "required",
                "email" => "required",
                "phone" => "required",
                "order_id" => "required",
                "product_name" => "required",
                "quantity" => "required",
                "price" => "required",
                "total_price" => "required",
                "shipping_cost" => "required",
                "status" => "required",
                "date" => "required",
                "street" => "required",
                "city" => "required",
                "code" => "required",
                "country" => "required",
            
                "name.required" => "Name field is required.",
                "email.required" => "Email field is required.",
                "phone.required" => "Phone field is required.",
                "order_id.required" => "Order Id field is required.",
                "product_name.required" => "Product Name field is required.",
                "quantity.required" => "Quantity field is required.",
                "price.required" => "Price field is required.",
                "total_price.required" => "total_price field is required.",
                "shipping_cost.required" => "Shipping Cost field is required.",
                "status.required" => "status field is required.",
                "date.required" => "date field is required.",
                "street.required" => "street field is required.",
                "city.required" => "city field is required.",
                "code.required" => "code field is required.",
                "country.required" => " field is required.",
    
            ]);
    
            if ($validator->fails()) {
                return response()->json(
                    ["errors" => Helpers::error_processor($validator)],
                    403
                );
            }
    
            $name = $request["name"];
            $email = $request["email"];
            $phone = $request["phone"];
            $order_id = $request["order_id"];
            $product_name = $request["product_name"];
            $quantity = $request["quantity"];
            $price = $request["price"];
            $total_price = $request["total_price"];
            $shipping_cost = $request["shipping_cost"];
            $status = $request["status"];
            $date = $request["date"];
            $street = $request["street"];
            $city = $request["city"];
            $code = $request["code"];
            $country = $request["country"];
            $name = $request["name"];
    
            Mail::to($email)->send(
                new \App\Mail\OrderReturned(
                    $name ,
                    $email,
                    $phone ,
                    $order_id,
                    $product_name,
                    $quantity ,
                    $price ,
                    $total_price,
                    $shipping_cost,
                    $status,
                    $date ,
                    $street,
                    $city ,
                    $code ,
                    $country,
                 
                )
            );
            return response()->json(["message" => "emailReturned Sent"], 200);
        }
        else
        return response()->json(
            ["errors" => "Disabled"],
            403
        ); 
    }
    public function emailFailed(Request $request)
    {
        $emailFailed = Helpers::get_business_settings("email_failed");
        if ($emailFailed["status"]==1){
        $paybill = \Config::get("app.mpesa_short_Code");
        $validator = Validator::make($request->all(), [
            "name" => "required",
            "email" => "required",
            "phone" => "required",
            "order_id" => "required",
            "product_name" => "required",
            "quantity" => "required",
            "price" => "required",
            "total_price" => "required",
            "shipping_cost" => "required",
            "status" => "required",
            "date" => "required",
            "street" => "required",
            "city" => "required",
            "code" => "required",
            "country" => "required",

            "name.required" => "Name field is required.",
            "email.required" => "Email field is required.",
            "phone.required" => "Phone field is required.",
            "order_id.required" => "Order Id field is required.",
            "product_name.required" => "Product Name field is required.",
            "quantity.required" => "Quantity field is required.",
            "price.required" => "Price field is required.",
            "total_price.required" => "total_price field is required.",
            "shipping_cost.required" => "Shipping Cost field is required.",
            "status.required" => "status field is required.",
            "date.required" => "date field is required.",
            "street.required" => "street field is required.",
            "city.required" => "city field is required.",
            "code.required" => "code field is required.",
            "country.required" => " field is required.",

        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }

        $name = $request["name"];
        $email = $request["email"];
        $phone = $request["phone"];
        $order_id = $request["order_id"];
        $product_name = $request["product_name"];
        $quantity = $request["quantity"];
        $price = $request["price"];
        $total_price = $request["total_price"];
        $shipping_cost = $request["shipping_cost"];
        $status = $request["status"];
        $date = $request["date"];
        $street = $request["street"];
        $city = $request["city"];
        $code = $request["code"];
        $country = $request["country"];
        $name = $request["name"];

        Mail::to($email)->send(
            new \App\Mail\OrderFailed(
                $name ,
                $email,
                $phone ,
                $order_id,
                $paybill,
                $product_name,
                $quantity ,
                $price ,
                $total_price,
                $shipping_cost,
                $status,
                $date ,
                $street,
                $city ,
                $code ,
                $country,
             
            )
        );
        return response()->json(["message" => "emailFailed Sent"], 200);
    }
    else
    return response()->json(
        ["errors" => "Disabled"],
        403
    );

    }

    public function emailCancelled(Request $request)
    {
        $emailCancelled = Helpers::get_business_settings("email_canceled");
        if ($emailCancelled["status"]==1){
        $validator = Validator::make($request->all(), [
            "name" => "required",
            "email" => "required",
            "phone" => "required",
            "order_id" => "required",
            "product_name" => "required",
            "quantity" => "required",
            "price" => "required",
            "total_price" => "required",
            "shipping_cost" => "required",
            "status" => "required",
            "date" => "required",
            "street" => "required",
            "city" => "required",
            "code" => "required",
            "country" => "required",
        
            "name.required" => "Name field is required.",
            "email.required" => "Email field is required.",
            "phone.required" => "Phone field is required.",
            "order_id.required" => "Order Id field is required.",
            "product_name.required" => "Product Name field is required.",
            "quantity.required" => "Quantity field is required.",
            "price.required" => "Price field is required.",
            "total_price.required" => "total_price field is required.",
            "shipping_cost.required" => "Shipping Cost field is required.",
            "status.required" => "status field is required.",
            "date.required" => "date field is required.",
            "street.required" => "street field is required.",
            "city.required" => "city field is required.",
            "code.required" => "code field is required.",
            "country.required" => " field is required.",

        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }

        $name = $request["name"];
        $email = $request["email"];
        $phone = $request["phone"];
        $order_id = $request["order_id"];
        $product_name = $request["product_name"];
        $quantity = $request["quantity"];
        $price = $request["price"];
        $total_price = $request["total_price"];
        $shipping_cost = $request["shipping_cost"];
        $status = $request["status"];
        $date = $request["date"];
        $street = $request["street"];
        $city = $request["city"];
        $code = $request["code"];
        $country = $request["country"];
        $name = $request["name"];

        Mail::to($email)->send(
            new \App\Mail\OrderCancelled(
                $name ,
                $email,
                $phone ,
                $order_id,
                $product_name,
                $quantity ,
                $price ,
                $total_price,
                $shipping_cost,
                $status,
                $date ,
                $street,
                $city ,
                $code ,
                $country,
             
            )
        );
        return response()->json(["message" => "emailCancelled Sent"], 200);
    }
    else
    return response()->json(
        ["errors" => "Disabled"],
        403
    );
}
}
