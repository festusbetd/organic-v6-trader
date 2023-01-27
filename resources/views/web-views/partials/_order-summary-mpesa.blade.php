<style>
    .cart_title {
        font-weight: 400 !important;
        font-size: 16px;
    }

    .cart_value {
        font-weight: 600 !important;
        font-size: 16px;
    }

    .cart_total_value {
        font-weight: 700 !important;
        font-size: 25px !important;
        color: {{$web_config['primary_color']}}     !important;
    }
</style>

<aside class="col-lg-4 pt-4 pt-lg-0">
    <div class="cart_total">
        @php($sub_total=0)
        @php($total_tax=0)
        @php($total_shipping_cost=0)
        @php($total_discount_on_product=0)
        @php($cart=\App\CPU\CartManager::get_cart())
        @php($shipping_cost=\App\CPU\CartManager::get_shipping_cost())
        @if($cart->count() > 0)
            @foreach($cart as $key => $cartItem)
                @php($sub_total+=$cartItem['price']*$cartItem['quantity'])
                @php($total_tax+=$cartItem['tax']*$cartItem['quantity'])
                @php($total_discount_on_product+=$cartItem['discount']*$cartItem['quantity'])
            @endforeach
            @php($total_shipping_cost=$shipping_cost)
        @else
            <span>Empty Cart</span>
        @endif
        <div class="d-flex justify-content-between">
            <span class="cart_title">Sub Total</span>
            <span class="cart_value">
                {{\App\CPU\Helpers::currency_converter($sub_total)}}
            </span>
        </div>
        <div class="d-flex justify-content-between">
            <span class="cart_title">Tax</span>
            <span class="cart_value">
                {{\App\CPU\Helpers::currency_converter($total_tax)}}
            </span>
        </div>
        <div class="d-flex justify-content-between">
            <span class="cart_title">Shipping</span>
            <span class="cart_value">
                {{\App\CPU\Helpers::currency_converter($total_shipping_cost)}}
            </span>
        </div>
        <div class="d-flex justify-content-between">
            <span class="cart_title">Discount on Product</span>
            <span class="cart_value">
                - {{\App\CPU\Helpers::currency_converter($total_discount_on_product)}}
            </span>
        </div>
        @if(session()->has('coupon_discount'))
            <div class="d-flex justify-content-between">
                <span class="cart_title">Coupon Discount</span>
                <span class="cart_value" id="coupon-discount-amount">
                    - {{session()->has('coupon_discount')?\App\CPU\Helpers::currency_converter(session('coupon_discount')):0}}
                </span>
            </div>
            @php($coupon_dis=session('coupon_discount'))
        @else

            @php($coupon_dis=0)
        @endif

        @php($config=\App\CPU\Helpers::get_business_settings('mpesa_pay'))
        @php($user=auth('customer')->user())
    
        @php($data = new \stdClass())
    
        @php($data->detail = 'payment')
        @php($data->order_id = session('cart_group_id'))
   
        @php($data->name = $user->f_name.' '.$user->l_name)
        @php($data->email = $user->email)
        @php($data->phone = $user->phone)
    

          <div class="d-flex justify-content-between">
                <span class="cart_title">Phone Number</span>
                <span class="cart_value" id="coupon-discount-amount"> {{$data->phone}}</span>
            </div>
          

        <hr class="mt-2 mb-2">


        <div class="d-flex justify-content-center">
            <span class="cart_total_value mt-2">
             Total   {{\App\CPU\Helpers::currency_converter($sub_total+$total_tax+$total_shipping_cost-$coupon_dis-$total_discount_on_product)}}
            </span>
        </div>
    </div>
    <div class="container mt-3">
        <div class="row p-0">
            <div class="col-md-3 p-0 text-center mobile-padding">
                <img style="height: 29px;" src="{{asset("public/assets/front-end/png/delivery.png")}}" alt="">
                <div class="deal-title">3 Days <br><span>Fast Delivery</span></div>
            </div>

            <div class="col-md-3 p-0 text-center">
                <img style="height: 29px;" src="{{asset("public/assets/front-end/png/money.png")}}" alt="">
                <div class="deal-title">Money Back <br><span>Gurrantey</span></div>
            </div>

            <div class="col-md-3 p-0 text-center">
                <img style="height: 29px;" src="{{asset("public/assets/front-end/png/Genuine.png")}}" alt="">
                <div class="deal-title">100% Genuine<br><span>Product</span></div>
            </div>

            <div class="col-md-3 p-0 text-center">
                <img style="height: 29px;" src="{{asset("public/assets/front-end/png/Payment.png")}}" alt="">
                <div class="deal-title">Authentic<br><span>Payment</span></div>
            </div>
        </div>
    </div>
</aside>
