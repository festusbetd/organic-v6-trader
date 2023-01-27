@extends('layouts.back-end.app')
@section('title', \App\CPU\translate('Mail Config'))
@push('css_or_js')

@endpush

@section('content')
    <div class="content container-fluid">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{{route('admin.dashboard')}}">{{\App\CPU\translate('Dashboard')}}</a>
                </li>
                <li class="breadcrumb-item" aria-current="page">{{\App\CPU\translate('mail_config')}}</li>
            </ol>
        </nav>

        <div class="row" style="padding-bottom: 20px; text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body" style="padding: 20px">

                        @php($config=\App\Model\BusinessSetting::where(['type'=>'mail_config'])->first())
                        @php($data=json_decode($config['value'],true))
                        <form action="{{route('admin.business-settings.mail.update')}}"
                              method="post">
                            @csrf
                            @if(isset($config))
                                <div class="form-group mb-2 text-center">
                                    <label class="control-label">{{\App\CPU\translate('smtp_mail_config')}}</label>
                                </div>
                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{\App\CPU\translate('mailer_name')}}</label><br>
                                    <input type="text" placeholder="ex : Alex" class="form-control" name="name"
                                           value="{{env('APP_MODE')=='demo'?'':$data['name']}}">
                                </div>

                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{\App\CPU\translate('Host')}}</label><br>
                                    <input type="text" class="form-control" name="host"
                                           value="{{env('APP_MODE')=='demo'?'':$data['host']}}">
                                </div>
                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{\App\CPU\translate('Driver')}}</label><br>
                                    <input type="text" class="form-control" name="driver"
                                           value="{{env('APP_MODE')=='demo'?'':$data['driver']}}">
                                </div>
                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{\App\CPU\translate('port')}}</label><br>
                                    <input type="text" class="form-control" name="port"
                                           value="{{env('APP_MODE')=='demo'?'':$data['port']}}">
                                </div>

                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{\App\CPU\translate('Username')}}</label><br>
                                    <input type="text" placeholder="ex : ex@yahoo.com" class="form-control"
                                           name="username" value="{{env('APP_MODE')=='demo'?'':$data['username']}}">
                                </div>

                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{\App\CPU\translate('email_id')}}</label><br>
                                    <input type="text" placeholder="ex : ex@yahoo.com" class="form-control" name="email"
                                           value="{{env('APP_MODE')=='demo'?'':$data['email_id']}}">
                                </div>

                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{\App\CPU\translate('Encryption')}}</label><br>
                                    <input type="text" placeholder="ex : tls" class="form-control" name="encryption"
                                           value="{{env('APP_MODE')=='demo'?'':$data['encryption']}}">
                                </div>

                                <div class="form-group mb-2">
                                    <label style="padding-left: 10px">{{\App\CPU\translate('password')}}</label><br>
                                    <input type="text" class="form-control" name="password"
                                           value="{{env('APP_MODE')=='demo'?'':$data['password']}}">
                                </div>
                                <button type="{{env('APP_MODE')!='demo'?'submit':'button'}}"
                                        onclick="{{env('APP_MODE')!='demo'?'':'call_demo()'}}"
                                        class="btn btn-primary mb-2">{{\App\CPU\translate('save')}}</button>
                            @else
                                <button type="submit"
                                        class="btn btn-primary mb-2">{{\App\CPU\translate('Configure')}}</button>
                            @endif
                        </form>
                    </div>
                    
               
            </div>
                </div>
            </div>
            
        </div>
   
        <div class="row" style="padding-bottom: 20px">



      
<div class="col-md-6 mt-4">
    <div class="card">
        <div class="card-body text-{{Session::get('direction') === "rtl" ? 'right' : 'left'}}" style="padding: 20px">
            <h5 class="text-center">Order Pending Email</h5>
            <span class="badge badge-soft-info">Order Pending Email provider's template .</span><br>
     
            @php($config=\App\CPU\Helpers::get_business_settings('email_pending'))
            <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.email-module-update',['email_pending']):'javascript:'}}"
                  style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                  method="post">
                @csrf

                <div class="form-group mb-2">
                    <label class="control-label">Order Pending Email</label>
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
            <h5 class="text-center">Order Confirmation Email</h5>
            <span class="badge badge-soft-info">Confirmation Email provider's template .</span><br>
     
            @php($config=\App\CPU\Helpers::get_business_settings('email_confirmation'))
            <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.email-module-update',['email_confirmation']):'javascript:'}}"
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
            <h5 class="text-center">Order Processing Email </h5>
            <span class="badge badge-soft-info">Order Processing Email provider's template .</span><br>
                @php($config=\App\CPU\Helpers::get_business_settings('email_processing'))
  
            <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.email-module-update',['email_processing']):'javascript:'}}"
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
            <h5 class="text-center">Order out for delivery Email </h5>
            <span class="badge badge-soft-info">Order out for delivery provider's Email template.</span><br>
        
            @php($config=\App\CPU\Helpers::get_business_settings('email_order_out_for_delivery'))
            <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.email-module-update',['email_order_out_for_delivery']):'javascript:'}}"
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
            <h5 class="text-center">Order Delivered Email </h5>
            <span class="badge badge-soft-info">Order Delivered Email provider's template.</span><br>
     
            @php($config=\App\CPU\Helpers::get_business_settings('email_delivered'))
            <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.email-module-update',['email_delivered']):'javascript:'}}"
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
            <h5 class="text-center">Order Returned Email</h5>
            <span class="badge badge-soft-info">Order Returned Email provider's template .</span><br>
          
            @php($config=\App\CPU\Helpers::get_business_settings('email_returned'))
            <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.email-module-update',['email_returned']):'javascript:'}}"
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
            <h5 class="text-center">Order Failed Mail</h5>
            <span class="badge badge-soft-info">{{\App\CPU\translate("Order Failed Mail provider's template ")}}.</span><br>
          
            @php($config=\App\CPU\Helpers::get_business_settings('email_failed'))
            <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.email-module-update',['email_failed']):'javascript:'}}"
                  style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                  method="post">
                @csrf

                <div class="form-group mb-2">
                    <label class="control-label">Order Failed Email</label>
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
            <h5 class="text-center">Order Canceled Mail</h5>
            <span class="badge badge-soft-info">{{\App\CPU\translate("Order Canceled Mail provider's template ")}}.</span><br>
          
            @php($config=\App\CPU\Helpers::get_business_settings('email_canceled'))
            <form action="{{env('APP_MODE')!='demo'?route('admin.business-settings.email-module-update',['email_canceled']):'javascript:'}}"
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

@push('script')

@endpush
