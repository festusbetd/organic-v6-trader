@extends('layouts.front-end.app')

@section('title','Choose Payment Method')

@push('css_or_js')
    <style>
        .stripe-button-el {
            display: none !important;
        }

        .razorpay-payment-button {
            display: none !important;
        }
    </style>

    {{--stripe--}}
    <script src="https://polyfill.io/v3/polyfill.min.js?version=3.52.1&features=fetch"></script>
    <script src="https://js.stripe.com/v3/"></script>
    {{--stripe--}}

@endpush

@section('content')
    <!-- Page Content-->
    <div class="container pb-5 mb-2 mb-md-4 rtl"
         style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">
        <div class="row">
            <div class="col-md-12 mb-5 pt-5">
                <div class="feature_header" style="background: #dcdcdc;line-height: 1px">
                    <span>{{ \App\CPU\translate('payment_method')}}</span>
                </div>
            </div>
            <section class="col-lg-8">
                <hr>
                <div class="checkout_details mt-3">
                <!-- @include('web-views.partials._checkout-steps',['step'=>3]) -->
                @include('web-views.partials._checkout-steps',['step'=>4])
                <!-- Payment methods accordion-->
        @if(auth('customer')->check())
                        <div class=" p-5">
                            <div class="row">
                                <div class="col-md-6">
                                    <h5 style="font-size: 20px; font-weight: 900">{{\App\CPU\translate('Kindly Put your Mpesa pin')}}
                                        !</h5>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-12">
                                    <center>
                                        <i style="font-size: 100px; color: #0f9d58" class="fa fa-spinner fa-pulse fa-3x fa-fw"></i>
                                        <span class="sr-only">Loading...</span>
                                    </center>


                                </div>
                            </div>

                          
                            <span class="font-weight-bold d-block mt-4" style="font-size: 17px;">{{\App\CPU\translate('Hello')}}, {{auth('customer')->user()->f_name}}</span>
                            <span>You order will be confirmed when we recieve payments!</span>

                            <div class="row mt-4">
                                <div class="col-6">
                                    <a href="{{route('checkout-payment')}}" class="btn btn-secondary">
                                        {{\App\CPU\translate('go_to_shopping')}}
                                    </a>
                                </div>

                                       @php($config=\App\CPU\Helpers::get_business_settings('mpesa_pay'))
                                        @php($user=auth('customer')->user())
                                        @php($data = new \stdClass())
                                        @php($data->detail = 'payment')
                                        @php($data->order_id = session('cart_group_id'))
                                        @php($data->name = $user->f_name.' '.$user->l_name)
                                        @php($data->email = $user->email)
                                        @php($data->phone = $user->phone)
                                     
                                 

                                        <form name="order" method="post"
                                              action="">
                                            <input type="hidden" id="detail" name="detail" value="{{$data->detail}}">
                                            <input type="hidden" id="user" name="user" value="{{$user}}">
                                            <input type="hidden" id="order_id" name="order_id" value="{{$data->order_id}}">
                                            <input type="hidden" id="name" name="name" value="{{$data->name}}">
                                            <input type="hidden" id="email" name="email" value="{{$data->email}}">
                                            <input type="hidden" id="phone" name="phone" value="{{$user->phone}}">

                            
                  
                                        </form>

                                <!-- <div class="col-6">
                             
                                    <a href="javascript:" onclick="proceed_to_next()"
                                       class="btn btn-primary pull-{{Session::get('direction') === "rtl" ? 'left' : 'right'}}">
                                        {{\App\CPU\translate('Paid')}}
                                    </a>
                                </div> -->
                                
                            </div>
                        </div>
                    @endif

                    <!-- Navigation (desktop)-->
                    <!-- <div class="row">
                        <div class="col-4"></div>
                        <div class="col-4">
                            <a class="btn btn-secondary btn-block" href="{{route('checkout-shipping')}}">
                                <span class="d-none d-sm-inline">Back to Shipping</span>
                                <span class="d-inline d-sm-none">Back</span>
                            </a>
                        </div>
                        <div class="col-4"></div>
                    </div> -->
                </div>
            </section>
            <!-- Sidebar-->
            <!-- @include('web-views.partials._order-summary') -->
            @include('web-views.partials._order-summary-mpesa')
        </div>
    </div>
@endsection

@push('script')
    <script>
        setTimeout(function () {
            $('.stripe-button-el').hide();
            $('.razorpay-payment-button').hide();
        }, 10)
    </script>

<script>
var goToNextPage = setTimeout(function () {
  location.href = '{{route('checkout-complete_2',['payment_method'=>'mpesa_before_delivery'])}}';
}, 3000);
    // function proceed_to_next(){
    //    location.href = '{{route('checkout-complete_2',['payment_method'=>'mpesa_before_delivery'])}}';
    // }
</script>
@endpush
