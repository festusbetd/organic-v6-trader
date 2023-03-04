<?php

namespace App\Http\Controllers\Web;


use App\CPU\Helpers;
use App\CPU\OrderManager;
use App\CPU\ProductManager;
use App\CPU\CartManager;
use Gregwar\Captcha\CaptchaBuilder;
use App\Http\Controllers\Controller;
use App\Model\Admin;
use App\Model\Brand;
use App\Model\BusinessSetting;
use App\Model\Cart;
use App\Model\CartShipping;
use App\Model\Category;
use App\Model\Contact;
use App\Model\DealOfTheDay;
use App\Model\FlashDeal;
use App\Model\FlashDealProduct;
use App\Model\HelpTopic;
use App\Model\OrderDetail;
use App\Model\Product;
use App\Http\Controllers\Web\Redirect;
use App\Model\Review;
use App\Model\Seller;
use App\Model\ShippingMethod;
use App\Model\Shop;
use App\Model\Order;
use App\Model\Transaction;
use App\Model\Translation;
use App\User;
use App\Model\Wishlist;
use Brian2694\Toastr\Facades\Toastr;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Session;
use function App\CPU\translate;

class WebController extends Controller
{
    public function maintenance_mode()
    {
        $maintenance_mode =
            Helpers::get_business_settings("maintenance_mode") ?? 0;
        if ($maintenance_mode) {
            return view("web-views.maintenance-mode");
        }
        return redirect()->route("home");
    }
    public function registerSeller()
    {
        session()->put("keep_return_url", url()->previous());
        return view("customer-view.auth.register_seller");
    }
    public function login()
    {
        session()->put('keep_return_url', url()->previous());
        $custome_recaptcha = new CaptchaBuilder;
        $custome_recaptcha->build();
        Session::put('custome_recaptcha', $custome_recaptcha->getPhrase());
        return view('customer-view.auth.login', compact('custome_recaptcha'));
    }
 
    public function home()
    {
        // auth("customer")->check()
        if (auth("customer")->check()) {

            $home_categories = Category::where("home_status", true)->get();
            $home_categories->map(function ($data) {
                $data["products"] = Product::active()
                    /*->where('category_ids', 'like', "%{$data['id']}%")*/
                    ->whereJsonContains("category_ids", [
                        "id" => (string) $data["id"],
                    ])
                    ->inRandomOrder()
                    ->take(12)
                    ->get();
            });
            //products based on top seller
            $top_sellers = Seller::approved()
                ->with("shop")
                ->withCount(["orders"])
                ->orderBy("orders_count", "DESC")
                ->take(15)
                ->get();
            //end
    
            //feature products finding based on selling
            $featured_products = Product::with(["reviews"])
                ->active()
                ->where("featured", 1)
                ->withCount(["order_details"])
                ->orderBy("order_details_count", "DESC")
                ->take(12)
                ->get();
            //end
    
            $latest_products = Product::with(["reviews"])
                ->active()
                ->orderBy("id", "desc")
                ->take(8)
                ->get();
            $categories = Category::where("position", 0)
                ->take(12)
                ->get();
            $brands = Brand::take(15)->get();
            //best sell product
            $bestSellProduct = OrderDetail::with("product.reviews")
                ->whereHas("product", function ($query) {
                    $query->active();
                })
                ->select("product_id", DB::raw("COUNT(product_id) as count"))
                ->groupBy("product_id")
                ->orderBy("count", "desc")
                ->take(4)
                ->get();
            //Top rated
            $topRated = Review::with("product")
                ->whereHas("product", function ($query) {
                    $query->active();
                })
                ->select("product_id", DB::raw("AVG(rating) as count"))
                ->groupBy("product_id")
                ->orderBy("count", "desc")
                ->take(4)
                ->get();
    
            if ($bestSellProduct->count() == 0) {
                $bestSellProduct = $latest_products;
            }
    
            if ($topRated->count() == 0) {
                $topRated = $bestSellProduct;
            }
    
            $deal_of_the_day = DealOfTheDay::join(
                "products",
                "products.id",
                "=",
                "deal_of_the_days.product_id"
            )
                ->select("deal_of_the_days.*", "products.unit_price")
                ->where("deal_of_the_days.status", 1)
                ->first();
    
            return view(
                "web-views.home",
                compact(
                    "featured_products",
                    "topRated",
                    "bestSellProduct",
                    "latest_products",
                    "categories",
                    "brands",
                    "deal_of_the_day",
                    "top_sellers",
                    "home_categories"
                )
            );
            // return view('customer-view.auth.login', compact('custome_recaptcha'));
        }

        else{
            session()->put('keep_return_url', url()->previous());
            $custome_recaptcha = new CaptchaBuilder;
            $custome_recaptcha->build();
            Session::put('custome_recaptcha', $custome_recaptcha->getPhrase());
            return view('customer-view.auth.login', compact('custome_recaptcha'));
        }
        
 
    }

    public function flash_deals($id)
    {
        $deal = FlashDeal::with(["products.product.reviews"])
            ->where(["id" => $id, "status" => 1])
            ->whereDate("start_date", "<=", date("Y-m-d"))
            ->whereDate("end_date", ">=", date("Y-m-d"))
            ->first();

        $discountPrice = FlashDealProduct::with(["product"])
            ->whereHas("product", function ($query) {
                $query->active();
            })
            ->get()
            ->map(function ($data) {
                return [
                    "discount" => $data->discount,
                    "sellPrice" => $data->product->unit_price,
                    "discountedPrice" =>
                        $data->product->unit_price - $data->discount,
                ];
            })
            ->toArray();
        // dd($deal->toArray());

        if (isset($deal)) {
            return view("web-views.deals", compact("deal", "discountPrice"));
        }
        Toastr::warning(translate("not_found"));
        return back();
    }

