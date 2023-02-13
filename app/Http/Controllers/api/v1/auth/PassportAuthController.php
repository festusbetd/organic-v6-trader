<?php

namespace App\Http\Controllers\api\v1\auth;
use Illuminate\Mail\Mailable;

use Illuminate\Support\Facades\DB;
use App\CPU\Helpers;
use App\Model\Cart;
use App\User;
use App\Model\Order;
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

class PassportAuthController extends Controller
{
    public function register(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                "f_name" => "required",
                "l_name" => "required",
                "gender" => "required",
                "user_id" => "required|unique:users",
                "email" => "required|unique:users",
                'phone' => 'required|min:10|max:10:unique:users',
                "county" => "required",
                // "user_industry" => "required",
                "password" => "required|min:6",
            ],

            [
                "f_name.required" => "The first name field is required.",
                "l_name.required" => "The last name field is required.",
                "gender.required" => "The gender field is required.",
                "county.required" => "The county field is required.",
                // "industry.required" => "The industry field is required.",
            ]
        );

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }
        $temporary_token = Str::random(40);
        $user_phone = \Str::replaceFirst('0', '254', $request->phone);
        $user = User::create([
            "f_name" => $request->f_name,
            "l_name" => $request->l_name,
            "gender" => $request["gender"],
            "user_id" => $request["user_id"],
            "email" => $request->email,
            "phone" => $user_phone ,
            "county" => $request["county"],
            "user_industry" => $request["user_industry"],
            "is_active" => 1,
            "user_type_category" => "Customer",
            "password" => bcrypt($request->password),
            "temporary_token" => $temporary_token,
        ]);

        $phone_verification = Helpers::get_business_settings(
            "phone_verification"
        );
        $email_verification = Helpers::get_business_settings(
            "email_verification"
        );
        if ($phone_verification && !$user->is_phone_verified) {
            return response()->json(
                ["temporary_token" => $temporary_token],
                200
            );
        }
        if ($email_verification && !$user->is_email_verified) {
            return response()->json(
                ["temporary_token" => $temporary_token],
                200
            );
        }

        $token = $user->createToken("LaravelAuthApp")->accessToken;
        return response()->json(["token" => $token], 200);
    }
    public function registerTrader(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                "f_name" => "required",
                "l_name" => "required",
                "gender" => "required",
                "user_id" => "required|unique:users",
                "dob" => "required",
                "marital_status" => "required",
                "kra_pin" => "required|unique:users",
                "user_type" => "required",
                "user_type_name" => "required",
                "land_size" => "required",
                "organic_land_size" => "required",
                "email" => "required|unique:users",
                "phone" => "required|unique:users",
                "other_phone_number" => "required|unique:users",
                "county" => "required",
                "user_industry" => "required",
                "password" => "required|min:6",
            ],
            [
                "f_name.required" => "The first name field is required.",
                "l_name.required" => "The last name field is required.",
                "gender.required" => "The gender field is required.",
                "county.required" => "The county field is required.",
                "other_phone_number.required" =>
                    "The other phone number is required.",
                "dob.required" => "The DOB is required.",
                "marital_status.required" => "The marital_status is required.",
                "kra_pin.required" => "The kra_pin is required.",
                "user_type.required" => "The user_type is required.",
                "user_type_name.required" => "The user_type_name is required.",
                "land_size.required" => "The land_size is required.",
                "organic_land_size.required" =>
                    "The organic_land_size is required.",
                "industry.required" => "The industry field is required.",
            ]
        );

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }
        $temporary_token = Str::random(40);

        $user = User::create([
            "f_name" => $request->f_name,
            "l_name" => $request->l_name,
            "gender" => $request["gender"],
            "user_id" => $request["user_id"],
            "dob" => $request["dob"],
            "marital_status" => $request["marital_status"],
            "kra_pin" => $request["kra_pin"],
            "user_type" => $request["user_type"],
            "user_type_name" => $request["user_type_name"],
            "land_size" => $request["land_size"],
            "organic_land_size" => $request["organic_land_size"],
            "email" => $request->email,
            "phone" => $request->phone,
            "other_phone_number" => $request["other_phone_number"],
            "county" => $request["county"],
            "user_industry" => $request["user_industry"],
            "is_active" => 0,
            "user_type_category" => "Trader",
            "password" => bcrypt($request->password),
            "temporary_token" => $temporary_token,
        ]);

        $phone_verification = Helpers::get_business_settings(
            "phone_verification"
        );
        $email_verification = Helpers::get_business_settings(
            "email_verification"
        );
        if ($phone_verification && !$user->is_phone_verified) {
            return response()->json(
                ["temporary_token" => $temporary_token],
                200
            );
        }
        if ($email_verification && !$user->is_email_verified) {
            return response()->json(
                ["temporary_token" => $temporary_token],
                200
            );
        }

        $token = $user->createToken("LaravelAuthApp")->accessToken;
        return response()->json(
            ["token" => "Setails Shared to be Approved"],
            200
        );
    }

    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "email" => "required",
            "password" => "required|min:6",
        ]);

        if ($validator->fails()) {
            return response()->json(
                ["errors" => Helpers::error_processor($validator)],
                403
            );
        }

        $user_id = $request["email"];
        if (filter_var($user_id, FILTER_VALIDATE_EMAIL)) {
            $medium = "email";
        } else {
            $count = strlen(preg_replace("/[^\d]/", "", $user_id));
            if ($count >= 9 && $count <= 15) {
                $medium = "phone";
            } else {
                $errors = [];
                array_push($errors, [
                    "code" => "email",
                    "message" => "Invalid email address or phone number",
                ]);
                return response()->json(
                    [
                        "errors" => $errors,
                    ],
                    403
                );
            }
        }

        $data = [
            $medium => $user_id,
            "password" => $request->password,
        ];

        $user = User::where([$medium => $user_id])->first();

        if (isset($user) && $user->is_active && auth()->attempt($data)) {
            $user->temporary_token = Str::random(40);
            $user->save();

            $phone_verification = Helpers::get_business_settings(
                "phone_verification"
            );
            $email_verification = Helpers::get_business_settings(
                "email_verification"
            );
            if ($phone_verification && !$user->is_phone_verified) {
                return response()->json(
                    ["temporary_token" => $user->temporary_token],
                    200
                );
            }
            if ($email_verification && !$user->is_email_verified) {
                return response()->json(
                    ["temporary_token" => $user->temporary_token],
                    200
                );
            }

            $token = auth()
                ->user()
                ->createToken("LaravelAuthApp")->accessToken;
            return response()->json(["token" => $token], 200);
        } else {
            $errors = [];
            array_push($errors, [
                "code" => "auth-001",
                "message" => translate(
                    "Customer_not_found_or_Account_has_been_suspended"
                ),
            ]);
            return response()->json(
                [
                    "errors" => $errors,
                ],
                401
            );
        }
    }

  

    public function index()
    {
        try
        {
            return response()->json(MpesaPaymentController::active()
                ->orderBy('id', 'DESC')
                ->get() , 200);
        }
        catch(\Exception $e)
        {
            return response()->json([], 200);
        }
    }

    public function getTimestamp()
    {
        $timestamp = Carbon::rawParse("now")->format("YmdHms");

        return $timestamp;
    }

    /**
     *Generation of password for managing Stk push
     *
     */
    public function lipaNaMpesaPassword()
    {
        $timestamp = Carbon::rawParse("now")->format("YmdHms");
        $passKey = \Config::get("app.mpesa_pass_key");
        $businessShortCode = \Config::get("app.mpesa_business_shortcode");
        $mpesaPassword = base64_encode($businessShortCode . $passKey . $timestamp);

        return $mpesaPassword;

        // return response()->json(
        //     [
        //         "Success" => 200,
        //         "Password" => $mpesaPassword,
        //     ],
        //     201
        // );
        
    }

    public function generateAccessToken()
    {
        $consumer_key = \Config::get("app.mpesa_consumer_key");
        $consumer_secret = \Config::get("app.mpesa_consumer_secret");
        $credentials = base64_encode($consumer_key . ":" . $consumer_secret);
        $url = \Config::get("app.mpesa_access_token");

        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_HTTPHEADER, ["Authorization: Basic " . $credentials, "Content-Type:application/json", ]);
        curl_setopt($curl, CURLOPT_HEADER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        $curl_response = curl_exec($curl);
        $access_token = json_decode($curl_response);
        curl_close($curl);

        return $access_token->access_token;
    }

    public function processSTKPushRequestCallback(Request $request)
    {
        $response = file_get_contents("php://input");

        //    $result = DB::Table('mpesa_transactions')->select('AccountReference')->where('TransID','ws_CO_260120220000471260')->get();
        //    $curl = html_entity_decode($result);
        //    $myArray = json_decode($curl, true);
        //    $myArray[0]['AccountReference'];
        // $response ='{
        //     "Body":
        //     {
        //         "stkCallback":
        //         {
        //             "MerchantRequestID": "21605-295434-4",
        //             "CheckoutRequestID": "ws_CO_04112017184930742",
        //             "ResultCode": 0,
        //             "ResultDesc": "The service request is processed successfully.",
        //             "CallbackMetadata":
        //             {
        //                 "Item":
        //                 [
        //                     {
        //                         "Name": "Amount",
        //                         "Value": 1
        //                     },
        //                     {
        //                         "Name": "MpesaReceiptNumber",
        //                         "Value": "LK451H35OP"
        //                     },
        //                     {
        //                         "Name": "Balance"
        //                     },
        //                     {
        //                         "Name": "TransactionDate",
        //                         "Value": 20171104184944
        //                     },
        //                     {
        //                         "Name": "PhoneNumber",
        //                         "Value": 254727894083
        //                     }
        //                 ]
        //             }
        //         }
        //     }
        // }';
        //     $response ='{
        //     "Body":
        //     {
        //         "stkCallback":
        //         {
        //             "MerchantRequestID": "21605-295434-4",
        //             "CheckoutRequestID": "ws_CO_04112017184930742",
        //             "ResultCode": 0,
        //             "ResultDesc": "The service request is processed successfully.",
        //             "CallbackMetadata":
        //             {
        //                 "Item":
        //                 [
        //                     {
        //                         "Name": "Amount",
        //                         "Value": 1
        //                     },
        //                     {
        //                         "Name": "MpesaReceiptNumber",
        //                         "Value": "LK451H35OP"
        //                     },
        //                     {
        //                         "Name": "TransactionDate",
        //                         "Value": 20171104184944
        //                     },
        //                     {
        //                         "Name": "PhoneNumber",
        //                         "Value": 254727894083
        //                     }
        //                 ]
        //             }
        //         }
        //     }
        // }';
        // A cancelled request
        //  $response='{
        //     "Body":{
        //       "stkCallback":{
        //         "MerchantRequestID":"8555-67195-1",
        //         "CheckoutRequestID":"ws_CO_22062022233534884722229862",
        //         "ResultCode":1032,
        //         "ResultDesc":"[STK_CB - ]Request cancelled by user"
        //       }
        //     }
        //   }';


     
        // $response ='{
        //     "Body": {
        //         "stkCallback": {
        //             "MerchantRequestID": "16050-28571640-1",
        //             "CheckoutRequestID": "ws_CO_280220221719027872",
        //             "ResultCode": 2001,
        //             "ResultDesc": "The initiator information is invalid."
        //         }
        //     }
        // }';
        $object = json_decode($response, true);
        // $object = $response;
        $stkCallback = $object["Body"]["stkCallback"];

        $resultCode = $stkCallback["ResultCode"];
        $resultDesc = $stkCallback["ResultDesc"];
        $merchantRequestID = $stkCallback["MerchantRequestID"];
        $checkoutRequestID = $stkCallback["CheckoutRequestID"];

     

        //return $resultCode;
        if ($resultCode == 0)
        {
            $checkMetadata = $stkCallback["CallbackMetadata"];
            $CallbackMetadata = $stkCallback["CallbackMetadata"]["Item"];

            if (count(reset($checkMetadata)) == 5)
            {

                $amount = $CallbackMetadata[0]["Value"];
                $mpesaReceiptNumber = $CallbackMetadata[1]["Value"];
                $transactionDate = $CallbackMetadata[3]["Value"];
                $phoneNumber = $CallbackMetadata[4]["Value"];

                \DB::table("mpesa_transactions")->where("TransID", $checkoutRequestID)->limit(1)
                    ->update(["TransactionType" => "", "TransTime" => $transactionDate, "TransAmount" => $amount, "BusinessShortCode" => "174379", "BillRefNumber" => $mpesaReceiptNumber, "InvoiceNumber" => "", "resultCode" => $resultCode, "resultDesc" => $resultDesc, "OrgAccountBalance" => "", "MSISDN" => $phoneNumber, "FirstName" => "", "MiddleName" => "", "LastName" => "", ]);

                $result = DB::Table("mpesa_transactions")->select("AccountReference")
                    ->where("TransID", $checkoutRequestID)->get();
                $curl = html_entity_decode($result);
                $myArray = json_decode($curl, true);
                $order_id = $myArray[0]["AccountReference"];

                \DB::table("orders")->where("order_cart_id", $order_id)->limit(1)
                    ->update(["payment_status" => "paid", "order_status" => "confirmed", ]);

                return response()
                    ->json(["Success" => "Mpesa transaction has been added", ], 201);
            }
            if (count(reset($checkMetadata)) == 4)
            {
                $amount = $CallbackMetadata[0]["Value"];
                $mpesaReceiptNumber = $CallbackMetadata[1]["Value"];
                $transactionDate = $CallbackMetadata[2]["Value"];
                $phoneNumber = $CallbackMetadata[3]["Value"];

                \DB::table("mpesa_transactions")->where("TransID", $checkoutRequestID)->limit(1)
                    ->update(["TransactionType" => "", "TransTime" => $transactionDate, "TransAmount" => $amount, "BusinessShortCode" => "174379", "BillRefNumber" => $mpesaReceiptNumber, "InvoiceNumber" => "", "resultCode" => $resultCode, "resultDesc" => $resultDesc, "OrgAccountBalance" => "", "MSISDN" => $phoneNumber, "FirstName" => "", "MiddleName" => "", "LastName" => "", ]);

                $result = DB::Table("mpesa_transactions")->select("AccountReference")
                    ->where("TransID", $checkoutRequestID)->get();
                $curl = html_entity_decode($result);
                $myArray = json_decode($curl, true);
                $order_id = $myArray[0]["AccountReference"];

                \DB::table("orders")->where("order_cart_id", $order_id)->limit(1)
                    ->update(["payment_status" => "paid", "order_status" => "confirmed", ]);
                return response()
                    ->json(["Success" => "Mpesa transaction has been added", ], 201);
            }
            else
            {
                $app_url = \Config::get("app.app_url");
                $failed_url = $app_url . "/api/v1/notifications/order_failed_msg";

                DB::table("mpesa_logs")->insert(["TransID" => $checkoutRequestID, "merchantRequestID" => $merchantRequestID, "resultCode" => $resultCode, "resultDesc" => $resultDesc, "log" => $response, ]);
                echo json_encode("payment unsuccessful");
            }
        }
        if ($resultCode == 1032)
        {
            // return $checkoutRequestID;
            \DB::table("mpesa_transactions")->where("TransID", $checkoutRequestID)->limit(1)
            ->update([
                "TransactionType" => "Pay Bill", 
              "resultCode" => $resultCode,
               "resultDesc" => $resultDesc,]);

               return response()
                    ->json(["Message" => "Request cancelled by user",
                            "data" =>$stkCallback ], 201);

        }

        else
        {
            \DB::table("mpesa_transactions")->where("TransID", $checkoutRequestID)->limit(1)
                ->update(["BusinessShortCode" => config("app.short_Code") , "resultCode" => $resultCode, "resultDesc" => $resultDesc, ]);

            return response()->json(["Error" => "$resultDesc", ], 201);
        }
        Mail::to($user->email)
            ->send(new \App\Mail\OrderPlaced($order_id, $value));
    }









    public function confirmation(Request $request)
    {
        $app_url = \Config::get("app.app_url");

        $email_confirmation_url =$app_url . "/api/v1/notifications/email_confirmation";
       
        $msg_confirmation_url =$app_url . "/api/v1/notifications/order_confirmation_msg";

        $sms_mode = Helpers::get_business_settings("sms_mode");

        // return  $msg_confirmation_url;

        $content = trim(file_get_contents("php://input"));

        // $content ='{
        //     "TransactionType": "Pay Bill",
        //     "TransID": "RAF3GJES8N",
        //     "TransTime": "20230115185614",
        //     "TransAmount": "2.00",
        //     "BusinessShortCode": "4095279",
        //     "BillRefNumber": "100024",
        //     "InvoiceNumber": "",
        //     "OrgAccountBalance": "162.00",
        //     "ThirdPartyTransID": "",
        //     "MSISDN": "2547 ***** 862",
        //     "FirstName": "FESTUS"
        // }';


        \DB::table("mpesa_logs")->insert(["resultDesc"=>"confirmation","log" => $content, ]);
   

        \DB::table("mpesa_logs")->insert(["resultDesc"=>"validation","log" => $content, ]);
        //Receive the RAW post data.
    
        //Attempt to decode the incoming RAW post data from JSON.
        $data = json_decode($content, true);

        //If json_decode failed, the JSON is invalid.
        if (!is_array($data))
        {
            echo 'Received content contained invalid JSON!';
        }

        //Process the JSON.
        $data = (array)$data; // cast (convert) the object to an array
        //print_r($data);

        $callbackData=json_decode($content);


        $TransactionType=$callbackData->TransactionType;
        $TransID=$callbackData->TransID;
        $TransTime=$callbackData->TransTime;
        $TransAmount=$callbackData->TransAmount;
        $businessShortCode=$callbackData->BusinessShortCode;
        $BusinessShortCode=$callbackData->BillRefNumber;
        $BillRefNumber=$callbackData->BillRefNumber;
        $InvoiceNumber=$callbackData->InvoiceNumber;
        $OrgAccountBalance=$callbackData->OrgAccountBalance;
        $ThirdPartyTransID=$callbackData->ThirdPartyTransID;
        $MSISDN=$callbackData->MSISDN;
        $FirstName=$callbackData->FirstName;
        // $MiddleName=$callbackData->MiddleName;
        // $LastName =$callbackData->LastName;
     
        $TransactionType = $data['TransactionType'];
        $TransID = $data['TransID'];
        $TransTime = $data['TransTime'];
        $TransAmount = $data['TransAmount'];
        $BusinessShortCode = $data['BusinessShortCode'];
        $BillRefNumber = $data['BillRefNumber'];
        $InvoiceNumber = $data['InvoiceNumber'];
        $OrgAccountBalance = $data['OrgAccountBalance'];
        $ThirdPartyTransID = $data['ThirdPartyTransID'];
        $MSISDN = $data['MSISDN'];
        $FirstName = $data['FirstName'];
        // $MiddleName = $data['MiddleName'];
        // $LastName = $data['LastName'];

        $response = array();
        //send back the below response to accept transaction
        $response["ResultCode"] = 0;
        $response["ResultDesc"] = "Confirmed";

       DB::table("mpesa_transactions")->insert([
                "TransactionType" => $TransactionType,
                "TransID" => $TransID,
                "ThirdPartyTransID"=> $ThirdPartyTransID,
                "TransTime" => $TransTime, 
                "TransAmount" => $TransAmount,
                "BusinessShortCode" => $BusinessShortCode,
                "BillRefNumber" => $BillRefNumber, 
                "InvoiceNumber" => $InvoiceNumber, 
                "resultCode" => $response["ResultCode"], 
                "resultDesc" => $response["ResultDesc"],
                "OrgAccountBalance" => $OrgAccountBalance,
                "MSISDN" => $MSISDN,
                "FirstName" => $FirstName, 
                "MiddleName" => '', 
                "LastName" =>'' ,
                "response" => "confirmation" ,
                 ]
            );

            \DB::table("orders")->where("id", $BillRefNumber)
            ->update(["payment_status" => "paid", "order_status" => "confirmed","transaction_ref"=>$TransID ]);

    
            $ord =$BillRefNumber;
            $value = "Confirmed";
            $order_ids = $BillRefNumber;
            $orders_raw = DB::table('orders')
            ->where("id",$BillRefNumber)
            ->limit(1)
            ->get(); 
            $orders = json_decode( $orders_raw, true);
            // return $orders[0];

            $email=$orders[0]["customer_email_address"];
            $value = "Confirmed";
            $phone=$orders[0]["customer_phone_number"];
            $order_ids=$BillRefNumber;
            $order_amount =$orders[0]["order_amount"]; 
            $product_total_cost =$orders[0]["product_total_cost"];
          
            $shipping_cost=$orders[0]["shipping_cost"];
            $order_collection_date = $orders[0]["order_collection_date"];
            $shipping_address_data =  DB::table('orders')
                ->where("id",$BillRefNumber)
                ->select("shipping_address_data")
                ->value("shipping_address_data");


            $myArray_shipping = json_decode( $shipping_address_data, true);
            
            // return $myArray_shipping;
            $f_name= $myArray_shipping["contact_person_name"];
            $address = $myArray_shipping["address"];
            $city = $myArray_shipping["city"];
            $zip = $myArray_shipping["zip"];
            $country = $myArray_shipping["country"];
          

            $product_details_data =  DB::table('order_details')
            ->where("order_id",$BillRefNumber)
            ->select("product_details")
            ->value("product_details");

            $product_details = json_decode( $product_details_data, true);

            // return $product_details["name"];

            $product_name=$product_details["name"];
            $product_quantity=$product_details["min_qty"];
            $product_cost=$product_details["unit_price"];


            $curl = curl_init();
    
            // return $orders[0];
            $confirmation_data = [
                "name" => $f_name,
                "email" => $email,
                "phone" => $phone,
                "order_id" => $order_ids,
                "product_name" => $product_name,
                "quantity" => $product_quantity,
                "price" => $order_amount,
                "total_price" => $product_cost,
                "shipping_cost" => $shipping_cost,
                "status" => $value,
                "date" => $order_collection_date,
                "street" => $address,
                "city" => $city,
                "code" => $zip,
                "country" => $country,
            ];
            $email_confirmation_data = json_encode($confirmation_data);

            $curl = curl_init();
            curl_setopt_array($curl, array(
              CURLOPT_URL => $email_confirmation_url,
              CURLOPT_RETURNTRANSFER => true,
              CURLOPT_SSL_VERIFYHOST => false,
              CURLOPT_SSL_VERIFYPEER => false,
              CURLOPT_ENCODING => '',
              CURLOPT_MAXREDIRS => 10,
              CURLOPT_TIMEOUT => 0,
              CURLOPT_FOLLOWLOCATION => true,
              CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
              CURLOPT_CUSTOMREQUEST => 'POST',
              CURLOPT_POSTFIELDS =>$email_confirmation_data,
              CURLOPT_HTTPHEADER => array(
                'Content-Type: application/json'
              ),
            ));
            $email_response = curl_exec($curl);
            curl_close($curl);
    
         
            if ($sms_mode == 1) {

                $confirmation_data = [
                    "name"=> $FirstName,
                    "phone"=> $phone,
                    "order_number"=>$BillRefNumber
                ];  
  
                $msg_confirmation_data= json_encode($confirmation_data);

                $curl = curl_init();

                curl_setopt_array($curl, array(
                CURLOPT_URL => $msg_confirmation_url,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_SSL_VERIFYHOST => false,
                CURLOPT_SSL_VERIFYPEER => false,
                CURLOPT_ENCODING => '',
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 0,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => 'POST',
                CURLOPT_POSTFIELDS =>$msg_confirmation_data,
                CURLOPT_HTTPHEADER => array(
                    'Accept: application/json',
                    'Content-Type: application/json'
                ),
                ));
                $msg_response = curl_exec($curl);
            
                curl_close($curl);
            }

            return response([
                "Success" => 200,
                "email_data" =>  $email_response,
                "msg_data" => $msg_response, ], 200);

    }





    

    /**
     * J-son Response to M-pesa API feedback - Success or Failure
     */
    public function validation(Request $request)
    // public function validation($result_code, $result_description)
    {
        $content = trim(file_get_contents("php://input"));


        // $content =' {
        //     "TransactionType": "Pay Bill",
        //     "TransID": "RAF0GU16DO",
        //     "TransTime": "20230115202411",
        //     "TransAmount": "2.00",
        //     "BusinessShortCode": "4095279",
        //     "BillRefNumber": "100027",
        //     "InvoiceNumber": "",
        //     "OrgAccountBalance": "168.00",
        //     "ThirdPartyTransID": "",
        //     "MSISDN": "2547 ***** 862",
        //     "FirstName": "FESTUS"
        // }';
 

        // $content ='{
        //     "TransactionType": "Pay Bill",
        //     "TransID": "QFN78FA6WL",
        //     "TransTime": "20220623145440",
        //     "TransAmount": "1.00",
        //     "BusinessShortCode": "540921",
        //     "BillRefNumber": "100002",
        //     "InvoiceNumber": "",
        //     "OrgAccountBalance": "974.00",
        //     "ThirdPartyTransID": "",
        //     "MSISDN": "254722229862",
        //     "FirstName": "FESTUS",
        //     "MiddleName": "BETT",
        //     "LastName": ""
        // } ';

        \DB::table("mpesa_logs")->insert(["resultDesc"=>"validation","log" => $content, ]);

  
        $data = json_decode($content, true);

        //If json_decode failed, the JSON is invalid.
        if (!is_array($data))
        {
            echo 'Received content contained invalid JSON!';
        }

        //Process the JSON.
        $data = (array)$data; // cast (convert) the object to an array
        //print_r($data);

        $callbackData=json_decode($content);
        $TransactionType=$callbackData->TransactionType;
        $TransID=$callbackData->TransID;
        $TransTime=$callbackData->TransTime;
        $TransAmount=$callbackData->TransAmount;
        $businessShortCode=$callbackData->BusinessShortCode;
        $BusinessShortCode=$callbackData->BillRefNumber;
        $BillRefNumber=$callbackData->BillRefNumber;
        $InvoiceNumber=$callbackData->InvoiceNumber;
        $OrgAccountBalance=$callbackData->OrgAccountBalance;
        $ThirdPartyTransID=$callbackData->ThirdPartyTransID;
        $MSISDN=$callbackData->MSISDN;
        $FirstName=$callbackData->FirstName;
        // $MiddleName=$callbackData->MiddleName;
        // $LastName =$callbackData->LastName;
     
        $TransactionType = $data['TransactionType'];
        $TransID = $data['TransID'];
        $TransTime = $data['TransTime'];
        $TransAmount = $data['TransAmount'];
        $BusinessShortCode = $data['BusinessShortCode'];
        $BillRefNumber = $data['BillRefNumber'];
        $InvoiceNumber = $data['InvoiceNumber'];
        $OrgAccountBalance = $data['OrgAccountBalance'];
        $ThirdPartyTransID = $data['ThirdPartyTransID'];
        $MSISDN = $data['MSISDN'];
        $FirstName = $data['FirstName'];
        // $MiddleName = $data['MiddleName'];
        // $LastName = $data['LastName'];

        $email_response = array();
        //send back the below response to accept transaction
        $response["ResultCode"] = 0;
        $response["ResultDesc"] = "Confirmed";

       DB::table("mpesa_transactions")->insert([
                "TransactionType" => $TransactionType,
                "TransID" => $TransID,
                "ThirdPartyTransID"=> $ThirdPartyTransID,
                "TransTime" => $TransTime, 
                "TransAmount" => $TransAmount,
                "BusinessShortCode" => $BusinessShortCode,
                "BillRefNumber" => $BillRefNumber, 
                "InvoiceNumber" => $InvoiceNumber, 
                "resultCode" => $response["ResultCode"], 
                "resultDesc" => $response["ResultDesc"],
                "OrgAccountBalance" => $OrgAccountBalance,
                "MSISDN" => $MSISDN,
                "FirstName" => $FirstName, 
                "MiddleName" => '', 
                "LastName" => '' ,
                "response" => "validation" ,
                 ]
            );

            \DB::table("orders")->where("id", $BillRefNumber)
            ->update(["payment_status" => "paid", "order_status" => "confirmed","transaction_ref"=>$TransID ]);
          

        return $response;

    }


    public function getPayments()
    {

        // $timestamp = Carbon::rawParse("now")->format("YmdHms");

        // return $timestamp;
        $mpesa_transactions = DB::table('mpesa_transactions')
        ->orderBy('TransID', 'ASC')
        ->orderBy('created_at', 'DESC')
        ->get(); 

        return $mpesa_transactions;
    }
    public function getPaymentsLogs()
    {

        // $timestamp = Carbon::rawParse("now")->format("YmdHms");

        // return $timestamp;
        $mpesa_logs = DB::table('mpesa_logs')
        ->orderBy('created_at', 'DESC')
        ->get(); 

        return $mpesa_logs;
    }

    /**
     *Generation of password for managing Stk push
     *
     */



    public function STKPushSimulation(Request $request)
    {
        $validator = Validator::make($request->all() , ["phone" => "required", "amount" => "required", "AccountReference" => "required", ],
         ["phone.required" => "The Phone Number field is required.", "amount.required" => "The amount field is required.", 
         "AccountReference.required" => "The AccountReference field is required.", ]);

        if ($validator->errors()
            ->count() > 0)
        {
            return response()
                ->json(["errors" => Helpers::error_processor($validator) , ]);
        }
        
        $phone = $request["phone"];
        $country_code = '254';
        if(Str::length($phone) ==10){
            $user_phone = Str::replaceFirst('0', $country_code, $request->phone);
        }
        if(Str::length($phone) ==9){
            $user_phone = $country_code.''.$phone;
        }
        if(Str::length($phone) ==12){
            $user_phone=$phone;
        }
        if(Str::length($phone) ==13){
            $user_phone = Str::replaceFirst('+254', $country_code, $request->phone);
        }

        

        $phoneNumber = $user_phone;
        $amount_1 = $request["amount"];
        $amount= round($amount_1);
        $AccountReference = $request["AccountReference"];

        // return $phoneNumber;

        $url = \Config::get("app.mpesa_stk_url");
        $app_url = \Config::get("app.app_url");

        // $mpesa_callback_url = \Config::get("app.mpesa_call_url");
    
        $call_back_url = "/api/v1/auth/request_mpesa_callback";
      
        $callback_url = "$app_url" . "$call_back_url";


        $shortCode = \Config::get("app.mpesa_business_shortcode");

        $curl_post_data = ["BusinessShortCode" => $shortCode, "Password" => $this->lipaNaMpesaPassword() , "Timestamp" => $this->getTimestamp() , "TransactionType" => "CustomerPayBillOnline", "Amount" => $amount, //The amount being transacted.
        "PartyA" => $phoneNumber, //Organization’s short code initiating the transaction.
        "PartyB" => $shortCode, //Organization’s short code receiving the funds being transacted.
        "PhoneNumber" => $phoneNumber, "CallBackURL" => $callback_url, "AccountReference" => $AccountReference, //Account Reference mandatory for “BusinessPaybill” CommandID.
        "TransactionDesc" => "lipa Na M-PESA", ];

        $data_string = json_encode($curl_post_data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

    

        $auth_url = \Config::get("app.mpesa_access_token");

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HTTPHEADER, ["Accept:application/json", "Content-Type:application/json", "Authorization:Bearer " . $this->generateAccessToken() , ]);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);
        // curl_setopt($ch, CURLOPT_HEADER, 0);
        $curl_res = curl_exec($ch);

        $curl = html_entity_decode($curl_res);
        $myArray = json_decode($curl, true);


        $merchantRequestID = $myArray["MerchantRequestID"];
        $checkoutRequestID = $myArray["CheckoutRequestID"];
        $ResponseCode = $myArray["ResponseCode"];

        $trn = new MpesaTransaction(["TransactionType" => "", "TransID" => $checkoutRequestID, "TransTime" => Carbon::rawParse("now")->format("YmdHms") , "TransAmount" => $amount, "BusinessShortCode" => $shortCode, "BillRefNumber" => "", "AccountReference" => $AccountReference, "InvoiceNumber" => "", "resultCode" => 512, "resultDesc" => "", "OrgAccountBalance" => "", "ThirdPartyTransID" => $merchantRequestID, "MSISDN" => $phoneNumber, "FirstName" => "", "MiddleName" => "", "LastName" => "", ]);

        $trn->save();

        return response()
            ->json([
                "code" => 200,
                "Success" => "success",
                "Data" => $trn, ], 201);
    }

    
   

}