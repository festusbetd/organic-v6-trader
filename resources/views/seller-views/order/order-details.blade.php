@extends('layouts.back-end.app-seller')

@section('title',\App\CPU\translate('Order Details'))

@push('css_or_js')
@endpush

@section('content')
    <!-- Page Heading -->
    <div class="content container-fluid">

        <div class="page-header d-print-none p-3" style="background: white">
            <div class="row align-items-center">
                <div class="col-sm mb-2 mb-sm-0">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb breadcrumb-no-gutter">
                            <li class="breadcrumb-item"><a class="breadcrumb-link"
                                                           href="{{route('seller.orders.list',['all'])}}">{{\App\CPU\translate('Orders')}}</a>
                            </li>
                            <li class="breadcrumb-item active"
                                aria-current="page">{{\App\CPU\translate('Order details')}}</li>
                        </ol>
                    </nav>

                    <div class="d-sm-flex align-items-sm-center">
                        <h1 class="page-header-title">{{\App\CPU\translate('Order')}} #{{$order['id']}}</h1>
                        {{-- {{ $order}} --}}
                        <input type="hidden" id="order_id" name="order_id" value="{{$order['id']}}">

                        @if($order['payment_status']=='paid')
                            <span
                                class="badge badge-soft-success {{Session::get('direction') === "rtl" ? 'mr-sm-3' : 'ml-sm-3'}}">
                            <span class="legend-indicator bg-success"
                                  style="{{Session::get('direction') === "rtl" ? 'margin-right: 0;margin-left: .4375rem;' : 'margin-left: 0;margin-right: .4375rem;'}}"></span>{{\App\CPU\translate('Paid')}}
                        </span>
                        @else
                            <span
                                class="badge badge-soft-danger {{Session::get('direction') === "rtl" ? 'mr-sm-3' : 'ml-sm-3'}}">
                            <span class="legend-indicator bg-danger"
                                  style="{{Session::get('direction') === "rtl" ? 'margin-right: 0;margin-left: .4375rem;' : 'margin-left: 0;margin-right: .4375rem;'}}"></span>{{\App\CPU\translate('Unpaid')}}
                        </span>
                        @endif

                        @if($order['order_status']=='pending')
                            <span
                                class="badge badge-soft-info {{Session::get('direction') === "rtl" ? 'mr-2 mr-sm-3' : 'ml-2 ml-sm-3'}} text-capitalize">
                          <span class="legend-indicator bg-info text"
                                style="{{Session::get('direction') === "rtl" ? 'margin-right: 0;margin-left: .4375rem;' : 'margin-left: 0;margin-right: .4375rem;'}}"></span>{{str_replace('_',' ',$order['order_status'])}}
                        </span>
                        @elseif($order['order_status']=='failed')
                            <span
                                class="badge badge-danger {{Session::get('direction') === "rtl" ? 'mr-2 mr-sm-3' : 'ml-2 ml-sm-3'}} text-capitalize">
                          <span class="legend-indicator bg-info"
                                style="{{Session::get('direction') === "rtl" ? 'margin-right: 0;margin-left: .4375rem;' : 'margin-left: 0;margin-right: .4375rem;'}}"></span>{{str_replace('_',' ',$order['order_status'])}}
                        </span>
                        @elseif($order['order_status']=='processing' || $order['order_status']=='out_for_delivery')
                            <span class="badge badge-soft-warning ml-2 ml-sm-3 text-capitalize">
                              <span class="legend-indicator bg-warning"></span>{{str_replace('_',' ',$order['order_status'])}}
                            </span>

                        @elseif($order['order_status']=='delivered' || $order['order_status']=='confirmed')
                            <span class="badge badge-soft-success ml-2 ml-sm-3 text-capitalize">
                              <span class="legend-indicator bg-success"></span>{{str_replace('_',' ',$order['order_status'])}}
                            </span>
                        @else
                            <span
                                class="badge badge-soft-danger {{Session::get('direction') === "rtl" ? 'mr-2 mr-sm-3' : 'ml-2 ml-sm-3'}} text-capitalize">
                          <span class="legend-indicator bg-danger"
                                style="{{Session::get('direction') === "rtl" ? 'margin-right: 0;margin-left: .4375rem;' : 'margin-left: 0;margin-right: .4375rem;'}}"></span>{{str_replace('_',' ',$order['order_status'])}}
                        </span>
                        @endif
                        <span class="{{Session::get('direction') === "rtl" ? 'mr-2 mr-sm-3' : 'ml-2 ml-sm-3'}}">
                                <i class="tio-date-range"></i> {{date('d M Y H:i:s',strtotime($order['created_at']))}}
                        </span>
                        @if(\App\CPU\Helpers::get_business_settings('order_verification'))
                            <span class="ml-2 ml-sm-3">
                                <b>
                                    {{\App\CPU\translate('order_verification_code')}} : {{$order['verification_code']}}
                                </b>
                                
                 
                 
                            </span>
                        @endif

                        @if($shipping_method!='inhouse_shipping')
                            <div class="hs-unfold ml-2">
                                <select class="form-control" name="delivery_man_id"
                                        onchange="addDeliveryMan(this.value)">
                                    <option
                                        value="0">{{\App\CPU\translate('select')}} {{\App\CPU\translate('deliveryman')}}</option>
                                    @foreach($delivery_men as $deliveryMan)
                                        <option
                                            value="{{$deliveryMan['id']}}" {{$order['delivery_man_id']==$deliveryMan['id']?'selected':''}}>
                                            {{$deliveryMan['f_name'].' '.$deliveryMan['l_name']}}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                        @endif
                    </div>

                    <div class="col-md-6 mt-2">
                        <a class="text-body" target="_blank"
                           href={{route('seller.orders.generate-invoice',[$order->id])}}>
                            <i class="tio-print"></i> {{\App\CPU\translate('Print invoice')}}
                        </a>
                        @if (isset($shipping_address['latitude']) && isset($shipping_address['longitude']))
                            <button class="btn btn-xs btn-secondary" data-toggle="modal" data-target="#locationModal"><i
                                    class="tio-map"></i> {{\App\CPU\translate('show_locations_on_map')}}</button>
                        @else
                            <button class="btn btn-xs btn-warning"><i
                                    class="tio-map"></i> {{\App\CPU\translate('no_location_found')}}</button>
                        @endif
                    </div>


                    <div class="row">
                        <div class="col-6 mt-4">
                        </div>
                        <div class="col-6">
                            <div class="hs-unfold float-right">
                                <div class="dropdown">
                                    <select name="order_status" onchange="order_status(this.value)"
                                            class="status form-control"
                                            data-id="{{$order['id']}}">

                                        <option
                                            value="pending" {{$order->order_status == 'pending'?'selected':''}} > {{\App\CPU\translate('Pending')}}</option>
                                        <option
                                            value="confirmed" {{$order->order_status == 'confirmed'?'selected':''}} > {{\App\CPU\translate('Confirmed')}}</option>
                                        <option
                                            value="processing" {{$order->order_status == 'processing'?'selected':''}} >{{\App\CPU\translate('Processing')}} </option>

                                        @if( isset($order->shipping) && $order->shipping->creator_type != 'admin')
                                            <option
                                                value="out_for_delivery" {{$order->order_status == 'out_for_delivery'?'selected':''}} >{{\App\CPU\translate('out_for_delivery')}} </option>
                                            <option
                                                value="delivered" {{$order->order_status == 'delivered'?'selected':''}} >{{\App\CPU\translate('Delivered')}} </option>
                                            <option
                                                value="returned" {{$order->order_status == 'returned'?'selected':''}} > {{\App\CPU\translate('Returned')}}</option>
                                            <option
                                                value="failed" {{$order->order_status == 'failed'?'selected':''}} >{{\App\CPU\translate('Failed')}} </option>
                                            <option
                                                value="canceled" {{$order->order_status == 'canceled'?'selected':''}} >{{\App\CPU\translate('Canceled')}} </option>
                                        @endif
                                    </select>
                                </div>
                            </div>

                            @if($order['payment_method']=='cash_on_delivery' && $shipping_method=='sellerwise_shipping')
                                <div class="hs-unfold float-right pr-2">
                                    <div class="dropdown">
                                        <select name="payment_status" class="payment_status form-control"
                                                data-id="{{$order['id']}}">
                                            <option
                                                onclick="route_alert('{{route('admin.orders.payment-status',['id'=>$order['id'],'payment_status'=>'paid'])}}','{{\App\CPU\translate('Change status to paid')}} ?')"
                                                href="javascript:"
                                                value="paid" {{$order->payment_status == 'paid'?'selected':''}} >
                                                {{\App\CPU\translate('Paid')}}
                                            </option>
                                            <option
                                                value="unpaid" {{$order->payment_status == 'unpaid'?'selected':''}} >
                                                {{\App\CPU\translate('Unpaid')}}
                                            </option>
                                        </select>
                                    </div>
                                </div>
                            @endif
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="row" id="printableArea">
            <div class="col-lg-8 mb-3  mb-lg-0">
                <!-- Card -->
                <div class="card mb-3  mb-lg-5"
                     style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">
                    <!-- Header -->
                    <div class="card-header" style="display: block!important;">
                        <div class="row">
                            <div class="col-12 pb-2 border-bottom">
                                <h4 class="card-header-title">
                                    {{\App\CPU\translate('Order details')}}
                                    <span
                                        class="badge badge-soft-dark rounded-circle {{Session::get('direction') === "rtl" ? 'mr-1' : 'ml-1'}}">{{$order->details->count()}}</span>
                                </h4>
                            </div>

                            <div class="col-6 pt-2">
                                @if ($order->order_note !=null)
                                    <span class="font-weight-bold text-capitalize">
                                        {{\App\CPU\translate('order_note')}} :
                                    </span>
                                    <p class="pl-1">
                                        {{$order->order_note}}
                                    </p>
                                @endif
                            </div>
                            <div class="col-6 pt-2">
                                <div class="flex-end">
                                    <h6 class="text-capitalize"
                                        style="color: #8a8a8a;">{{\App\CPU\translate('payment_method')}} :</h6>
                                    <h6 class="mx-1"
                                        style="color: #8a8a8a;">{{str_replace('_',' ',$order['payment_method'])}}</h6>
                                </div>
                                <div class="flex-end">
                                    <h6 style="color: #8a8a8a;">{{\App\CPU\translate('Payment')}} {{\App\CPU\translate('reference')}}
                                        :</h6>
                                    <h6 class="mx-1"
                                        style="color: #8a8a8a;">{{str_replace('_',' ',$order['transaction_ref'])}}</h6>
                                        <input type="hidden" id="product_total_cost" name="product_total_cost" value="{{$order['product_total_cost']}}">

                                </div>
                                <div class="flex-end">
                                    <h6 style="color: #8a8a8a;">{{\App\CPU\translate('shipping')}} {{\App\CPU\translate('method')}}
                                        :</h6>
                                    <h6 class="mx-1" style="color: #8a8a8a;">{{$order->shipping->title??""}}</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Header -->

                    <!-- Body -->
                    <div class="card-body">
                        <div class="media">
                            <div class="avatar avatar-xl {{Session::get('direction') === "rtl" ? 'ml-3' : 'mr-3'}}">
                                <p>{{\App\CPU\translate('image')}}</p>
                            </div>

                            <div class="media-body">
                                <div class="row">
                                    <div class="col-md-4 product-name">
                                        <p> {{\App\CPU\translate('Name')}}</p>
                                    </div>

                                    <div class="col col-md-2 align-self-center p-0 ">
                                        <p> {{\App\CPU\translate('price')}}</p>
                                    </div>

                                    <div class="col col-md-1 align-self-center">
                                        <p>{{\App\CPU\translate('Q')}}</p>
                                    </div>
                                    <div class="col col-md-1 align-self-center  p-0 product-name">
                                        <p> {{\App\CPU\translate('TAX')}}</p>
                                    </div>
                                    <div class="col col-md-2 align-self-center  p-0 product-name">
                                        <p> {{\App\CPU\translate('Discount')}}</p>
                                    </div>
                                    <div
                                        class="col col-md-2 align-self-center text-{{Session::get('direction') === "rtl" ? 'left' : 'right'}}">
                                        <p> {{\App\CPU\translate('Subtotal')}}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    @php($subtotal=0)
                    @php($total=0)
                    @php($shipping=0)
                    @php($discount=0)
                    @php($tax=0)

                    @foreach($order->details as $detail)
                        @if($detail->product)
                                <div class="media">
                                    <div class="avatar avatar-xl {{Session::get('direction') === "rtl" ? 'ml-3' : 'mr-3'}}">
                                        <img class="img-fluid"
                                             onerror="this.src='{{asset('public/assets/front-end/img/image-place-holder.png')}}'"
                                             src="{{\App\CPU\ProductManager::product_image_path('thumbnail')}}/{{$detail->product['thumbnail']}}"
                                             alt="Image Description">
                                    </div>

                                    <div class="media-body">
                                        <div class="row">
                                            <div class="col-md-4 mb-3 mb-md-0 product-name">
                                                <p>
                                                    {{substr($detail->product['name'],0,10)}}{{strlen($detail->product['name'])>10?'...':''}}
                                                </p>
                                                <input type="hidden" id="detail_name" name="detail_name" value="{{$detail->product['name']}}">
                     
                                                <strong><u>{{\App\CPU\translate('variation')}} : </u></strong>

                                                <div class="font-size-sm text-body">
                                                    <span class="font-weight-bold">{{$detail['variant']}}</span>
                                                </div>
                                            </div>

                                            <div class="col col-md-2 align-self-center p-0 ">
                                                <h6>{{\App\CPU\BackEndHelper::set_symbol(\App\CPU\BackEndHelper::usd_to_currency($detail['price']))}}</h6>
                                                <input type="hidden" id="detail_price" name="detail_price" value="{{$detail['price']}}">
                                            </div>

                                            <div class="col col-md-1 align-self-center">

                                                <h5>{{$detail->qty}}</h5>
                                                <input type="hidden" id="detail_qty" name="detail_qty" value="{{$detail->qty}}">
                                            </div>
                                            <div class="col col-md-1 align-self-center  p-0 product-name">

                                                <h5>{{\App\CPU\BackEndHelper::set_symbol(\App\CPU\BackEndHelper::usd_to_currency($detail['tax']))}}</h5>
                                                
                                            </div>
                                            <div class="col col-md-2 align-self-center  p-0 product-name">
                                                <h5>{{\App\CPU\BackEndHelper::set_symbol(\App\CPU\BackEndHelper::usd_to_currency($detail['discount']))}}</h5>
                                            </div>


                                            <div
                                                class="col col-md-2 align-self-center text-{{Session::get('direction') === "rtl" ? 'left' : 'right'}}">
                                                @php($subtotal=$detail['price']*$detail->qty+$detail['tax']-$detail['discount'])

                                                <h5>{{\App\CPU\BackEndHelper::set_symbol(\App\CPU\BackEndHelper::usd_to_currency($subtotal))}}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            @php($discount+=$detail['discount'])
                            @php($tax+=$detail['tax'])
                            @php($shipping+=$detail->shipping ? $detail->shipping->cost :0)

                            @php($total+=$subtotal)
                            <!-- End Media -->
                                <hr>
                            @endif
                        @endforeach
                        @php($shipping=$order['shipping_cost'])
                        <input type="hidden" id="shipping_cost" name="shipping_cost" value="{{$order['shipping_cost']}}">
                        @php($coupon_discount=$order['discount_amount'])
                        <div class="row justify-content-md-end mb-3">
                            <div class="col-md-9 col-lg-8">
                                <dl class="row text-sm-right">
                                    <dt class="col-sm-6">{{\App\CPU\translate('Shipping')}}</dt>
                                    <dd class="col-sm-6 border-bottom">
                                        <strong>{{\App\CPU\BackEndHelper::set_symbol(\App\CPU\BackEndHelper::usd_to_currency($shipping))}}</strong>
                                    </dd>

                                    <dt class="col-sm-6">{{\App\CPU\translate('coupon_discount')}}</dt>
                                    <dd class="col-sm-6 border-bottom">
                                        <strong>- {{\App\CPU\BackEndHelper::set_symbol(\App\CPU\BackEndHelper::usd_to_currency($coupon_discount))}}</strong>
                                    </dd>

                                    <dt class="col-sm-6">{{\App\CPU\translate('Total')}}</dt>
                                    <dd class="col-sm-6">
                                        <strong>{{\App\CPU\BackEndHelper::set_symbol(\App\CPU\BackEndHelper::usd_to_currency($total+$shipping-$coupon_discount))}}</strong>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>


            </div>

            <div class="col-lg-4">
                <!-- Card -->
                <div class="card">
           
                    <div class="card-header">
                        <h4 class="card-header-title">{{\App\CPU\translate('Customer')}}</h4>
                    </div>
                    <!-- End Header -->

                    <!-- Body -->
                    @if($order->customer)

                        <div class="card-body"
                             style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">
                            <div class="media align-items-center" href="javascript:">
                                <div
                                    class="avatar avatar-circle {{Session::get('direction') === "rtl" ? 'ml-3' : 'mr-3'}}">
                                    <img
                                        class="avatar-img"
                                        onerror="this.src='{{asset('public/assets/front-end/img/image-place-holder.png')}}'"
                                        src="{{asset('storage/app/public/profile/'.$order->customer->image)}}"
                                        alt="Image Description">
                                </div>
                                <div class="media-body">
                            <span
                                class="text-body text-hover-primary">{{$order->customer['f_name'].' '.$order->customer['l_name']}}</span>
                                </div>
                                <div class="media-body text-right">
                                    {{--<i class="tio-chevron-right text-body"></i>--}}
                                </div>
                            </div>

                            <hr>

                            <div class="media align-items-center" href="javascript:">
                                <div
                                    class="icon icon-soft-info icon-circle {{Session::get('direction') === "rtl" ? 'ml-3' : 'mr-3'}}">
                                    <i class="tio-shopping-basket-outlined"></i>
                                </div>
                                <div class="media-body">
                                    <span
                                        class="text-body text-hover-primary"> {{\App\Model\Order::where('customer_id',$order['customer_id'])->count()}} {{\App\CPU\translate('orders')}}</span>
                                </div>
                                <div class="media-body text-right">
                                    {{--<i class="tio-chevron-right text-body"></i>--}}
                                </div>
                            </div>

                            <hr>

                            <div class="d-flex justify-content-between align-items-center">
                                <h5>{{\App\CPU\translate('Contact info')}}</h5>
                            </div>

                            <div class="flex-start">
                                <div>
                                    <i class="tio-online {{Session::get('direction') === "rtl" ? 'ml-2' : 'mr-2'}}"></i>
                                </div>
                                <div class="mx-1"><a class="text-dark"
                                                     href="mailto: {{$order->customer['email']}}">{{$order->customer['email']}}</a>
                                </div>
                                <input type="hidden" id="contact_person_email" name="contact_person_email" value="{{$order->customer['email']}}">
                            </div>
                            <div class="flex-start">
                                <div>
                                    <i class="tio-android-phone-vs {{Session::get('direction') === "rtl" ? 'ml-2' : 'mr-2'}}"></i>
                                </div>
                                <div class="mx-1"><a class="text-dark"
                                                     href="tel:{{$order->customer['phone']}}">{{$order->customer['phone']}}</a>
                                </div>
                            </div>

                            <hr>
                            <input type="hidden" id="app_url" name="app_url" value="{{ \Config::get('app.app_url') }}">
                           
                            <div class="d-flex justify-content-between align-items-center">
                                <h5>{{\App\CPU\translate('shipping_address')}}</h5>
                            </div>

                            @if($order->shippingAddress)
                                @php($shipping_address=$order->shippingAddress)
                            @else
                                @php($shipping_address=json_decode($order['shipping_address_data']))
                            @endif

                            <span class="d-block">{{\App\CPU\translate('Name')}} :
                                <strong>{{$shipping_address? $shipping_address->contact_person_name : \App\CPU\translate('empty')}}</strong><br>
                                 {{\App\CPU\translate('Country')}}:
                                <strong>{{$shipping_address ? $shipping_address->country : \App\CPU\translate('empty')}}</strong><br>
                                {{\App\CPU\translate('City')}}:
                                <strong>{{$shipping_address ? $shipping_address->city : \App\CPU\translate('empty')}}</strong><br>
                                {{\App\CPU\translate('zip_code')}} :
                                <strong>{{$shipping_address ? $shipping_address->zip  : \App\CPU\translate('empty')}}</strong><br>
                                {{\App\CPU\translate('address')}} :
                                <strong>{{$shipping_address ? $shipping_address->address  : \App\CPU\translate('empty')}}</strong><br>
                                {{\App\CPU\translate('Phone')}}:
                                <strong>{{$shipping_address ? $shipping_address->phone  : \App\CPU\translate('empty')}}</strong>
                                <input type="hidden" id="app_url" name="app_url" value="{{ \Config::get('app.app_url') }}">
                                <input type="hidden" id="mpesa_business_shortcode" name="mpesa_business_shortcode" value="{{ \Config::get('app.mpesa_business_shortcode') }}">

                                <input type="hidden" id="shipping_phone_number" name="shipping_phone_number" value="{{$shipping_address->phone}}">
                                <input type="hidden" id="contact_person_name" name="contact_person_name" value="{{$shipping_address->contact_person_name}}">

                                <input type="hidden" id="shipping_city" name="shipping_city" value="{{$shipping_address->city}}">
                                <input type="hidden" id="shipping_address" name="shipping_address" value="{{$shipping_address->address}}">
                                <input type="hidden" id="shipping_zip" name="shipping_zip" value="{{$shipping_address->zip}}">
                                <input type="hidden" id="shipping_country" name="shipping_country" value="{{$shipping_address->country}}">
                                <input type="hidden" id="shipping_state" name="shipping_state" value="{{$shipping_address->state}}">
                                <input type="hidden" id="order_collection_date" name="order_collection_date" value="{{$shipping_address->order_collection_date}}">
                            </span>

                            <hr>

                            <div class="d-flex justify-content-between align-items-center">
                                <h5>{{\App\CPU\translate('billing_address')}}</h5>
                            </div>

                            @if($order->billingAddress)
                                @php($billing=$order->billingAddress)
                            @else
                                @php($billing=json_decode($order['billing_address_data']))
                            @endif

                            <span class="d-block">{{\App\CPU\translate('Name')}} :
                                <strong>{{$billing? $billing->contact_person_name : \App\CPU\translate('empty')}}</strong><br>
                                 {{\App\CPU\translate('Country')}}:
                                <strong>{{$billing ? $billing->country : \App\CPU\translate('empty')}}</strong><br>
                                {{\App\CPU\translate('City')}}:
                                <strong>{{$billing ? $billing->city : \App\CPU\translate('empty')}}</strong><br>
                                {{\App\CPU\translate('zip_code')}} :
                                <strong>{{$billing ? $billing->zip  : \App\CPU\translate('empty')}}</strong><br>
                                {{\App\CPU\translate('address')}} :
                                <strong>{{$billing ? $billing->address  : \App\CPU\translate('empty')}}</strong><br>
                                {{\App\CPU\translate('Phone')}}:
                                <strong>{{$billing ? $billing->phone  : \App\CPU\translate('empty')}}</strong>
                            </span>
                        </div>
                @endif
                <!-- End Body -->
                </div>
                <!-- End Card -->
            </div>
        </div>
    </div>
    <!--Show locations on map Modal -->
    <div class="modal fade" id="locationModal" tabindex="-1" role="dialog" aria-labelledby="locationModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"
                        id="locationModalLabel">{{\App\CPU\translate('location')}} {{\App\CPU\translate('data')}}</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12 modal_body_map">
                            <div class="location-map" id="location-map">
                                <div style="width: 100%; height: 400px;" id="location_map_canvas"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Modal -->