    public function search_shop(Request $request)
    {
        $key = explode(" ", $request["shop_name"]);
        $sellers = Shop::where(function ($q) use ($key) {
            foreach ($key as $value) {
                $q->orWhere("name", "like", "%{$value}%");
            }
        })
            ->whereHas("seller", function ($query) {
                return $query->where(["status" => "approved"]);
            })
            ->paginate(30);
        return view("web-views.sellers", compact("sellers"));
    }

    public function all_categories()
    {
        $categories = Category::all();
        return view("web-views.categories", compact("categories"));
    }

    public function categories_by_category($id)
    {
        $category = Category::with(["childes.childes"])
            ->where("id", $id)
            ->first();
        return response()->json([
            "view" => view(
                "web-views.partials._category-list-ajax",
                compact("category")
            )->render(),
        ]);
    }

    public function all_brands()
    {
        $brands = Brand::paginate(24);
        return view("web-views.brands", compact("brands"));
    }

    public function all_sellers()
    {
        if (auth("customer")->check()) {
        $sellers = Shop::whereHas("seller", function ($query) {
            return $query->approved();
        })->paginate(24);
        return view("web-views.sellers", compact("sellers"));
    }
    else{
        session()->put('keep_return_url', url()->previous());
        $custome_recaptcha = new CaptchaBuilder;
        $custome_recaptcha->build();
        Session::put('custome_recaptcha', $custome_recaptcha->getPhrase());
        return view('customer-view.auth.login', compact('custome_recaptcha'));
    }
    }

    public function seller_profile($id)
    {
        $seller_info = Seller::find($id);
        return view("web-views.seller-profile", compact("seller_info"));
    }

    public function searched_products(Request $request)
    {
        $request->validate(
            [
                "name" => "required",
            ],
            [
                "name.required" => "Product name is required!",
            ]
        );

        $result = ProductManager::search_products($request["name"]);
        $products = $result["products"];

        if ($products == null) {
            $result = ProductManager::translated_product_search(
                $request["name"]
            );
            $products = $result["products"];
        }

        return response()->json([
            "result" => view(
                "web-views.partials._search-result",
                compact("products")
            )->render(),
        ]);
    }

    public function checkout_details(Request $request)
    {
        $cart_group_ids = CartManager::get_cart_group_ids();
        $cart_details = CartManager::get_cart();
        if (
            CartShipping::whereIn("cart_group_id", $cart_group_ids)->count() !=
            count($cart_group_ids)
        ) {
            Toastr::info(translate("select_shipping_method_first"));
            return redirect("shop-cart");
        }

        if (count($cart_group_ids) > 0) {
            return view("web-views.checkout-shipping");
        }

        Toastr::info(translate("no_items_in_basket"));
        return redirect("/");
    }

    public function checkout_payment()
    {
        $cart_group_ids = CartManager::get_cart_group_ids();
        $cart_details = CartManager::get_cart();
        if (
            CartShipping::whereIn("cart_group_id", $cart_group_ids)->count() !=
            count($cart_group_ids)
        ) {
            Toastr::info(translate("select_shipping_method_first"));
            return redirect("shop-cart");
        }

        if (session()->has("address_id") && count($cart_group_ids) > 0) {
            return view("web-views.checkout-payment", $cart_group_ids)->with(
                "cart_id",
                $cart_group_ids
            );
        }

        Toastr::error(translate("incomplete_info"));
        return back();
    }

    public function checkout_complete_mpesa(Request $request)
    {
        $cart_group_ids = CartManager::get_cart_group_ids();
        $cart_details = CartManager::get_cart();

        if (
            auth("customer")->check() &&
            Cart::where(["customer_id" => auth("customer")->id()])->count() > 0
        ) {
            return view("web-views.checkout-complete-mpesa");
        }
        Toastr::info("No items in your basket!");
        return redirect("/");
    }
    public function checkout_complete(Request $request)
    {
        $unique_id = OrderManager::gen_unique_id();
        $cart_group_ids = CartManager::get_cart_group_ids();
        $cart_details = CartManager::get_cart();
        $curl_cart_details = html_entity_decode($cart_details);
        $myArray__cart_details = json_decode($curl_cart_details, true);

        $product_quantity = $myArray__cart_details[0]["quantity"];
        $product_shipping_cost =CartManager::get_shipping_cost($cart_group_ids);

        if ($myArray__cart_details[0]["unit_pricing"] == 1) {
            $product_cost =($myArray__cart_details[0]["price"] * $product_quantity)+ ($product_shipping_cost*$product_quantity);
        } else {
            $product_cost = ($myArray__cart_details[0]["price"] * $product_quantity)+ $product_shipping_cost;
        }

        $order_ids = [];
        foreach (CartManager::get_cart_group_ids() as $group_id) {
            $data = [
                "payment_method" => "cash_on_delivery",
                "order_status" => "Confirmed",
                "payment_status" => "unpaid",
                "transaction_ref" => "",
                "unit_pricing" => $myArray__cart_details[0]["price"],
                "product_total_cost" => $product_cost,
                "order_group_id" => $unique_id,
                "cart_group_id" => $group_id,
                "order_cart_id" => $cart_group_ids,
            ];
            $order_id = OrderManager::generate_order($data);
            array_push($order_ids, $order_id);
        }

        CartManager::cart_clean();
        $ord = $order_id;
        return view("web-views.checkout-complete");
    }

