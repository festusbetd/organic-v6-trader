@extends('layouts.back-end.app')

@section('title', \App\CPU\translate('SMS Module Setup'))

@push('css_or_js')

@endpush

@section('content')
    <div class="content container-fluid">
        <!-- Page Header -->
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-sm mb-sm-0">
                    <h1 class="page-header-title">{{\App\CPU\translate('sms')}} {{\App\CPU\translate('gateway')}} {{\App\CPU\translate('setup')}}</h1>
                </div>
            </div>
        </div>
        <!-- End Page Header -->

        <div class="row" style="padding-bottom: 20px">

            <div class="col-md-6">
                <div class="card">
                    <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
                        <h5 class="text-center">{{\App\CPU\translate('releans_sms')}}</h5>
                        <span class="badge badge-soft-info mb-3">NB : #OTP# will be replace with otp</span>
                        @php($config=\App\CPU\Helpers::get_business_settings('releans_sms'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.sms-module-update',['releans_sms']):'javascript:'}}"
                              style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                              method="post">
                            @csrf

                            <div class="form-group mb-2">
                                <label class="control-label">{{\App\CPU\translate('releans_sms')}}</label>
                            </div>
                            <div class="form-group mb-2 mt-2">
                                <input type="radio" name="status" value="1" {{isset($config) && $config['status']==1?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('active')}}</label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <input type="radio" name="status" value="0" {{isset($config) && $config['status']==0?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('inactive')}} </label>
                                <br>
                            </div>

                            <div class="form-group mb-2">
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('api_key')}}</label><br>
                                <input type="text" class="form-control" name="api_key"
                                       value="{{env('APP_MODE')!='demo'?$config['api_key']??"":''}}">
                            </div>

                            <div class="form-group mb-2">
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('from')}}</label><br>
                                <input type="text" class="form-control" name="from"
                                       value="{{env('APP_MODE')!='demo'?$config['from']??"":''}}">
                            </div>

                            <div class="form-group mb-2">
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('otp_template')}}</label><br>
                                <input type="text" class="form-control" name="otp_template"
                                       value="{{env('APP_MODE')!='demo'?$config['otp_template']??"":''}}">
                            </div>

                            <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                    onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                    class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card">
                    <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
                        <h5 class="text-center">{{\App\CPU\translate('twilio_sms')}}</h5>
                        <span class="badge badge-soft-info mb-3">NB : #OTP# will be replace with otp</span>
                        @php($config=\App\CPU\Helpers::get_business_settings('twilio_sms'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.sms-module-update',['twilio_sms']):'javascript:'}}"
                              style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                              method="post">
                            @csrf

                            <div class="form-group mb-2">
                                <label class="control-label">{{\App\CPU\translate('twilio_sms')}}</label>
                            </div>
                            <div class="form-group mb-2 mt-2">
                                <input type="radio" name="status" value="1" {{isset($config) && $config['status']==1?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('active')}}</label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <input type="radio" name="status" value="0" {{isset($config) && $config['status']==0?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('inactive')}} </label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <label class="text-capitalize"
                                       style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('sid')}}</label><br>
                                <input type="text" class="form-control" name="sid"
                                       value="{{env('APP_MODE')!='demo'?$config['sid']??"":''}}">
                            </div>

                            <div class="form-group mb-2">
                                <label class="text-capitalize"
                                       style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('messaging_service_sid')}}</label><br>
                                <input type="text" class="form-control" name="messaging_service_sid"
                                       value="{{env('APP_MODE')!='demo'?$config['messaging_service_sid']??"":''}}">
                            </div>

                            <div class="form-group mb-2">
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('token')}}</label><br>
                                <input type="text" class="form-control" name="token"
                                       value="{{env('APP_MODE')!='demo'?$config['token']??"":''}}">
                            </div>

                            <div class="form-group mb-2">
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('from')}}</label><br>
                                <input type="text" class="form-control" name="from"
                                       value="{{env('APP_MODE')!='demo'?$config['from']??"":''}}">
                            </div>

                            <div class="form-group mb-2">
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('otp_template')}}</label><br>
                                <input type="text" class="form-control" name="otp_template"
                                       value="{{env('APP_MODE')!='demo'?$config['otp_template']??"":''}}">
                            </div>

                            <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                    onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                    class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card">
                    <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
                        <h5 class="text-center">{{\App\CPU\translate('nexmo_sms')}}</h5>
                        <span class="badge badge-soft-info mb-3">NB : #OTP# will be replace with otp</span>
                        @php($config=\App\CPU\Helpers::get_business_settings('nexmo_sms'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.sms-module-update',['nexmo_sms']):'javascript:'}}"
                              style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                              method="post">
                            @csrf

                            <div class="form-group mb-2">
                                <label class="control-label">{{\App\CPU\translate('nexmo_sms')}}</label>
                            </div>
                            <div class="form-group mb-2 mt-2">
                                <input type="radio" name="status" value="1" {{isset($config) && $config['status']==1?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('active')}}</label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <input type="radio" name="status" value="0" {{isset($config) && $config['status']==0?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('inactive')}} </label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <label class="text-capitalize"
                                       style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('api_key')}}</label><br>
                                <input type="text" class="form-control" name="api_key"
                                       value="{{env('APP_MODE')!='demo'?$config['api_key']??"":''}}">
                            </div>
                            <div class="form-group mb-2">
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('api_secret')}}</label><br>
                                <input type="text" class="form-control" name="api_secret"
                                       value="{{env('APP_MODE')!='demo'?$config['api_secret']??"":''}}">
                            </div>

                            <div class="form-group mb-2">
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('from')}}</label><br>
                                <input type="text" class="form-control" name="from"
                                       value="{{env('APP_MODE')!='demo'?$config['from']??"":''}}">
                            </div>

                            <div class="form-group mb-2">
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('otp_template')}}</label><br>
                                <input type="text" class="form-control" name="otp_template"
                                       value="{{env('APP_MODE')!='demo'?$config['otp_template']??"":''}}">
                            </div>

                            <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                    onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                    class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mt-4">
                <div class="card">
                    <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
                        <h5 class="text-center">{{\App\CPU\translate('2factor_sms')}}</h5>
                        <span class="badge badge-soft-info">{{\App\CPU\translate("EX of SMS provider's template : your OTP is XXXX here, please check")}}.</span><br>
                        <span class="badge badge-soft-info mb-3">{{\App\CPU\translate('NB : XXXX will be replace with otp')}}</span>
                        @php($config=\App\CPU\Helpers::get_business_settings('2factor_sms'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.sms-module-update',['2factor_sms']):'javascript:'}}"
                              style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                              method="post">
                            @csrf

                            <div class="form-group mb-2">
                                <label class="control-label">{{\App\CPU\translate('2factor_sms')}}</label>
                            </div>
                            <div class="form-group mb-2 mt-2">
                                <input type="radio" name="status" value="1" {{isset($config) && $config['status']==1?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('active')}}</label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <input type="radio" name="status" value="0" {{isset($config) && $config['status']==0?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('inactive')}} </label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <label class="text-capitalize"
                                       style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('api_key')}}</label><br>
                                <input type="text" class="form-control" name="api_key"
                                       value="{{env('APP_MODE')!='demo'?$config['api_key']??"":''}}">
                            </div>

                            <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                    onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                    class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                        </form>
                    </div>
                </div>
            </div>

      

         

            <div class="col-md-6 mt-4">
                <div class="card">
                    <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
                        <h5 class="text-center">{{\App\CPU\translate('msg91_sms')}}</h5>
                        <span class="badge badge-soft-info mb-3">{{\App\CPU\translate('NB : Keep an OTP variable in your SMS providers OTP Template')}}.</span><br>
                        @php($config=\App\CPU\Helpers::get_business_settings('msg91_sms'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.sms-module-update',['msg91_sms']):'javascript:'}}"
                              style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                              method="post">
                            @csrf

                            <div class="form-group mb-2">
                                <label class="control-label">{{\App\CPU\translate('msg91_sms')}}</label>
                            </div>
                            <div class="form-group mb-2 mt-2">
                                <input type="radio" name="status" value="1" {{isset($config) && $config['status']==1?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('active')}}</label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <input type="radio" name="status" value="0" {{isset($config) && $config['status']==0?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('inactive')}} </label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <label class="text-capitalize"
                                       style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('template_id')}}</label><br>
                                <input type="text" class="form-control" name="template_id"
                                       value="{{env('APP_MODE')!='demo'?$config['template_id']??"":''}}">
                            </div>
                            <div class="form-group mb-2">
                                <label class="text-capitalize"
                                       style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('authkey')}}</label><br>
                                <input type="text" class="form-control" name="authkey"
                                       value="{{env('APP_MODE')!='demo'?$config['authkey']??"":''}}">
                            </div>

                            <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                    onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                    class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                        </form>
                    </div>
                </div>
            </div>


                  
            <div class="col-md-6 mt-4">
                <div class="card">
                    <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
                        <h5 class="text-center">Order Pending</h5>
                        <span class="badge badge-soft-info">Order Pending Message provider's template .</span><br>
                 
                        @php($config=\App\CPU\Helpers::get_business_settings('celcom_pending'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.sms-module-update',['celcom_pending']):'javascript:'}}"
                              style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                              method="post">
                            @csrf

                            <div class="form-group mb-2">
                                <label class="control-label">Order Pending Message</label>
                            </div>
                            <div class="form-group mb-2 mt-2">
                                <input type="radio" name="status" value="1" {{isset($config) && $config['status']==1?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('active')}}</label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <input type="radio" name="status" value="0" {{isset($config) && $config['status']==0?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('inactive')}} </label>
                                <br>
                            </div>
                            <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                    onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                    class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mt-4">
                <div class="card">
                    <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
                        <h5 class="text-center">Celcom Confirmation</h5>
                        <span class="badge badge-soft-info">Confirmation SMS provider's template .</span><br>
                 
                        @php($config=\App\CPU\Helpers::get_business_settings('celcom_confirmation'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.sms-module-update',['celcom_confirmation']):'javascript:'}}"
                              style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                              method="post">
                            @csrf

                            <div class="form-group mb-2">
                                <label class="control-label">Celcom Confirmation</label>
                            </div>
                            <div class="form-group mb-2 mt-2">
                                <input type="radio" name="status" value="1" {{isset($config) && $config['status']==1?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('active')}}</label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <input type="radio" name="status" value="0" {{isset($config) && $config['status']==0?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('inactive')}} </label>
                                <br>
                            </div>
                            <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                    onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                    class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mt-4">
                <div class="card">
                    <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
                        <h5 class="text-center">Order Processing Message </h5>
                        <span class="badge badge-soft-info">Order Processing Message provider's template .</span><br>
                            @php($config=\App\CPU\Helpers::get_business_settings('celcom_processing'))
              
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.sms-module-update',['celcom_processing']):'javascript:'}}"
                              style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                              method="post">
                            @csrf

                            <div class="form-group mb-2">
                                <label class="control-label">Order Processing</label>
                            </div>
                            <div class="form-group mb-2 mt-2">
                                <input type="radio" name="status" value="1" {{isset($config) && $config['status']==1?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('active')}}</label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <input type="radio" name="status" value="0" {{isset($config) && $config['status']==0?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('inactive')}} </label>
                                <br>
                            </div>
                            <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                    onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                    class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mt-4">
                <div class="card">
                    <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
                        <h5 class="text-center">Order out for delivery Message </h5>
                        <span class="badge badge-soft-info">Order out for delivery provider's template.</span><br>
                    
                        @php($config=\App\CPU\Helpers::get_business_settings('celcom_order_delivery'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.sms-module-update',['celcom_order_delivery']):'javascript:'}}"
                              style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                              method="post">
                            @csrf

                            <div class="form-group mb-2">
                                <label class="control-label">Order out for delivery</label>
                            </div>
                            <div class="form-group mb-2 mt-2">
                                <input type="radio" name="status" value="1" {{isset($config) && $config['status']==1?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('active')}}</label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <input type="radio" name="status" value="0" {{isset($config) && $config['status']==0?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('inactive')}} </label>
                                <br>
                            </div>
                            <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                    onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                    class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mt-4">
                <div class="card">
                    <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
                        <h5 class="text-center">Order Delivered Message </h5>
                        <span class="badge badge-soft-info">Order Delivered Message provider's template.</span><br>
                 
                        @php($config=\App\CPU\Helpers::get_business_settings('celcom_delivered'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.sms-module-update',['celcom_delivered']):'javascript:'}}"
                              style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                              method="post">
                            @csrf

                            <div class="form-group mb-2">
                                <label class="control-label">Order Delivered Message </label>
                            </div>
                            <div class="form-group mb-2 mt-2">
                                <input type="radio" name="status" value="1" {{isset($config) && $config['status']==1?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('active')}}</label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <input type="radio" name="status" value="0" {{isset($config) && $config['status']==0?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('inactive')}} </label>
                                <br>
                            </div>
                            <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                    onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                    class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mt-4">
                <div class="card">
                    <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
                        <h5 class="text-center">Order Delivered Message </h5>
                        <span class="badge badge-soft-info">{Order Delivered Message provider's template .</span><br>
          
                        @php($config=\App\CPU\Helpers::get_business_settings('celcom_delivered'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.sms-module-update',['celcom_delivered']):'javascript:'}}"
                              style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                              method="post">
                            @csrf

                            <div class="form-group mb-2">
                                <label class="control-label">Order Delivered Message </label>
                            </div>
                            <div class="form-group mb-2 mt-2">
                                <input type="radio" name="status" value="1" {{isset($config) && $config['status']==1?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('active')}}</label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <input type="radio" name="status" value="0" {{isset($config) && $config['status']==0?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('inactive')}} </label>
                                <br>
                            </div>
                            <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                    onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                    class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mt-4">
                <div class="card">
                    <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
                        <h5 class="text-center">Order Returned Message</h5>
                        <span class="badge badge-soft-info">Order Returned Message provider's template .</span><br>
                      
                        @php($config=\App\CPU\Helpers::get_business_settings('celcom_returned'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.sms-module-update',['celcom_returned']):'javascript:'}}"
                              style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                              method="post">
                            @csrf

                            <div class="form-group mb-2">
                                <label class="control-label">Order Returned Message</label>
                            </div>
                            <div class="form-group mb-2 mt-2">
                                <input type="radio" name="status" value="1" {{isset($config) && $config['status']==1?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('active')}}</label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <input type="radio" name="status" value="0" {{isset($config) && $config['status']==0?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('inactive')}} </label>
                                <br>
                            </div>
                            <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                    onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                    class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mt-4">
                <div class="card">
                    <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
                        <h5 class="text-center">Order Failed Message</h5>
                        <span class="badge badge-soft-info">{{\App\CPU\translate("Order Failed Message provider's template ")}}.</span><br>
                      
                        @php($config=\App\CPU\Helpers::get_business_settings('celcom_failed'))
                        <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.sms-module-update',['celcom_failed']):'javascript:'}}"
                              style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                              method="post">
                            @csrf

                            <div class="form-group mb-2">
                                <label class="control-label">Order Failed Message</label>
                            </div>
                            <div class="form-group mb-2 mt-2">
                                <input type="radio" name="status" value="1" {{isset($config) && $config['status']==1?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('active')}}</label>
                                <br>
                            </div>
                            <div class="form-group mb-2">
                                <input type="radio" name="status" value="0" {{isset($config) && $config['status']==0?'checked':''}}>
                                <label style="padding-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}: 10px">{{\App\CPU\translate('inactive')}} </label>
                                <br>
                            </div>
                            <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                    onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                    class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                        </form>
                    </div>
                </div>
            </div>


        </div>
    </div>
@endsection

@push('script_2')

@endpush
