<?php
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group(['namespace' => 'api\v1', 'prefix' => 'v1', 'middleware' => ['api_lang']], function ()
{


    Route::group(['prefix' => 'auth', 'namespace' => 'auth'], function ()
    {
        Route::post('register', 'PassportAuthController@register');
        Route::post('register_trader', 'PassportAuthController@registerTrader');

        Route::post('request_pay', 'PassportAuthController@STKPushSimulation');

        Route::post('request_mpesa_callback', 'PassportAuthController@processSTKPushRequestCallback');

        Route::post('request_validation', 'PassportAuthController@validation');
        Route::post('request_confirmation', 'PassportAuthController@confirmation');

    

             //Notifications APIs
             Route::post('order_confirmation_msg', 'PassportAuthController@orderConfirmationMsg');
             Route::post('order_pending_msg', 'PassportAuthController@orderPendingMsg');
             Route::post('order_processing_msg', 'PassportAuthController@orderProcessingMsg');
             Route::post('order_delivery_msg', 'PassportAuthController@orderDeliveryMsg');
             Route::post('order_delivered_msg', 'PassportAuthController@orderDeliveredMsg');
             Route::post('order_retured_msg', 'PassportAuthController@orderReturenedMsg');
             Route::post('order_failed_msg', 'PassportAuthController@orderFailedMsg');
     
             //Email APIs
             Route::post('email_pending', 'PassportAuthController@emailPending');
             Route::post('email_confirmation', 'PassportAuthController@emailConfirmation');
             Route::post('email_processing', 'NPassportAuthController@emailProcessing');
             Route::post('email_out_for_delivery', 'PassportAuthController@emailOut_for_delivery');
             Route::post('email_delivered', 'PassportAuthController@emailDelivered');
             Route::post('email_returned', 'PassportAuthController@emailReturned');
             Route::post('email_failed', 'PassportAuthController@emailFailed');
             Route::post('email_cancelled', 'PassportAuthController@emailCancelled');

        Route::post('login', 'PassportAuthController@login');

        Route::post('login', 'PassportAuthController@login');

        Route::post('check-phone', 'PhoneVerificationController@check_phone');
        Route::post('verify-phone', 'PhoneVerificationController@verify_phone');

        Route::post('check-email', 'EmailVerificationController@check_email');
        Route::post('verify-email', 'EmailVerificationController@verify_email');

        Route::post('forgot-password', 'ForgotPassword@reset_password_request');
        Route::post('verify-otp', 'ForgotPassword@otp_verification_submit');
        Route::put('reset-password', 'ForgotPassword@reset_password_submit');

        Route::any('social-login', 'SocialAuthController@social_login');
        Route::post('update-phone', 'SocialAuthController@update_phone');
    });

    Route::group(['prefix' => 'config'], function ()
    {
        Route::get('/', 'ConfigController@configuration');
    });

    Route::group(['prefix' => 'shipping-method', 'middleware' => 'auth:api'], function ()
    {
        Route::get('detail/{id}', 'ShippingMethodController@get_shipping_method_info');
        Route::get('by-seller/{id}/{seller_is}', 'ShippingMethodController@shipping_methods_by_seller');
        Route::post('choose-for-order', 'ShippingMethodController@choose_for_order');

        Route::post('pick-locations', 'ShippingMethodController@addPickUp');
        Route::get('pick-locations', 'ShippingMethodController@getPickUp');

        Route::get('chosen', 'ShippingMethodController@chosen_shipping_methods');
    });

    Route::group(['prefix' => 'cart', 'middleware' => 'auth:api'], function ()
    {
        Route::get('/', 'CartController@cart');
        Route::post('add', 'CartController@add_to_cart');
        Route::put('update', 'CartController@update_cart');
        Route::delete('remove', 'CartController@remove_from_cart');
    });

    Route::get('faq', 'GeneralController@faq');

    Route::group(['prefix' => 'products'], function ()
    {
        Route::get('latest', 'ProductController@get_latest_products');
        Route::get('featured', 'ProductController@get_featured_products');
        Route::get('top-rated', 'ProductController@get_top_rated_products');
        Route::any('search', 'ProductController@get_searched_products');
        Route::get('details/{id}', 'ProductController@get_product');
        Route::get('related-products/{product_id}', 'ProductController@get_related_products');
        Route::get('reviews/{product_id}', 'ProductController@get_product_reviews');
        Route::get('rating/{product_id}', 'ProductController@get_product_rating');
        Route::get('counter/{product_id}', 'ProductController@counter');
        Route::get('shipping-methods', 'ProductController@get_shipping_methods');
        Route::get('social-share-link/{product_id}', 'ProductController@social_share_link');
        Route::post('reviews/submit', 'ProductController@submit_product_review')->middleware('auth:api');
        Route::get('best-sellings', 'ProductController@get_best_sellings');
        Route::get('home-categories', 'ProductController@get_home_categories');
        ROute::get('discounted-product', 'ProductController@get_discounted_product');
    });

    Route::group(['prefix' => 'notifications'], function ()
    {
        Route::get('/', 'NotificationController@get_notifications');

        //Notifications APIs
        Route::post('order_confirmation_msg', 'NotificationController@orderConfirmationMsg');
        Route::post('order_pending_msg', 'NotificationController@orderPendingMsg');
        Route::post('order_processing_msg', 'NotificationController@orderProcessingMsg');
        Route::post('order_delivery_msg', 'NotificationController@orderDeliveryMsg');
        Route::post('order_delivered_msg', 'NotificationController@orderDeliveredMsg');
        Route::post('order_retured_msg', 'NotificationController@orderReturenedMsg');
        Route::post('order_failed_msg', 'NotificationController@orderFailedMsg');

        //Email APIs
        Route::post('email_pending', 'NotificationController@emailPending');
        Route::post('email_confirmation', 'NotificationController@emailConfirmation');
        Route::post('email_processing', 'NotificationController@emailProcessing');
        Route::post('email_out_for_delivery', 'NotificationController@emailOut_for_delivery');
        Route::post('email_delivered', 'NotificationController@emailDelivered');
        Route::post('email_returned', 'NotificationController@emailReturned');
        Route::post('email_failed', 'NotificationController@emailFailed');
        Route::post('email_cancelled', 'NotificationController@emailCancelled');
    });

    Route::group(['prefix' => 'brands'], function ()
    {
        Route::get('/', 'BrandController@get_brands');
        Route::get('products/{brand_id}', 'BrandController@get_products');
    });

    Route::group(['prefix' => 'attributes'], function ()
    {
        Route::get('/', 'AttributeController@get_attributes');
    });

    Route::group(['prefix' => 'flash-deals'], function ()
    {
        Route::get('/', 'FlashDealController@get_flash_deal');
        Route::get('products/{deal_id}', 'FlashDealController@get_products');
    });

    Route::group(['prefix' => 'deals'], function ()
    {
        Route::get('featured', 'DealController@get_featured_deal');
    });

    Route::group(['prefix' => 'categories'], function ()
    {
        Route::get('/', 'CategoryController@get_categories');
        Route::get('products/{category_id}', 'CategoryController@get_products');
    });

    Route::group(['prefix' => 'customer', 'middleware' => 'auth:api'], function ()
    {
        Route::get('info', 'CustomerController@info');
        Route::put('update-profile', 'CustomerController@update_profile');
        Route::put('cm-firebase-token', 'CustomerController@update_cm_firebase_token');

        Route::group(['prefix' => 'address'], function ()
        {
            Route::get('list', 'CustomerController@address_list');
            Route::post('add', 'CustomerController@add_new_address');
            Route::delete('/', 'CustomerController@delete_address');
        });

        Route::group(['prefix' => 'support-ticket'], function ()
        {
            Route::post('create', 'CustomerController@create_support_ticket');
            Route::get('get', 'CustomerController@get_support_tickets');
            Route::get('conv/{ticket_id}', 'CustomerController@get_support_ticket_conv');
            Route::post('reply/{ticket_id}', 'CustomerController@reply_support_ticket');
        });

        Route::group(['prefix' => 'wish-list'], function ()
        {
            Route::get('/', 'CustomerController@wish_list');
            Route::post('add', 'CustomerController@add_to_wishlist');
            Route::delete('remove', 'CustomerController@remove_from_wishlist');
        });

        Route::group(['prefix' => 'order'], function ()
        {
            Route::get('list', 'CustomerController@get_order_list');
            Route::get('details', 'CustomerController@get_order_details');
            Route::get('place', 'OrderController@place_order');
        });
        // Chatting
        Route::group(['prefix' => 'chat'], function ()
        {
            Route::get('/', 'ChatController@chat_with_seller');
            Route::get('messages', 'ChatController@messages');
            Route::post('send-message', 'ChatController@messages_store');
        });
    });

    Route::group(['prefix' => 'order'], function ()
    {
        Route::get('track', 'OrderController@track_order');
    });

    Route::group(['prefix' => 'banners'], function ()
    {
        Route::get('/', 'BannerController@get_banners');
    });

    Route::group(['prefix' => 'seller'], function ()
    {
        Route::get('/', 'SellerController@get_seller_info');
        Route::get('{seller_id}/products', 'SellerController@get_seller_products');
        Route::get('top', 'SellerController@get_top_sellers');
        Route::get('all', 'SellerController@get_all_sellers');
    });

    Route::group(['prefix' => 'coupon', 'middleware' => 'auth:api'], function ()
    {
        Route::get('apply', 'CouponController@apply');
    });

    // Route::group(['prefix' => 'payments'], function ()
    // {
    //     Route::post('request_mpesa_callback', 'MpesaPaymentController@processSTKPushRequestCallback');
    //     Route::post('check_mpesa_payments', 'MpesaPaymentController@processSTKPushRequestCallback');
     
    // });

    // Route::group(['prefix' => 'payments', 'middleware' => 'auth:api'], function ()
    // {
    //     Route::get('/', 'MpesaPaymentController@index');
    //     Route::post('/', 'MpesaPaymentController@index');
 
    //     //added request_confirmation
    //     // Route::post('request_confirmation', 'MpesaPaymentController@confirmation');
    //     //added request_validation
    //     // Route::post('request_validation', 'MpesaPaymentController@validation');
    //     Route::post('register_mpesa_url', 'MpesaPaymentController@mpesa_register_url');
    //     Route::post('check_mpesa_payments', 'MpesaPaymentController@processSTKPushPayments');
    //     // Route::post('request_mpesa_callback', 'MpesaPaymentController@processSTKPushRequestCallback');

    //     Route::post('request_transaction_status', 'MpesaPaymentController@processTransactionStatusRequestCallback');
    //     Route::post('request_STK_push_query', 'MpesaPaymentController@processSTKPushQueryRequestCallback');
    //     Route::post('request_b2b', 'MpesaPaymentController@b2b');
    //     //added request_validation
    //     Route::get('get_password', 'MpesaPaymentController@lipaNaMpesaPassword');
    //     Route::get('get_mpesa_payments', 'MpesaPaymentController@getPayments');
    //     Route::get('get_mpesa_logs', 'MpesaPaymentController@getPaymentsLogs');
    //     Route::get('get_timestamp', 'MpesaPaymentController@getTimestamp');
    //     Route::post('generate_token', 'MpesaPaymentController@generateAccessToken');
    // });

    //map api
    Route::group(['prefix' => 'mapapi'], function ()
    {
        Route::get('place-api-autocomplete', 'MapApiController@place_api_autocomplete');
        Route::get('distance-api', 'MapApiController@distance_api');
        Route::get('place-api-details', 'MapApiController@place_api_details');
        Route::get('geocode-api', 'MapApiController@geocode_api');
    });
});

