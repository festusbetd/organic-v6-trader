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

class MpesaPaymentController extends Controller
{
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

    public function processSTKPushPayments(Request $request)
    {
        $validator = Validator::make($request->all() , [ "TransID" => "required", ], ["TransID.required" => "TheTransID field is required." ]);

        if ($validator->errors()
            ->count() > 0)
        {
            return response()
                ->json(["errors" => Helpers::error_processor($validator) , ]);
        }

        $TransID = $request["TransID"];

        // $timestamp = Carbon::rawParse("now")->format("YmdHms");

        // return $timestamp;
        $mpesa_transactions = DB::table('mpesa_transactions')
        ->select('resultCode', 'resultDesc','response','AccountReference','BillRefNumber','TransAmount','MSISDN')
        ->orderBy('created_at', 'DESC')
        ->where('TransID',$TransID)
        ->get(); 

        if($mpesa_transactions->isEmpty()){
            return response()->json(
                [
                    "Success" => 200,
                    "message" => "empty",
                    "resultCode"=> "null",
                    "resultDesc"=> "null",
                ],
                200
            );
        }
        else{
            return response()->json(
                [
                    "Success" => 200,
                    "message" => "success",
                    "data"=>$mpesa_transactions,
                ],
                200
            );
        }


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

    public function STKPushSimulation(Request $request)
    {
        $validator = Validator::make($request->all() , ["phone" => "required", "amount" => "required", "AccountReference" => "required", ], ["phone.required" => "The Phone Number field is required.", "amount.required" => "The amount field is required.", "AccountReference.required" => "The AccountReference field is required.", ]);

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
        $amount = $request["amount"];
        $AccountReference = $request["AccountReference"];

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
                "Success" => "Mpesa Stk pushed",
                "Callback_url" => $callback_url,
                "Data" => $trn, ], 201);
    }

    public function confirmation(Request $request)
    {

        $callbackJSONData=file_get_contents('php://input');

        // $callbackJSONData ='    {
        //     "TransactionType": "Pay Bill",
        //     "TransID": "100001",
        //     "TransTime": "20190115234802",
        //     "TransAmount": "100.00",
        //     "BusinessShortCode": "601380",
        //     "BillRefNumber": "Testing",
        //     "InvoiceNumber": "7Y72",
        //     "OrgAccountBalance": "900.00",
        //     "ThirdPartyTransID": "32802426",
        //     "MSISDN": "254708374149",
        //     "FirstName": "John",
        //     "MiddleName": "J.",
        //     "LastName": "Doe"
        // }';

        \DB::table("mpesa_logs")->insert(["resultDesc"=>"confirmation","log" => $callbackJSONData, ]);


        $callbackData=json_decode($callbackJSONData);
        
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
        $MiddleName=$callbackData->MiddleName;
        $LastName =$callbackData->LastName;

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
            "MiddleName" => $MiddleName, 
            "LastName" => $LastName ,
             ]
        );

          return response()->json(
            [
                "Success" => 200
            ],
            200
        );
    }


    /**
     * J-son Response to M-pesa API feedback - Success or Failure
     */
    public function validation(Request $request)
    // public function validation($result_code, $result_description)
    {
        $content = trim(file_get_contents("php://input"));

        //  $content ='    {
        //     "TransactionType": "Pay Bill",
        //     "TransID": "NAF81H7Y72",
        //     "TransTime": "20190115234802",
        //     "TransAmount": "100.00",
        //     "BusinessShortCode": "601380",
        //     "BillRefNumber": "Testing",
        //     "InvoiceNumber": "7Y72",
        //     "OrgAccountBalance": "900.00",
        //     "ThirdPartyTransID": "32802426",
        //     "MSISDN": "254708374149",
        //     "FirstName": "John",
        //     "MiddleName": "J.",
        //     "LastName": "Doe"
        // }';

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
        $MiddleName=$callbackData->MiddleName;
        $LastName =$callbackData->LastName;
     
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
        $MiddleName = $data['MiddleName'];
        $LastName = $data['LastName'];

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
                "MiddleName" => $MiddleName, 
                "LastName" => $LastName ,
                 ]
            );

          
        echo json_encode("payment unsuccessful");

        // send back the below response to reject transaction
        // $response["ResultCode"] = 1;
        // $response["ResultDesc"] = "Rejected";
    
        // echoRespnse(200, $response);

        // $resultArray=[
        //     "ResultDesc"=>"Confirmation Service request accepted successfully",
        //     "ResultCode"=>"0"
        // ];
        // header('Content-Type: application/json');

        // echo json_encode($resultArray);
        return $response;

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


    /**
     * M-pesa Register Validation and Confirmation method
     */
    public function mpesa_register_url()
    {
        $curl = curl_init();
        $shortCode = \Config::get("app.mpesa_business_shortcode");
        $app_url = \Config::get("app.app_url");
        $confirmation_url = "/api/v1/notifications/request_confirmation";
        $validation_url = "/api/v1/notifications/request_validation";

        $conf_url = $app_url . $confirmation_url;
        $valid_url = $app_url . $validation_url;

        $shortCode = \Config::get("app.mpesa_register_url");
        $mpesa_register_url = \Config::get("app.mpesa_business_shortcode");
        curl_setopt($curl, CURLOPT_URL, $mpesa_register_url);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array(
            'Content-Type:application/json',
            'Authorization: Bearer ' . $this->generateAccessToken()
        ));
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode(array(
            'ShortCode' => $shortCode,
            'ResponseType' => 'Confirmed',
            'ConfirmationURL' => $conf_url,
            'ValidationURL' => $valid_url
        )));
        $curl_response = curl_exec($curl);

        // return response()->json(
        //     [
        //         "Code" => 200,
        //         "Messsage" => 200,
        //         "Confirmation URL" =>$conf_url ,
        //         "Validation URL" => $valid_url,
        //     ],
        //     201
        // );
        print_r($curl_response);
        echo $curl_response;
    }

        /**
     * Use this function to process the STK Push  request callback
     * @return string
     */
    public static function processSTKPushQueryRequestCallback(){
        $callbackJSONData=file_get_contents('php://input');
        $callbackData=json_decode($callbackJSONData);
        $responseCode=$callbackData->ResponseCode;
        $responseDescription=$callbackData->ResponseDescription;
        $merchantRequestID=$callbackData->MerchantRequestID;
        $checkoutRequestID=$callbackData->CheckoutRequestID;
        $resultCode=$callbackData->ResultCode;
        $resultDesc=$callbackData->ResultDesc;

        $result=[
            "resultCode"=>$resultCode,
            "responseDescription"=>$responseDescription,
            "responseCode"=>$responseCode,
            "merchantRequestID"=>$merchantRequestID,
            "checkoutRequestID"=>$checkoutRequestID,
            "resultDesc"=>$resultDesc
        ];

        return json_encode($result);
    }

     /**
     * Use this function to process the Transaction status request callback
     * @return string
     */
    public static function processTransactionStatusRequestCallback(Request $request){
        $url = 'https://api.safaricom.co.ke/mpesa/transactionstatus/v1/query';

        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type:application/json','Authorization:Bearer '.self::generateToken())); //setting custom header

        $validator = Validator::make($request->all() , [
        "Initiator" => "required", 
        "amount" => "required", 
        "SecurityCredential" => "required", 
        "CommandID" => "required", 
        "TransactionID" => "required", 
        "PartyA" => "required", 
        "IdentifierType" => "required", 
        "ResultURL" => "required", 
        "OccasionL" => "required",
    ], 
       
        ["Initiator.required" => "The Initiator field is required.", 
        "amount.required" => "The amount field is required.", 
        "SecurityCredential.required" => "The SecurityCredential field is required.", 
        "CommandID.required" => "The CommandID field is required.", 
        "TransactionID.required" => "The TransactionID field is required.", 
        "PartyA.required" => "The PartyA field is required.",    
        "IdentifierType.required" => "The IdentifierType field is required.", 
        "ResultURL.required" => "The ResultURL  field is required.", 
        "OccasionL.required" => "The OccasionL field is required.",]);

        if ($validator->errors()
            ->count() > 0)
        {
            return response()
                ->json(["errors" => Helpers::error_processor($validator) , ]);
        }

        $Initiator = $request["Initiator"];
        $SecurityCredential = $request["SecurityCredential"];
        $CommandID = $request["CommandID"];
        $TransactionID = $request["TransactionID"];
        $PartyA = $request["PartyA"];
        $IdentifierType = $request["IdentifierType"];
        $ResultURL = $request["ResultURL"];
        $QueueTimeOutURL = $request["QueueTimeOutURL"];
        $Remarks = $request["Remarks"];
        $Occasion = $request["OccasionL"];

        $curl_post_data = array(
            'Initiator' => $Initiator,
            'SecurityCredential' => $SecurityCredential,
            'CommandID' => $CommandID,
            'TransactionID' => $TransactionID,
            'PartyA' => $PartyA,
            'IdentifierType' => $IdentifierType,
            'ResultURL' => $ResultURL,
            'QueueTimeOutURL' => $QueueTimeOutURL,
            'Remarks' => $Remarks,
            'Occasion' => $Occasion
        );

        $data_string = json_encode($curl_post_data);

        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);
        curl_setopt($curl, CURLOPT_HEADER, false);
        $curl_response = curl_exec($curl);

        return $curl_response;
    }

    public function b2b(Request $request){
        $url = 'https://api.safaricom.co.ke/mpesa/b2b/v1/paymentrequest';
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type:application/json','Authorization:Bearer '.self::generateToken())); //setting custom header

        $validator = Validator::make($request->all() , [
            "Initiator" => "required", 
            "SenderIdentifierType" => "required", 
            "RecieverIdentifierType" => "required", 
            "amount" => "required", 
            "SecurityCredential" => "required", 
            "CommandID" => "required", 
            "TransactionID" => "required", 
            "PartyA" => "required", 
            "IdentifierType" => "required", 
            "ResultURL" => "required", 
            "QueueTimeOutURL" => "required", 
            "OccasionL" => "required",
        ], 
           
            ["Initiator.required" => "The Initiator field is required.", 
            "SenderIdentifierType.required" => "The SenderIdentifierType field is required.", 
            "RecieverIdentifierType.required" => "The RecieverIdentifierType field is required.", 
            "SecurityCredential.required" => "The SecurityCredential field is required.", 
            "amount.required" => "The amount field is required.", 
            "CommandID.required" => "The CommandID field is required.", 
            "TransactionID.required" => "The TransactionID field is required.", 
            "PartyA.required" => "The PartyA field is required.",    
            "IdentifierType.required" => "The IdentifierType field is required.", 
            "ResultURL.required" => "The ResultURL  field is required.", 
            "QueueTimeOutURL.required" => "The QueueTimeOutURL  field is required.", 
            "OccasionL.required" => "The OccasionL field is required.",]);
    
            if ($validator->errors()
                ->count() > 0)
            {
                return response()
                    ->json(["errors" => Helpers::error_processor($validator) , ]);
            }
    
            $Initiator = $request["Initiator"];
            $SenderIdentifierType = $request["SenderIdentifierType"];
            $RecieverIdentifierType = $request["RecieverIdentifierType"];
            $SecurityCredential = $request["SecurityCredential"];
            $CommandID = $request["CommandID"];
            $TransactionID = $request["TransactionID"];
            $Amount = $request["Amount"];
            $PartyA = $request["PartyA"];
            $IdentifierType = $request["IdentifierType"];
            $ResultURL = $request["ResultURL"];
            $QueueTimeOutURL = $request["QueueTimeOutURL"];
            $Remarks = $request["Remarks"];
            $Occasion = $request["OccasionL"];

        $curl_post_data = array(
            'Initiator' => $Initiator,
            'SecurityCredential' => $SecurityCredential,
            'CommandID' => $commandID,
            'SenderIdentifierType' => $SenderIdentifierType,
            'RecieverIdentifierType' => $RecieverIdentifierType,
            'Amount' => $Amount,
            'PartyA' => $PartyA,
            'PartyB' => $PartyB,
            'AccountReference' => $AccountReference,
            'Remarks' => $Remarks,
            'QueueTimeOutURL' => $QueueTimeOutURL,
            'ResultURL' => $ResultURL
        );
        $data_string = json_encode($curl_post_data);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);
        $curl_response = curl_exec($curl);
        return $curl_response;

    }
}