@endsection
@push('script')
    <script>
        var app_url = document.getElementById('app_url').value; 
        var mpesa_business_shortcode = document.getElementById('mpesa_business_shortcode').value; 
        // console.log("app_url:"+app_url)
        // console.log("mpesa_business_shortcode:"+mpesa_business_shortcode)

        var shipping_phone_number = document.getElementById('shipping_phone_number').value;
        var contact_person_name = document.getElementById('contact_person_name').value;
        var contact_person_email = document.getElementById('contact_person_email').value;
        console.log("shipping_phone_number :"+shipping_phone_number )
        console.log("contact_person_name:"+contact_person_name)
        console.log("contact_person_email:"+contact_person_email)
       
        var order_id = document.getElementById('order_id').value;
        console.log("order_id:"+order_id)
        var product_total_cost = document.getElementById('product_total_cost').value;
        console.log("product_total_cost:"+product_total_cost)
        var order_collection_date = document.getElementById('order_collection_date').value;
        console.log("order_collection_date:"+order_collection_date)
        var shipping_cost = document.getElementById('shipping_cost').value;
   

  
        console.log("shipping_cost:"+shipping_cost)
 
        var shipping_address = document.getElementById('shipping_address').value;
        var shipping_city = document.getElementById('shipping_city').value;
        var shipping_zip = document.getElementById('shipping_zip').value;
        var shipping_state = document.getElementById('shipping_state').value;
        var shipping_country = document.getElementById('shipping_country').value;

        console.log("shipping_address:"+shipping_address)
        console.log("shipping_city:"+shipping_city)
        console.log("shipping_zip:"+shipping_zip)
        console.log("shipping_state:"+shipping_state)
        console.log("shipping_country:"+shipping_country)

        var detail_price = document.getElementById('detail_price').value;
        var detail_name = document.getElementById('detail_name').value;
        var detail_qty = document.getElementById('detail_qty').value;

        console.log("detail_price:"+detail_price)
        console.log("detail_name:"+detail_name)
        console.log("detail_qty:"+detail_qty)

        var app_url_msg_pending = app_url+"/api/v1/notifications/order_pending_msg";
        var app_url_msg_confirmation = app_url+"/api/v1/notifications/order_confirmation_msg";
        var app_url_msg_processing = app_url+"/api/v1/notifications/email_processing";
        var app_url_msg_out_for_delivery = app_url+"/api/v1/notifications/order_delivery_msg";
        var app_url_msg_delivered =  app_url+"/api/v1/notifications/order_delivered_msg";  
        var app_url_msg_retured =  app_url+"/api/v1/notifications/order_retured_msg";  
        var app_url_msg_failed =  app_url+"/api/v1/notifications/order_failed_msg";  

        var app_url_email_pending = app_url+"/api/v1/notifications/email_pending";
        var app_url_email_confirmation = app_url+"/api/v1/notifications/email_confirmation";
        var app_url_email_processing = app_url+"/api/v1/notifications/email_processing";
        var app_url_out_for_delivery = app_url+"/api/v1/notifications/email_out_for_delivery";
        var app_url_email_delivered =  app_url+"/api/v1/notifications/email_delivered"; 
        var app_url_email_returned =  app_url+"/api/v1/notifications/email_returned";
        var app_url_email_failed =  app_url+"/api/v1/notifications/email_failed";
        var app_url_email_cancelled =  app_url+"/api/v1/notifications/email_cancelled";


        $(document).on('change', '.payment_status', function () {
         
            var id = $(this).attr("data-id");
            var value = $(this).val();
            Swal.fire({
                title: '{{\App\CPU\translate('Are you sure Change this?')}}',
                text: "{{\App\CPU\translate('You wont be able to revert this!')}}",
                showCancelButton: true,
                confirmButtonColor: '#377dff',
                cancelButtonColor: 'secondary',
                confirmButtonText: '{{\App\CPU\translate('Yes, Change it')}}!'
            }).then((result) => {
                if (result.value) {
                    $.ajaxSetup({
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                        }
                    });
                    $.ajax({
                        url: "{{route('seller.orders.payment-status')}}",
                        method: 'POST',
                        data: {
                            "id": id,
                            "payment_status": value
                        },
                        success: function (data) {
                            toastr.success('Status Change successfully to '+value);
                            location.reload();
                        }
                    });
                }
            })
        });

        function order_status(status) {
            var value = status;
            Swal.fire({
                title: '{{\App\CPU\translate('Are you sure Change this?')}}',
                text: "{{\App\CPU\translate('You wont be able to revert this!')}}",
                showCancelButton: true,
                confirmButtonColor: '#377dff',
                cancelButtonColor: 'secondary',
                confirmButtonText: '{{\App\CPU\translate('Yes, Change it!')}}'
            }).then((result) => {
                if (result.value) {
                    $.ajaxSetup({
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                        }
                    });
                    $.ajax({
                        url: "{{route('seller.orders.status')}}",
                        method: 'POST',
                        data: {
                            "id": '{{$order['id']}}',
                            "order_status": value
                        },
                        success: function (data) {
                            if (data.success == 0) {
                                toastr.success('{{\App\CPU\translate('Order is already delivered, You can not change it !!')}}');
                                location.reload();
                            } else {
                                status=value;
                                if (value=='pending'){
                                    toastr.success('Successfully cahnged to '+value);
                                    var settings = {
                                        "url": app_url_msg_pending,
                                        "method": "POST",
                                        "timeout": 0,
                                        "headers": {
                                            "Accept": "application/json",
                                            "Content-Type": "application/json"
                                        },
                                        "data": JSON.stringify({
                                            "name": contact_person_name,
                                            "phone": shipping_phone_number,
                                            "order_number": order_id
                                        }),
                                        };

                                        $.ajax(settings).done(function (response) {
                                     
                                        });

                                        var settings = {
                                                "url": app_url_email_pending,
                                                "method": "POST",
                                                "timeout": 0,
                                                "headers": {
                                                    "Content-Type": "application/json"
                                                },
                                                "data": JSON.stringify({
                                                    "name": contact_person_name,
                                                    "email": contact_person_email,
                                                    "phone": shipping_phone_number,
                                                    "order_id": order_id,
                                                    "product_name": detail_name,
                                                    "quantity": detail_qty,
                                                    "price": detail_price,
                                                    "total_price": product_total_cost,
                                                    "shipping_cost": shipping_cost,
                                                    "status": "Paid",
                                                    "date": order_collection_date,
                                                    "street": shipping_address,
                                                    "city": shipping_city,
                                                    "code": shipping_zip,
                                                    "country": shipping_country
                                                }),
                                                };

                                                $.ajax(settings).done(function (response) {
                                                console.log(response);
                                                });
                                        location.reload();
                                }
                                
                                else if (value=='confirmed'){
                                    toastr.success('Successfully cahnged to '+status);
                                    var settings = {
                                        "url": app_url_msg_confirmation,
                                        "method": "POST",
                                        "timeout": 0,
                                        "headers": {
                                            "Accept": "application/json",
                                            "Content-Type": "application/json"
                                        },
                                        "data": JSON.stringify({
                                            "name": contact_person_name,
                                            "phone": shipping_phone_number,
                                            "order_number": order_id
                                        }),
                                        };

                                        $.ajax(settings).done(function (response) {
                                     
                                        });

                                     
                                                var settings = {
                                                "url": app_url_email_confirmation,
                                                "method": "POST",
                                                "timeout": 0,
                                                "headers": {
                                                    "Content-Type": "application/json"
                                                },
                                                "data": JSON.stringify({
                                                    "name": contact_person_name,
                                                    "email": contact_person_email,
                                                    "phone": shipping_phone_number,
                                                    "order_id": order_id,
                                                    "product_name": detail_name,
                                                    "quantity": detail_qty,
                                                    "price": detail_price,
                                                    "total_price": product_total_cost,
                                                    "shipping_cost": shipping_cost,
                                                    "status": "Paid",
                                                    "date": order_collection_date,
                                                    "street": shipping_address,
                                                    "city": shipping_city,
                                                    "code": shipping_zip,
                                                    "country": shipping_country
                                                }),
                                                };

                                                $.ajax(settings).done(function (response) {
                                                console.log(response);
                                                });
                                        location.reload();

                                }
                                else if (value=='processing'){
                                    toastr.success('Successfully cahnged to '+status);
                                    var settings = {
                                        "url": app_url_msg_confirmation,
                                        "method": "POST",
                                        "timeout": 0,
                                        "headers": {
                                            "Accept": "application/json",
                                            "Content-Type": "application/json"
                                        },
                                        "data": JSON.stringify({
                                            "name": contact_person_name,
                                            "phone": shipping_phone_number,
                                            "order_number": order_id
                                        }),
                                        };

                                        $.ajax(settings).done(function (response) {
                                     
                                        });

                                     
                                                var settings = {
                                                "url": app_url_email_processing,
                                                "method": "POST",
                                                "timeout": 0,
                                                "headers": {
                                                    "Content-Type": "application/json"
                                                },
                                                "data": JSON.stringify({
                                                    "name": contact_person_name,
                                                    "email": contact_person_email,
                                                    "phone": shipping_phone_number,
                                                    "order_id": order_id,
                                                    "product_name": detail_name,
                                                    "quantity": detail_qty,
                                                    "price": detail_price,
                                                    "total_price": product_total_cost,
                                                    "shipping_cost": shipping_cost,
                                                    "status": "Paid",
                                                    "date": order_collection_date,
                                                    "street": shipping_address,
                                                    "city": shipping_city,
                                                    "code": shipping_zip,
                                                    "country": shipping_country
                                                }),
                                                };

                                                $.ajax(settings).done(function (response) {
                                                console.log(response);
                                                });
                                        location.reload();

                                }
                                else if (value=='out_for_delivery'){
                                    toastr.success('Successfully cahnged to '+status);
                                    var settings = {
                                        "url": app_url_msg_out_for_delivery,
                                        "method": "POST",
                                        "timeout": 0,
                                        "headers": {
                                            "Accept": "application/json",
                                            "Content-Type": "application/json"
                                        },
                                        "data": JSON.stringify({
                                            "name": contact_person_name,
                                            "phone": shipping_phone_number,
                                            "order_number": order_id
                                        }),
                                        };

                                        $.ajax(settings).done(function (response) {
                                     
                                        });

                                                var settings = {
                                                "url": app_url_out_for_delivery,
                                                "method": "POST",
                                                "timeout": 0,
                                                "headers": {
                                                    "Content-Type": "application/json"
                                                },
                                                "data": JSON.stringify({
                                                    "name": contact_person_name,
                                                    "email": contact_person_email,
                                                    "phone": shipping_phone_number,
                                                    "order_id": order_id,
                                                    "product_name": detail_name,
                                                    "quantity": detail_qty,
                                                    "price": detail_price,
                                                    "total_price": product_total_cost,
                                                    "shipping_cost": shipping_cost,
                                                    "status": "Paid",
                                                    "date": order_collection_date,
                                                    "street": shipping_address,
                                                    "city": shipping_city,
                                                    "code": shipping_zip,
                                                    "country": shipping_country
                                                }),
                                                };

                                                $.ajax(settings).done(function (response) {
                                                console.log(response);
                                                });
                                        location.reload();
                                }
                                else if (value=='delivered'){
                                    toastr.success('Successfully cahnged to '+status);
                                    var settings = {
                                        "url": app_url_msg_delivered,
                                        "method": "POST",
                                        "timeout": 0,
                                        "headers": {
                                            "Accept": "application/json",
                                            "Content-Type": "application/json"
                                        },
                                        "data": JSON.stringify({
                                            "name": contact_person_name,
                                            "phone": shipping_phone_number,
                                            "order_number": order_id
                                        }),
                                        };

                                        $.ajax(settings).done(function (response) {
                                     
                                        });
                                            
                                                var settings = {
                                                "url": app_url_email_delivered,
                                                "method": "POST",
                                                "timeout": 0,
                                                "headers": {
                                                    "Content-Type": "application/json"
                                                },
                                                "data": JSON.stringify({
                                                    "name": contact_person_name,
                                                    "email": contact_person_email,
                                                    "phone": shipping_phone_number,
                                                    "order_id": order_id,
                                                    "product_name": detail_name,
                                                    "quantity": detail_qty,
                                                    "price": detail_price,
                                                    "total_price": product_total_cost,
                                                    "shipping_cost": shipping_cost,
                                                    "status": "Paid",
                                                    "date": order_collection_date,
                                                    "street": shipping_address,
                                                    "city": shipping_city,
                                                    "code": shipping_zip,
                                                    "country": shipping_country
                                                }),
                                                };

                                                $.ajax(settings).done(function (response) {
                                                console.log(response);
                                                });
                                        location.reload();
                                }
                                else if (value=='returned'){
                                    toastr.success('Successfully cahnged to '+status);
                                    var settings = {
                                        "url": app_url_msg_retured,
                                        "method": "POST",
                                        "timeout": 0,
                                        "headers": {
                                            "Accept": "application/json",
                                            "Content-Type": "application/json"
                                        },
                                        "data": JSON.stringify({
                                            "name": contact_person_name,
                                            "phone": shipping_phone_number,
                                            "order_number": order_id
                                        }),
                                        };

                                        $.ajax(settings).done(function (response) {
                                     
                                        });

                                               
                                                var settings = {
                                                "url": app_url_email_returned,
                                                "method": "POST",
                                                "timeout": 0,
                                                "headers": {
                                                    "Content-Type": "application/json"
                                                },
                                                "data": JSON.stringify({
                                                    "name": contact_person_name,
                                                    "email": contact_person_email,
                                                    "phone": shipping_phone_number,
                                                    "order_id": order_id,
                                                    "product_name": detail_name,
                                                    "quantity": detail_qty,
                                                    "price": detail_price,
                                                    "total_price": product_total_cost,
                                                    "shipping_cost": shipping_cost,
                                                    "status": "Paid",
                                                    "date": order_collection_date,
                                                    "street": shipping_address,
                                                    "city": shipping_city,
                                                    "code": shipping_zip,
                                                    "country": shipping_country
                                                }),
                                                };

                                                $.ajax(settings).done(function (response) {
                                                console.log(response);
                                                });
                                        location.reload();
                                }
                                else if (value=='failed'){
                                    toastr.success('Successfully cahnged to '+status);
                                    var settings = {
                                        "url": app_url_msg_failed,
                                        "method": "POST",
                                        "timeout": 0,
                                        "headers": {
                                            "Accept": "application/json",
                                            "Content-Type": "application/json"
                                        },
                                        "data": JSON.stringify({
                                            "name": contact_person_name,
                                            "phone": shipping_phone_number,
                                            "order_number": order_id
                                        }),
                                        };

                                        $.ajax(settings).done(function (response) {
                                     
                                        });

                                        
                                                var settings = {
                                                "url": app_url_email_failed,
                                                "method": "POST",
                                                "timeout": 0,
                                                "headers": {
                                                    "Content-Type": "application/json"
                                                },
                                                "data": JSON.stringify({
                                                    "name": contact_person_name,
                                                    "email": contact_person_email,
                                                    "phone": shipping_phone_number,
                                                    "order_id": order_id,
                                                    "product_name": detail_name,
                                                    "quantity": detail_qty,
                                                    "price": detail_price,
                                                    "total_price": product_total_cost,
                                                    "shipping_cost": shipping_cost,
                                                    "status": "Paid",
                                                    "date": order_collection_date,
                                                    "street": shipping_address,
                                                    "city": shipping_city,
                                                    "code": shipping_zip,
                                                    "country": shipping_country
                                                }),
                                                };

                                                $.ajax(settings).done(function (response) {
                                                console.log(response);
                                                });
                                        location.reload();
                                }
                                else if (value=='canceled'){
                                    toastr.success('Successfully cahnged to '+status);
                                    // var settings = {
                                    //     "url": app_url_msg_cancelled,
                                    //     "method": "POST",
                                    //     "timeout": 0,
                                    //     "headers": {
                                    //         "Accept": "application/json",
                                    //         "Content-Type": "application/json"
                                    //     },
                                    //     "data": JSON.stringify({
                                    //         "name": contact_person_name,
                                    //         "phone": shipping_phone_number,
                                    //         "order_number": order_id
                                    //     }),
                                    //     };

                                    //     $.ajax(settings).done(function (response) {
                                     
                                    //     });
   
                                                var settings = {
                                                "url": app_url_email_cancelled,
                                                "method": "POST",
                                                "timeout": 0,
                                                "headers": {
                                                    "Content-Type": "application/json"
                                                },
                                                "data": JSON.stringify({
                                                    "name": contact_person_name,
                                                    "email": contact_person_email,
                                                    "phone": shipping_phone_number,
                                                    "order_id": order_id,
                                                    "product_name": detail_name,
                                                    "quantity": detail_qty,
                                                    "price": detail_price,
                                                    "total_price": product_total_cost,
                                                    "shipping_cost": shipping_cost,
                                                    "status": "Paid",
                                                    "date": order_collection_date,
                                                    "street": shipping_address,
                                                    "city": shipping_city,
                                                    "code": shipping_zip,
                                                    "country": shipping_country
                                                }),
                                                };

                                                $.ajax(settings).done(function (response) {
                                                console.log(response);
                                                });
                                        location.reload();
                                }
                                else{
                                            toastr.success('Successfully cahnged to '+value);
                                            location.reload();
                                 
                                }
                             
                            }
                        }
                    });
                }
            })
        }
    </script>

    <script>
        function addDeliveryMan(id) {
            $.ajax({
                type: "GET",
                url: '{{url('/')}}/seller/orders/add-delivery-man/{{$order['id']}}/' + id,
                data: {
                    'order_id': '{{$order['id']}}',
                    'delivery_man_id': id
                },
                success: function (data) {
                    if (data.status == true) {
                        toastr.success('Delivery man successfully assigned/changed', {
                            CloseButton: true,
                            ProgressBar: true
                        });
                    } else {
                        toastr.error('Deliveryman man can not assign/change in that status', {
                            CloseButton: true,
                            ProgressBar: true
                        });
                    }
                },
                error: function () {
                    toastr.error('Add valid data', {
                        CloseButton: true,
                        ProgressBar: true
                    });
                }
            });
        }

        function last_location_view() {
            toastr.warning('Only available when order is out for delivery!', {
                CloseButton: true,
                ProgressBar: true
            });
        }

        function waiting_for_location() {
            toastr.warning('{{\App\CPU\translate('waiting_for_location')}}', {
                CloseButton: true,
                ProgressBar: true
            });
        }
    </script>
    <script
        src="https://maps.googleapis.com/maps/api/js?key={{\App\CPU\Helpers::get_business_settings('map_api_key')}}&v=3.45.8"></script>
    <script>

        function initializegLocationMap() {
            var map = null;
            var myLatlng = new google.maps.LatLng({{$shipping_address->latitude}}, {{$shipping_address->longitude}});
            var dmbounds = new google.maps.LatLngBounds(null);
            var locationbounds = new google.maps.LatLngBounds(null);
            var dmMarkers = [];
            dmbounds.extend(myLatlng);
            locationbounds.extend(myLatlng);

            var myOptions = {
                center: myLatlng,
                zoom: 13,
                mapTypeId: google.maps.MapTypeId.ROADMAP,

                panControl: true,
                mapTypeControl: false,
                panControlOptions: {
                    position: google.maps.ControlPosition.RIGHT_CENTER
                },
                zoomControl: true,
                zoomControlOptions: {
                    style: google.maps.ZoomControlStyle.LARGE,
                    position: google.maps.ControlPosition.RIGHT_CENTER
                },
                scaleControl: false,
                streetViewControl: false,
                streetViewControlOptions: {
                    position: google.maps.ControlPosition.RIGHT_CENTER
                }
            };
            map = new google.maps.Map(document.getElementById("location_map_canvas"), myOptions);
            console.log(map);
            var infowindow = new google.maps.InfoWindow();

            @if($shipping_address && isset($shipping_address))
            var marker = new google.maps.Marker({
                position: new google.maps.LatLng({{$shipping_address->latitude}}, {{$shipping_address->longitude}}),
                map: map,
                title: "{{$order->customer['f_name']??""}} {{$order->customer['l_name']??""}}",
                icon: "{{asset('public/assets/front-end/img/customer_location.png')}}"
            });

            google.maps.event.addListener(marker, 'click', (function (marker) {
                return function () {
                    infowindow.setContent("<div style='float:left'><img style='max-height:40px;wide:auto;' src='{{asset('storage/app/public/profile/')}}{{$order->customer->image??""}}'></div><div style='float:right; padding: 10px;'><b>{{$order->customer->f_name??""}} {{$order->customer->l_name??""}}</b><br/>{{$shipping_address->address}}</div>");
                    infowindow.open(map, marker);
                }
            })(marker));
            locationbounds.extend(marker.getPosition());
            @endif

            google.maps.event.addListenerOnce(map, 'idle', function () {
                map.fitBounds(locationbounds);
            });
        }

        // Re-init map before show modal
        $('#locationModal').on('shown.bs.modal', function (event) {

            initializegLocationMap();
        });
    </script>
@endpush