    public function checkout_credit(Request $request)
    {
        $unique_id = OrderManager::gen_unique_id();
        $cart_details = CartManager::get_cart();
        // return $cart_details;
        $cart_group_ids = CartManager::get_cart_group_ids();
        $curl_cart_details = html_entity_decode($cart_details);
        $myArray__cart_details = json_decode($curl_cart_details, true);

        $product_quantity = $myArray__cart_details[0]["quantity"];
        $product_shipping_cost =CartManager::get_shipping_cost($cart_group_ids);

        if ($myArray__cart_details[0]["unit_pricing"] == 1) {
            $product_cost =($myArray__cart_details[0]["price"] * $product_quantity)+ ($product_shipping_cost*$product_quantity);
        } else {
            $product_cost = ($myArray__cart_details[0]["price"] * $product_quantity)+ $product_shipping_cost;
        }

        // return $product_cost;
        // return $myArray__cart_details[0]["price"];
        $order_ids = [];
        foreach (CartManager::get_cart_group_ids() as $group_id) {
            $data = [
                "payment_method" => "credit",
                "order_status" => "Confirmed",
                "payment_status" => "unpaid",
                "transaction_ref" => "",
                "unit_pricing" => $myArray__cart_details[0]["price"],
                "product_total_cost" => $product_cost,
                "order_group_id" => $unique_id,
                "cart_group_id" => $group_id,
                "order_cart_id" => $cart_group_ids,
            ];
            $order_id = OrderManager::generate_order($data);
            array_push($order_ids, $order_id);
        }

        // $data = [
        //     "payment_method" => "MPESA",
        //     "order_status" => "Confirmed",
        //     "payment_status" => "paid",
        //     "transaction_ref" => "",
        //     "unit_pricing" => $myArray__cart_details[0]["price"],
        //     "product_total_cost" => $product_cost,
        //     "transaction_ref" => "",
        //     "order_group_id" => $unique_id,
        //     "cart_group_id" => $group_id,
        //     "order_cart_id" => $cart_group_ids,
        // ];

        CartManager::cart_clean();
        $ord = $order_id;
        return view("web-views.checkout-complete");
    }

    public function order_placed()
    {
        return view("web-views.checkout-complete");
    }
    public function checkout_complete_2(Request $request)
    {
        $app_url = \Config::get("app.app_url");
  
        $user = auth("customer")->user();
        $email = $user->email;
        $phone = $user->phone;
        $sms_mode = Helpers::get_business_settings("sms_mode");
        $unique_id = OrderManager::gen_unique_id();
        $cart_group_ids = CartManager::get_cart_group_ids();
        $cart_details = CartManager::get_cart();
        $shipping_cost=CartManager::get_shipping_cost();
        $order_ids = [];
        $mpesa_short_Code = \Config::get("app.mpesa_short_Code");
        $curl_user = html_entity_decode($user);
        $myArray_user = json_decode($curl_user, true);
        $f_name = $myArray_user["f_name"];
        $l_name = $myArray_user["l_name"];
        $customer_phone_number = $myArray_user["phone"];
        $curl_cart_details = html_entity_decode($cart_details);
        $myArray__cart_details = json_decode($curl_cart_details, true);
        $product_name = $myArray__cart_details[0]["name"];


        $seller_result = DB::Table("sellers")
            ->select("seller_id", "id", "phone","f_name","l_name")
            ->where("id", $myArray__cart_details[0]["seller_id"])
            ->get();

        $seller_curl = html_entity_decode($seller_result);
        $seller_myArray = json_decode($seller_curl, true);
    
        $seller_phone = $seller_myArray[0]['phone'];
        $seller_f_name = $seller_myArray[0]['f_name'];
        // $seller_l_name = $seller_myArray[0]['l_name'];

        $product_quantity = $myArray__cart_details[0]["quantity"];
        $product_shipping_cost =CartManager::get_shipping_cost($cart_group_ids);
     
        if ($myArray__cart_details[0]["unit_pricing"] == 1) {
            $product_cost =($myArray__cart_details[0]["price"] * $product_quantity)+ ($product_shipping_cost*$product_quantity);
        } else {
            $product_cost = ($myArray__cart_details[0]["price"] * $product_quantity)+ $product_shipping_cost;
        }

        $result = DB::Table("mpesa_transactions")
            ->select("resultDesc", "resultCode", "TransAmount")
            ->where("AccountReference", $cart_group_ids[0])
            ->get();
        $curl = html_entity_decode($result);
        $myArray = json_decode($curl, true);
        $_order_date = $myArray_user["created_at"];
        $f_order_date = strtok($_order_date, "T");


        if ($myArray[0]["resultCode"] == 0) {
            $email_confirmation_url =$app_url . "/api/v1/notifications/email_confirmation";
            $msg_confirmation_url =$app_url . "/api/v1/notifications/order_confirmation_msg";
            $seller_msg_confirmation_url =$app_url . "/api/v1/notifications/order_seller_confirmation_msg";
            foreach (CartManager::get_cart_group_ids() as $group_id) {
                $data = [
                    "payment_method" => "MPESA",
                    "order_status" => "Confirmed",
                    "payment_status" => "paid",
                    "transaction_ref" => "",
                    "unit_pricing" => $myArray__cart_details[0]["price"],
                    "product_total_cost" => $product_cost,
                    "transaction_ref" => "",
                    "order_group_id" => $unique_id,
                    "cart_group_id" => $group_id,
                    "order_cart_id" => $cart_group_ids,
                ];
                $order_id = OrderManager::generate_order($data);
                array_push($order_ids, $order_id);
            }

            $ord = $order_id;
            $value = "Confirmed";
            $order_ids = $order_id;
            $result = Order::select("shipping_address_data")
                ->where("id", $order_id)
                ->value("shipping_address_data");
            $myArray_shipping = json_decode($result, true);
            $address = $myArray_shipping["address"];
            $city = $myArray_shipping["city"];
            $zip = $myArray_shipping["zip"];
            $country = $myArray_shipping["country"];
            $order_collection_date = $myArray_shipping["order_collection_date"];

            $curl = curl_init();
    
            $confirmation_data = [
                "name" => $f_name,
                "email" => $email,
                "phone" => $phone,
                "order_id" => $order_ids,
                "product_name" => $product_name,
                "quantity" => $product_quantity,
                "price" => $myArray__cart_details[0]["price"],
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
            $response = curl_exec($curl);
            curl_close($curl);


            if ($sms_mode == 1) {
                $confirmation_data = [
                    "name"=> $f_name,
                    "phone"=> $customer_phone_number,
                    "order_number"=>$ord
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
                $response = curl_exec($curl);
                curl_close($curl);


                $seller_confirmation_data = [
                    "name"=> $seller_f_name,
                    "phone"=> $seller_phone,
                    "order_number"=>$ord
                ];  
                $seller_msg_confirmation_data= json_encode($seller_confirmation_data);
                $curl = curl_init();
                curl_setopt_array($curl, array(
                CURLOPT_URL => $seller_msg_confirmation_url,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_SSL_VERIFYHOST => false,
CURLOPT_SSL_VERIFYPEER => false,
                CURLOPT_ENCODING => '',
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 0,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => 'POST',
                CURLOPT_POSTFIELDS =>$seller_msg_confirmation_data,
                CURLOPT_HTTPHEADER => array(
                    'Accept: application/json',
                    'Content-Type: application/json'
                ),
                ));
                $response = curl_exec($curl);
                curl_close($curl);
       
            }

           
            
            CartManager::cart_clean();
            return view("web-views.checkout-complete");
        }
        if ($myArray[0]["resultCode"] == 512) {
            Toastr::info("Still Processing payments!");
            return redirect("checkout-complete-mpesa");
        }
        if ($myArray[0]["resultCode"] == 1032 || $myArray[0]["resultCode"]) {
            Toastr::info($myArray[0]["resultDesc"]);
            $email_failed_url =$app_url . "/api/v1/notifications/email_failed";
            $msg_failed_url =$app_url . "/api/v1/notifications/order_failed_msg";
            foreach (CartManager::get_cart_group_ids() as $group_id) {
                $data = [
                    "payment_method" => "MPESA",
                    "order_status" => "pending",
                    "payment_status" => "paid",
                    "transaction_ref" => "",
                    "unit_pricing" => $myArray__cart_details[0]["price"],
                    "product_total_cost" => $product_cost,
                    "shipping_cost" => $shipping_cost,
                    "transaction_ref" => "",
                    "order_group_id" => $unique_id,
                    "cart_group_id" => $group_id,
                    "order_cart_id" => $cart_group_ids,
                ];
                $order_id = OrderManager::generate_order($data);
                array_push($order_ids, $order_id);
            }
            $ord = $order_id;
            $value = "pending";
            $result = Order::select("shipping_address_data")
            ->where("id", $order_id)
            ->value("shipping_address_data");
            $myArray_shipping = json_decode($result, true);
            $address = $myArray_shipping["address"];
            $city = $myArray_shipping["city"];
            $zip = $myArray_shipping["zip"];
            $country = $myArray_shipping["country"];
            $order_collection_date = $myArray_shipping["order_collection_date"];

            $failed_data = [
                "name" => $f_name,
                "email" => $email,
                "phone" => $phone,
                "order_id" => $ord,
                "product_name" => $product_name,
                "quantity" => $product_quantity,
                "price" => $myArray__cart_details[0]["price"],
                "total_price" => $product_cost,
                "shipping_cost" => $shipping_cost,
                "status" => $value,
                "date" => $order_collection_date,
                "street" => $address,
                "city" => $city,
                "code" => $zip,
                "country" => $country,
            ];
            $email_failed_data = json_encode($failed_data);

            $curl = curl_init();
            curl_setopt_array($curl, array(
              CURLOPT_URL => $email_failed_url,
              CURLOPT_RETURNTRANSFER => true,
              CURLOPT_SSL_VERIFYHOST => false,
CURLOPT_SSL_VERIFYPEER => false,
              CURLOPT_ENCODING => '',
              CURLOPT_MAXREDIRS => 10,
              CURLOPT_TIMEOUT => 0,
              CURLOPT_FOLLOWLOCATION => true,
              CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
              CURLOPT_CUSTOMREQUEST => 'POST',
              CURLOPT_POSTFIELDS =>$email_failed_data,
              CURLOPT_HTTPHEADER => array(
                'Content-Type: application/json'
              ),
            ));
            $response = curl_exec($curl);
            curl_close($curl);
          
            if ($sms_mode == 1) {
            $failed_data = [
                "name"=> $f_name,
                "phone"=> $customer_phone_number,
                "order_number"=>$ord,
                "amount"=> $product_cost
            ];  
            $msg_failed_data= json_encode($failed_data);
            $curl = curl_init();
            curl_setopt_array($curl, array(
            CURLOPT_URL => $msg_failed_url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_SSL_VERIFYHOST => false,
CURLOPT_SSL_VERIFYPEER => false,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS =>$msg_failed_data,
            CURLOPT_HTTPHEADER => array(
                'Accept: application/json',
                'Content-Type: application/json'
            ),
            ));
            $response = curl_exec($curl);
            curl_close($curl);
        }
            CartManager::cart_clean();
            $ord = $order_id;
            return view("web-views.checkout-complete");
        } else {
            Toastr::info($myArray[0]["resultDesc"]);
            $email_failed_url =$app_url . "/api/v1/notifications/email_failed";
            $msg_failed_url =$app_url . "/api/v1/notifications/order_failed_msg";
            foreach (CartManager::get_cart_group_ids() as $group_id) {
                $data = [
                    "payment_method" => "MPESA",
                    "order_status" => "Confirmed",
                    "payment_status" => "pending",
                    "transaction_ref" => "",
                    "unit_pricing" => $myArray__cart_details[0]["price"],
                    "product_total_cost" => $product_cost,
                    "transaction_ref" => "",
                    "order_group_id" => $unique_id,
                    "cart_group_id" => $group_id,
                    "order_cart_id" => $cart_group_ids,
                ];
                $order_id = OrderManager::generate_order($data);
                array_push($order_ids, $order_id);
            }
            $ord = $order_id;
            $value = "pending";
            $result = Order::select("shipping_address_data")
            ->where("id", $order_id)
            ->value("shipping_address_data");
            $myArray_shipping = json_decode($result, true);
            $address = $myArray_shipping["address"];
            $city = $myArray_shipping["city"];
            $zip = $myArray_shipping["zip"];
            $country = $myArray_shipping["country"];
            $order_collection_date = $myArray_shipping["order_collection_date"];
            $failed_data = [
                "name" => $f_name,
                "email" => $email,
                "phone" => $phone,
                "order_id" => $ord,
                "product_name" => $product_name,
                "quantity" => $product_quantity,
                "price" => $myArray__cart_details[0]["price"],
                "total_price" => $product_cost,
                "shipping_cost" => $shipping_cost,
                "status" => $value,
                "date" => $order_collection_date,
                "street" => $address,
                "city" => $city,
                "code" => $zip,
                "country" => $country,
            ];
            $email_failed_data = json_encode($failed_data);

            $curl = curl_init();
            curl_setopt_array($curl, array(
              CURLOPT_URL => $email_failed_url,
              CURLOPT_RETURNTRANSFER => true,
              CURLOPT_SSL_VERIFYHOST => false,
CURLOPT_SSL_VERIFYPEER => false,
              CURLOPT_ENCODING => '',
              CURLOPT_MAXREDIRS => 10,
              CURLOPT_TIMEOUT => 0,
              CURLOPT_FOLLOWLOCATION => true,
              CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
              CURLOPT_CUSTOMREQUEST => 'POST',
              CURLOPT_POSTFIELDS =>$email_failed_data,
              CURLOPT_HTTPHEADER => array(
                'Content-Type: application/json'
              ),
            ));
            $response = curl_exec($curl);
            curl_close($curl);
          
            if ($sms_mode == 1) {
            $failed_data = [
                "name"=> $f_name,
                "phone"=> $customer_phone_number,
                "order_number"=>$ord,
                "amount"=> $product_cost
            ];  
            $msg_failed_data= json_encode($failed_data);
            $curl = curl_init();
            curl_setopt_array($curl, array(
            CURLOPT_URL => $msg_failed_url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_SSL_VERIFYHOST => false,
CURLOPT_SSL_VERIFYPEER => false,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS =>$msg_failed_data,
            CURLOPT_HTTPHEADER => array(
                'Accept: application/json',
                'Content-Type: application/json'
            ),
            ));
            $response = curl_exec($curl);
            curl_close($curl);
        }
            CartManager::cart_clean();
            $ord = $order_id;
            return view("web-views.checkout-complete");
        
        }
    }

    public function shop_cart(Request $request)
    {
        if (
            auth("customer")->check() &&
            Cart::where(["customer_id" => auth("customer")->id()])->count() > 0
        ) {
            return view("web-views.shop-cart");
        }
        Toastr::info(translate("no_items_in_basket"));
        return redirect("/");
    }

    //for seller Shop

    public function seller_shop(Request $request, $id)
    {
        $product_ids = Product::active()
            ->when($id == 0, function ($query) {
                return $query->where(["added_by" => "admin"]);
            })
            ->when($id != 0, function ($query) use ($id) {
                return $query
                    ->where(["added_by" => "seller"])
                    ->where("user_id", $id);
            })
            ->pluck("id")
            ->toArray();

        $avg_rating = Review::whereIn("product_id", $product_ids)->avg(
            "rating"
        );
        $total_review = Review::whereIn("product_id", $product_ids)->count();
        $total_order = OrderDetail::whereIn("product_id", $product_ids)
            ->groupBy("order_id")
            ->count();

        //finding category ids
        $products = Product::whereIn("id", $product_ids)->paginate(12);

        $category_info = [];
        foreach ($products as $product) {
            array_push($category_info, $product["category_ids"]);
        }

        $category_info_decoded = [];
        foreach ($category_info as $info) {
            array_push($category_info_decoded, json_decode($info));
        }

        $category_ids = [];
        foreach ($category_info_decoded as $decoded) {
            foreach ($decoded as $info) {
                array_push($category_ids, $info->id);
            }
        }

        $categories = [];
        foreach ($category_ids as $category_id) {
            $category = Category::with(["childes.childes"])
                ->where("position", 0)
                ->find($category_id);
            if ($category != null) {
                array_push($categories, $category);
            }
        }
        $categories = array_unique($categories);
        //end

        //products search
        if ($request->product_name) {
            $products = Product::active()
                ->when($id == 0, function ($query) {
                    return $query->where(["added_by" => "admin"]);
                })
                ->when($id != 0, function ($query) use ($id) {
                    return $query
                        ->where(["added_by" => "seller"])
                        ->where("user_id", $id);
                })
                ->where("name", "like", $request->product_name . "%")
                ->paginate(12);
        } elseif ($request->category_id) {
            $products = Product::active()
                ->when($id == 0, function ($query) {
                    return $query->where(["added_by" => "admin"]);
                })
                ->when($id != 0, function ($query) use ($id) {
                    return $query
                        ->where(["added_by" => "seller"])
                        ->where("user_id", $id);
                })
                ->whereJsonContains("category_ids", [
                    ["id" => strval($request->category_id)],
                ])
                ->paginate(12);
        }

        if ($id == 0) {
            $shop = [
                "id" => 0,
                "name" => Helpers::get_business_settings("company_name"),
            ];
        } else {
            $shop = Shop::where("seller_id", $id)->first();
            if (isset($shop) == false) {
                Toastr::error(translate("shop_does_not_exist"));
                return back();
            }
        }

        return view(
            "web-views.shop-page",
            compact("products", "shop", "categories")
        )
            ->with("seller_id", $id)
            ->with("total_review", $total_review)
            ->with("avg_rating", $avg_rating)
            ->with("total_order", $total_order);
    }

    public function seller_shop_product(Request $request, $id)
    {
        $products = Product::active()
            ->with("shop")
            ->where(["added_by" => "seller"])
            ->where("user_id", $id)
            ->whereJsonContains("category_ids", [
                ["id" => strval($request->category_id)],
            ])
            ->paginate(12);
        $shop = Shop::where("seller_id", $id)->first();
        if ($request["sort_by"] == null) {
            $request["sort_by"] = "latest";
        }

        if ($request->ajax()) {
            return response()->json(
                [
                    "view" => view(
                        "web-views.products._ajax-products",
                        compact("products")
                    )->render(),
                ],
                200
            );
        }

        return view("web-views.shop-page", compact("products", "shop"))->with(
            "seller_id",
            $id
        );
    }

    public function quick_view(Request $request)
    {
        $product = ProductManager::get_product($request->product_id);
        $order_details = OrderDetail::where("product_id", $product->id)->get();
        $wishlists = Wishlist::where("product_id", $product->id)->get();
        $countOrder = count($order_details);
        $countWishlist = count($wishlists);
        $relatedProducts = Product::with(["reviews"])
            ->where("category_ids", $product->category_ids)
            ->where("id", "!=", $product->id)
            ->limit(12)
            ->get();
        return response()->json([
            "success" => 1,
            "view" => view(
                "web-views.partials._quick-view-data",
                compact(
                    "product",
                    "countWishlist",
                    "countOrder",
                    "relatedProducts"
                )
            )->render(),
        ]);
    }

    public function product($slug)
    {
        $product = Product::active()
            ->with(["reviews"])
            ->where("slug", $slug)
            ->first();
        if ($product != null) {
            $countOrder = OrderDetail::where(
                "product_id",
                $product->id
            )->count();
            $countWishlist = Wishlist::where(
                "product_id",
                $product->id
            )->count();
            $relatedProducts = Product::with(["reviews"])
                ->active()
                ->where("category_ids", $product->category_ids)
                ->where("id", "!=", $product->id)
                ->limit(12)
                ->get();
            $deal_of_the_day = DealOfTheDay::where("product_id", $product->id)
                ->where("status", 1)
                ->first();

            return view(
                "web-views.products.details",
                compact(
                    "product",
                    "countWishlist",
                    "countOrder",
                    "relatedProducts",
                    "deal_of_the_day"
                )
            );
        }

        Toastr::error(translate("not_found"));
        return back();
    }

    public function products(Request $request)
    {
        if (auth("customer")->check()) {   
        $request["sort_by"] == null
            ? $request["sort_by"] == "latest"
            : $request["sort_by"];

        $porduct_data = Product::active()->with(["reviews"]);

        if ($request["data_from"] == "category") {
            $products = $porduct_data->get();
            $product_ids = [];
            foreach ($products as $product) {
                foreach (
                    json_decode($product["category_ids"], true)
                    as $category
                ) {
                    if ($category["id"] == $request["id"]) {
                        array_push($product_ids, $product["id"]);
                    }
                }
            }
            $query = $porduct_data->whereIn("id", $product_ids);
        }

        if ($request["data_from"] == "brand") {
            $query = $porduct_data->where("brand_id", $request["id"]);
        }

        if ($request["data_from"] == "latest") {
            $query = $porduct_data->orderBy("id", "DESC");
        }

        if ($request["data_from"] == "top-rated") {
            $reviews = Review::select(
                "product_id",
                DB::raw("AVG(rating) as count")
            )
                ->groupBy("product_id")
                ->orderBy("count", "desc")
                ->get();
            $product_ids = [];
            foreach ($reviews as $review) {
                array_push($product_ids, $review["product_id"]);
            }
            $query = $porduct_data->whereIn("id", $product_ids);
        }

        if ($request["data_from"] == "best-selling") {
            $details = OrderDetail::with("product")
                ->select("product_id", DB::raw("COUNT(product_id) as count"))
                ->groupBy("product_id")
                ->orderBy("count", "desc")
                ->get();
            $product_ids = [];
            foreach ($details as $detail) {
                array_push($product_ids, $detail["product_id"]);
            }
            $query = $porduct_data->whereIn("id", $product_ids);
        }

        if ($request["data_from"] == "most-favorite") {
            $details = Wishlist::with("product")
                ->select("product_id", DB::raw("COUNT(product_id) as count"))
                ->groupBy("product_id")
                ->orderBy("count", "desc")
                ->get();
            $product_ids = [];
            foreach ($details as $detail) {
                array_push($product_ids, $detail["product_id"]);
            }
            $query = $porduct_data->whereIn("id", $product_ids);
        }

        if ($request["data_from"] == "featured") {
            $query = Product::with(["reviews"])
                ->active()
                ->where("featured", 1);
        }

        if ($request["data_from"] == "search") {
            $key = explode(" ", $request["name"]);
            $query = $porduct_data->where(function ($q) use ($key) {
                foreach ($key as $value) {
                    $q->orWhere("name", "like", "%{$value}%");
                }
            });
        }

        if ($request["data_from"] == "discounted") {
            $query = Product::with(["reviews"])
                ->active()
                ->where("discount", "!=", 0);
        }

        if ($request["sort_by"] == "latest") {
            $fetched = $query->latest();
        } elseif ($request["sort_by"] == "low-high") {
            $fetched = $query->orderBy("unit_price", "ASC");
        } elseif ($request["sort_by"] == "high-low") {
            $fetched = $query->orderBy("unit_price", "DESC");
        } elseif ($request["sort_by"] == "a-z") {
            $fetched = $query->orderBy("name", "ASC");
        } elseif ($request["sort_by"] == "z-a") {
            $fetched = $query->orderBy("name", "DESC");
        } else {
            $fetched = $query;
        }

        if ($request["min_price"] != null || $request["max_price"] != null) {
            $fetched = $fetched->whereBetween("unit_price", [
                Helpers::convert_currency_to_usd($request["min_price"]),
                Helpers::convert_currency_to_usd($request["max_price"]),
            ]);
        }

        $data = [
            "id" => $request["id"],
            "name" => $request["name"],
            "data_from" => $request["data_from"],
            "sort_by" => $request["sort_by"],
            "page_no" => $request["page"],
            "min_price" => $request["min_price"],
            "max_price" => $request["max_price"],
        ];

        $products = $fetched->paginate(20)->appends($data);

        if ($request->ajax()) {
            return response()->json(
                [
                    "view" => view(
                        "web-views.products._ajax-products",
                        compact("products")
                    )->render(),
                ],
                200
            );
        }
        if ($request["data_from"] == "category") {
            $data["brand_name"] = Category::find((int) $request["id"])->name;
        }
        if ($request["data_from"] == "brand") {
            $data["brand_name"] = Brand::find((int) $request["id"])->name;
        }

        return view(
            "web-views.products.view",
            compact("products", "data"),
            $data
        );
        
        }
        else{
            session()->put('keep_return_url', url()->previous());
            $custome_recaptcha = new CaptchaBuilder;
            $custome_recaptcha->build();
            Session::put('custome_recaptcha', $custome_recaptcha->getPhrase());
            return view('customer-view.auth.login', compact('custome_recaptcha'));
        }
    }

    public function discounted_products(Request $request)
    {
        $request["sort_by"] == null
            ? $request["sort_by"] == "latest"
            : $request["sort_by"];

        $porduct_data = Product::active()->with(["reviews"]);

        if ($request["data_from"] == "category") {
            $products = $porduct_data->get();
            $product_ids = [];
            foreach ($products as $product) {
                foreach (
                    json_decode($product["category_ids"], true)
                    as $category
                ) {
                    if ($category["id"] == $request["id"]) {
                        array_push($product_ids, $product["id"]);
                    }
                }
            }
            $query = $porduct_data->whereIn("id", $product_ids);
        }

        if ($request["data_from"] == "brand") {
            $query = $porduct_data->where("brand_id", $request["id"]);
        }

        if ($request["data_from"] == "latest") {
            $query = $porduct_data->orderBy("id", "DESC");
        }

        if ($request["data_from"] == "top-rated") {
            $reviews = Review::select(
                "product_id",
                DB::raw("AVG(rating) as count")
            )
                ->groupBy("product_id")
                ->orderBy("count", "desc")
                ->get();
            $product_ids = [];
            foreach ($reviews as $review) {
                array_push($product_ids, $review["product_id"]);
            }
            $query = $porduct_data->whereIn("id", $product_ids);
        }

        if ($request["data_from"] == "best-selling") {
            $details = OrderDetail::with("product")
                ->select("product_id", DB::raw("COUNT(product_id) as count"))
                ->groupBy("product_id")
                ->orderBy("count", "desc")
                ->get();
            $product_ids = [];
            foreach ($details as $detail) {
                array_push($product_ids, $detail["product_id"]);
            }
            $query = $porduct_data->whereIn("id", $product_ids);
        }

        if ($request["data_from"] == "most-favorite") {
            $details = Wishlist::with("product")
                ->select("product_id", DB::raw("COUNT(product_id) as count"))
                ->groupBy("product_id")
                ->orderBy("count", "desc")
                ->get();
            $product_ids = [];
            foreach ($details as $detail) {
                array_push($product_ids, $detail["product_id"]);
            }
            $query = $porduct_data->whereIn("id", $product_ids);
        }

        if ($request["data_from"] == "featured") {
            $query = Product::with(["reviews"])
                ->active()
                ->where("featured", 1);
        }

        if ($request["data_from"] == "search") {
            $key = explode(" ", $request["name"]);
            $query = $porduct_data->where(function ($q) use ($key) {
                foreach ($key as $value) {
                    $q->orWhere("name", "like", "%{$value}%");
                }
            });
        }

        if ($request["data_from"] == "discounted_products") {
            $query = Product::with(["reviews"])
                ->active()
                ->where("discount", "!=", 0);
        }

        if ($request["sort_by"] == "latest") {
            $fetched = $query->latest();
        } elseif ($request["sort_by"] == "low-high") {
            return "low";
            $fetched = $query->orderBy("unit_price", "ASC");
        } elseif ($request["sort_by"] == "high-low") {
            $fetched = $query->orderBy("unit_price", "DESC");
        } elseif ($request["sort_by"] == "a-z") {
            $fetched = $query->orderBy("name", "ASC");
        } elseif ($request["sort_by"] == "z-a") {
            $fetched = $query->orderBy("name", "DESC");
        } else {
            $fetched = $query;
        }

        if ($request["min_price"] != null || $request["max_price"] != null) {
            $fetched = $fetched->whereBetween("unit_price", [
                Helpers::convert_currency_to_usd($request["min_price"]),
                Helpers::convert_currency_to_usd($request["max_price"]),
            ]);
        }

        $data = [
            "id" => $request["id"],
            "name" => $request["name"],
            "data_from" => $request["data_from"],
            "sort_by" => $request["sort_by"],
            "page_no" => $request["page"],
            "min_price" => $request["min_price"],
            "max_price" => $request["max_price"],
        ];

        $products = $fetched->paginate(5)->appends($data);

        if ($request->ajax()) {
            return response()->json(
                [
                    "view" => view(
                        "web-views.products._ajax-products",
                        compact("products")
                    )->render(),
                ],
                200
            );
        }
        if ($request["data_from"] == "category") {
            $data["brand_name"] = Category::find((int) $request["id"])->name;
        }
        if ($request["data_from"] == "brand") {
            $data["brand_name"] = Brand::find((int) $request["id"])->name;
        }

        return view(
            "web-views.products.view",
            compact("products", "data"),
            $data
        );
    }

    public function viewWishlist()
    {
        $wishlists = Wishlist::where(
            "customer_id",
            auth("customer")->id()
        )->get();
        return view(
            "web-views.users-profile.account-wishlist",
            compact("wishlists")
        );
    }

    public function storeWishlist(Request $request)
    {
        if ($request->ajax()) {
            if (auth("customer")->check()) {
                $wishlist = Wishlist::where(
                    "customer_id",
                    auth("customer")->id()
                )
                    ->where("product_id", $request->product_id)
                    ->first();
                if (empty($wishlist)) {
                    $wishlist = new Wishlist();
                    $wishlist->customer_id = auth("customer")->id();
                    $wishlist->product_id = $request->product_id;
                    $wishlist->save();

                    $countWishlist = Wishlist::where(
                        "customer_id",
                        auth("customer")->id()
                    )->get();
                    $data = "Product has been added to wishlist";

                    $product_count = Wishlist::where([
                        "product_id" => $request->product_id,
                    ])->count();
                    session()->put(
                        "wish_list",
                        Wishlist::where(
                            "customer_id",
                            auth("customer")->user()->id
                        )
                            ->pluck("product_id")
                            ->toArray()
                    );
                    return response()->json([
                        "success" => $data,
                        "value" => 1,
                        "count" => count($countWishlist),
                        "id" => $request->product_id,
                        "product_count" => $product_count,
                    ]);
                } else {
                    $data = "Product already added to wishlist";
                    return response()->json(["error" => $data, "value" => 2]);
                }
            } else {
                $data = translate("login_first");
                return response()->json(["error" => $data, "value" => 0]);
            }
        }
    }

    public function deleteWishlist(Request $request)
    {
        Wishlist::where([
            "product_id" => $request["id"],
            "customer_id" => auth("customer")->id(),
        ])->delete();
        $data = "Product has been remove from wishlist!";
        $wishlists = Wishlist::where(
            "customer_id",
            auth("customer")->id()
        )->get();
        session()->put(
            "wish_list",
            Wishlist::where("customer_id", auth("customer")->user()->id)
                ->pluck("product_id")
                ->toArray()
        );
        return response()->json([
            "success" => $data,
            "count" => count($wishlists),
            "id" => $request->id,
            "wishlist" => view(
                "web-views.partials._wish-list-data",
                compact("wishlists")
            )->render(),
        ]);
    }

    //for HelpTopic
    public function helpTopic()
    {
        $helps = HelpTopic::Status()
            ->latest()
            ->get();
        return view("web-views.help-topics", compact("helps"));
    }

    //for Contact US Page
    public function contacts()
    {
        return view("web-views.contacts");
    }

    public function about_us()
    {
        $about_us = BusinessSetting::where("type", "about_us")->first();
        return view("web-views.about-us", [
            "about_us" => $about_us,
        ]);
    }

    public function termsandCondition()
    {
        $terms_condition = BusinessSetting::where(
            "type",
            "terms_condition"
        )->first();
        return view("web-views.terms", compact("terms_condition"));
    }

    public function privacy_policy()
    {
        $privacy_policy = BusinessSetting::where(
            "type",
            "privacy_policy"
        )->first();
        return view("web-views.privacy-policy", compact("privacy_policy"));
    }

    //order Details

    public function orderdetails()
    {
        return view("web-views.orderdetails");
    }

    public function chat_for_product(Request $request)
    {
        return $request->all();
    }

    public function supportChat()
    {
        return view("web-views.users-profile.profile.supportTicketChat");
    }

    public function error()
    {
        return view("web-views.404-error-page");
    }

    public function contact_store(Request $request)
    {
        $request->validate(
            [
                "mobile_number" => "required",
                "subject" => "required",
                "message" => "required",
            ],
            [
                "mobile_number.required" => "Mobile Number is Empty!",
                "subject.required" => " Subject is Empty!",
                "message.required" => "Message is Empty!",
            ]
        );
        $contact = new Contact();
        $contact->name = $request->name;
        $contact->email = $request->email;
        $contact->mobile_number = $request->mobile_number;
        $contact->subject = $request->subject;
        $contact->message = $request->message;
        $contact->save();
        Toastr::success(translate("Your Message Send Successfully"));
        return back();
    }

    public function order_note(Request $request)
    {
        if ($request->has("order_note")) {
            session::put("order_note", $request->order_note);
        }
        return response()->json();
    }
    public function order_collection_date(Request $request)
    {
        if ($request->has("order_collection_date")) {
            session::put("order_collection_date", $request->order_collection_date);
        }
        return response()->json();
    }
    public function order_collection_time(Request $request)
    {
        if ($request->has("order_collection_time")) {
            session::put("order_collection_time", $request->order_collection_time);
        }
        return response()->json();
    }
}
