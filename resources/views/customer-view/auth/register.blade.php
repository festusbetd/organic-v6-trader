@extends('layouts.front-end.app_login')

@section('title','Register')

@push('css_or_js')
    <style>
        @media (max-width: 500px) {
            #sign_in {
                margin-top: -23% !important;
            }

        }
    </style>
@endpush

@section('content')
    <div class="container py-4 py-lg-5 my-4"
         style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card border-0 box-shadow">
                    <div class="card-body">
                        <h2 class="h4 mb-1">Trader Sign Up</h2>
                  
                        <form class="needs-validation_" action="{{route('customer.auth.register-trader')}}"
                              method="post" id="sign-up-form">
                            @csrf
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="reg-fn">{{\App\CPU\translate('first_name')}}</label>
                                        <input class="form-control" value="{{old('f_name')}}" type="text" name="f_name"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                               required>
                                        <div class="invalid-feedback">Please enter your first name!</div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="reg-ln">{{\App\CPU\translate('last_name')}}</label>
                                        <input class="form-control" type="text" value="{{old('l_name')}}" name="l_name"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">
                                        <div class="invalid-feedback">Please enter your last name!</div>
                                    </div>
                                </div>


                                <div class="col-sm-6">
                                    <div class="form-group">
                                    <label for="reg-gender">{{\App\CPU\translate('added_gender')}} </label>
                                        <select list="gender" class="form-control" value="{{old('gender')}}" type="text" name="gender"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                               required>
                                               <option value="">Select Gender</option>
                                                    <option value='Male'>{{\App\CPU\translate('added_male')}}</option>
                                                    <option value='Female'>{{\App\CPU\translate('added_female')}}</option>
                                                    
                                                </select>
                                               
                                        <div class="invalid-feedback">Please enter your Gender!</div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="reg-user_id">{{\App\CPU\translate('National ID/Passport')}}</label>
                                        <input class="form-control" type="text" value="{{old('l_name')}}" name="user_id"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">
                                        <div class="invalid-feedback">Please enter your National ID/Passport!</div>
                                    </div>
                                </div>
                              
                                <div class="col-sm-6">
                                    <div class="form-group">
                                    <label for="reg-dob">Choose Date of Birth</label>
                                        <input class="form-control" type="date" value="{{old('dob')}}"  name="dob"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};" required>
                                        <div class="invalid-feedback">Please enter valid DOB!</div>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                     <div class="form-group">

                                     <label for="reg-marital_status">Marital status </label>
                                        <select list="marital_status" class="form-control" value="{{old('marital_status')}}" type="text" name="marital_status"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                               required>
                                          
                                               <option value="">Select Marital Status-</option>
                                                            <option value="Single">Single</option>
                                                            <option value="Married">Married</option>
                                                            <option value="Widowed">Widowed</option>
                                                            <option value="Separated">Separated</option>
                                                            <option value="Divorced">Divorced</option>
                                                    
                                                </select>
                                               
                                        <div class="invalid-feedback">Please enter valid marital status!</div>

                                
                                    </div>
                                </div>
                            
                                <div class="col-sm-6">
                                     <div class="form-group">
                                        <label for="reg-email">{{\App\CPU\translate('email_address')}}</label>
                                        <input class="form-control" type="email" value="{{old('email')}}"  name="email"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};" required>
                                        <div class="invalid-feedback">Please enter valid email address!</div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="reg-phone">{{\App\CPU\translate('phone_number')}}
                                            <small class="text-primary">( * {{\App\CPU\translate('country_code_is_must')}} )</small></label>
                                        <input class="form-control" type="number"  value="{{old('phone')}}"  name="phone"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                               required>
                                        <div class="invalid-feedback">Please enter your phone number!</div>
                                    </div>
                                    </div>
                                    
                                <div class="col-sm-6">
                                     <div class="form-group">
                                        <label for="reg-other_phone_number">{{\App\CPU\translate('other_phone_number')}}</label>
                                        <input class="form-control" type="other_phone_number" value="{{old('other_phone_number')}}"  name="other_phone_number"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};" required>
                                        <div class="invalid-feedback">Please enter valid Phone Number!</div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                    <label for="reg-kra_pin">Enter KRA Pin</label>
                                        <input class="form-control" type="kra_pin" value="{{old('kra_pin')}}"  name="kra_pin"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};" required>
                                        <div class="invalid-feedback">Please enter valid KRA Number!</div>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                     <div class="form-group">
                                       
                                     <label for="reg-county">{{\App\CPU\translate('County')}} </label>

                                    <select class="form-control" list="county" name="county" type="text" value="{{old('county')}}" 
                                                        style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};" required >
                                        
                                                        <option value="">Select County</option>
                                        <option value='Baringo'>Baringo</option>
                                                <option value='Bomet'>Bomet</option>
                                                <option value='Bungoma'>Bungoma</option>
                                                <option value='Busia'>Busia</option>
                                                <option value='Elgeyo-Marakwet'>Elgeyo-Marakwet</option>
                                                <option value='Embu'>Embu</option>
                                                <option value='Garissa'>Garissa</option>
                                                <option value='Homa Bay'>Homa Bay</option>
                                                <option value='Isiolo'>Isiolo</option>
                                                <option value='Kajiado'>Kajiado</option>
                                                <option value='Kakamega'>Kakamega</option>
                                                <option value='Kericho'>Kericho</option>
                                                <option value='Kiambu'>Kiambu</option>
                                                <option value='Kilifi'>Kilifi</option>
                                                <option value='Kirinyaga'>Kirinyaga</option>
                                                <option value='Kisii'>Kisii</option>
                                                <option value='Kisumu'>Kisumu</option>
                                                <option value='Kitui'>Kitui</option>
                                                <option value='Kwale'>Kwale</option>
                                                <option value='Laikipia'>Laikipia</option>
                                                <option value='Lamu'>Lamu</option>
                                                <option value='Machakos'>Machakos</option>
                                                <option value='Makueni'>Makueni</option>
                                                <option value='Mandera'>Mandera</option>
                                                <option value='Marsabit'>Marsabit</option>
                                                <option value='Meru'>Meru</option>
                                                <option value='Migori'>Migori</option>
                                                <option value='Mombasa'>Mombasa</option>
                                                <option value='Muranga'>Murang'a</option>
                                                <option value='Nairobi City'>Nairobi City</option>
                                                <option value='Nakuru'>Nakuru</option>
                                                <option value='Nandi'>Nandi</option>
                                                <option value='Narok'>Narok</option>
                                                <option value='Nyamira'>Nyamira</option>
                                                <option value='Nyandarua'>Nyandarua</option>
                                                <option value='Nyeri'>Nyeri</option>
                                                <option value='Samburu'>Samburu</option>
                                                <option value='Siaya'>Siaya</option>
                                                <option value='Taita-Taveta'>Taita-Taveta</option>
                                                <option value='Tana River'>Tana River</option>
                                                <option value='Tharaka-Nithi'>Tharaka-Nithi</option>
                                                <option value='Trans Nzoia'>Trans Nzoia</option>
                                                <option value='Turkana'>Turkana</option>
                                                <option value='Uasin Gishu'>Uasin Gishu</option>
                                                <option value='Vihiga'>Vihiga</option>
                                                <option value='West Pokot'>West Pokot</option>
                                                <option value='wajir'>wajir</option>
                                            </select>
                                        
                                    <div class="invalid-feedback">Please enter valid County!</div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                <div class="form-group">
                                <div class="form-group">

                                <label for="reg-user_type_name">User Type </label>
                                        <select list="user_type_name" class="form-control" value="{{old('user_type_name')}}" type="text" name="user_type_name"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                               required>
                                          
                                               <option value="">Select User Type</option>
                                               <option value='Individual'>Individual</option>
                                                    <option value='Group'>Group</option>
                                                    
                                                </select>
                                               
                                                <div class="invalid-feedback">Please enter your Industry!</div>
                               
                                    </div>
                                    </div>
                                </div>
                            
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="reg-business_name">Enter Business Name</label>
                                        <input class="form-control" value="{{old('business_name')}}" type="text" name="business_name"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                               required>
                                        <div class="invalid-feedback">Please enter Business Name!</div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="reg-business_location">Business Location</label>
                                        <input class="form-control" type="text" value="{{old('business_location')}}" name="business_location"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">
                                        <div class="invalid-feedback">Please Business Location!</div>
                                    </div>
                                </div>


                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="reg-physical_address">Physical Address</label>
                                        <input class="form-control" value="{{old('physical_address')}}" type="text" name="physical_address"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                               required>
                                        <div class="invalid-feedback">Please enter Physical Address!</div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                    <div class="form-group">

                                    <label for="reg-marital_status">Industry </label>
                                        <select list="user_industry" class="form-control" value="{{old('user_industry')}}" type="text" name="user_industry"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                               required>
                                          
                                               <option value="">Select Industry</option>
                                               <option value='Bakeries'>Bakeries</option>
                                                    <option value='Catering'>Catering</option>
                                                    <option value='Corporate'>Corporate</option>
                                                    <option value='General'>General</option>
                                                    <option value='Export'>Export</option>
                                                    <option value='Groceries'>Groceries</option>
                                                    <option value='Hospitality'>Hospitality</option>
                                                    <option value='Institutional'>Institutional</option>
                                                    <option value='Packer Processor'>Packer Processor</option>
                                                    <option value='Restaurants'>Restaurants</option>
                                                    <option value='Supermarkets'>Supermarkets</option>
                                                    
                                                </select>
                                               
                                                <div class="invalid-feedback">Please enter Industry!</div>


                                        <div class="invalid-feedback">Please enter your Industry!</div>
                                    </div>
                                    </div>
                                </div>

                               
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="si-password">{{\App\CPU\translate('password')}}</label>
                                        <div class="password-toggle">
                                            <input class="form-control" name="password" type="password" id="si-password"
                                                   style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                                   placeholder="{{\App\CPU\translate('minimum_8_characters_long')}}"
                                                   required>
                                            <label class="password-toggle-btn">
                                                <input class="custom-control-input" type="checkbox"><i
                                                    class="czi-eye password-toggle-indicator"></i><span
                                                    class="sr-only">{{\App\CPU\translate('Show')}} {{\App\CPU\translate('password')}} </span>
                                            </label>
                                        </div>
                                    </div>

                                    {{-- <div class="form-group">
                                        <label for="reg-password">{{\App\CPU\translate('password')}}</label>
                                        <input class="form-control" type="password" name="password">
                                        <div class="invalid-feedback">Please enter password!</div>
                                    </div> --}}
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="si-password">{{\App\CPU\translate('confirm_password')}}</label>
                                        <div class="password-toggle">
                                            <input class="form-control" name="con_password" type="password"
                                                   style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                                   placeholder="{{\App\CPU\translate('minimum_8_characters_long')}}"
                                                   id="si-password"
                                                   required>
                                            <label class="password-toggle-btn">
                                                <input class="custom-control-input" type="checkbox"
                                                       style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"><i
                                                    class="czi-eye password-toggle-indicator"></i><span
                                                    class="sr-only">{{\App\CPU\translate('Show')}} {{\App\CPU\translate('password')}} </span>
                                            </label>
                                        </div>
                                    </div>
                                    {{-- <div class="form-group">
                                        <label for="reg-password-confirm">{{\App\CPU\translate('confirm_password')}}</label>
                                        <input class="form-control" type="password" name="con_password">
                                        <div class="invalid-feedback">Passwords do not match!</div>
                                    </div> --}}
                                </div>
                            </div>
                            <div class="form-group d-flex flex-wrap justify-content-between">

                                <div class="form-group mb-1">
                                    <strong>
                                        <input type="checkbox" class="mr-1"
                                               name="remember" id="inputCheckd">
                                    </strong>
                                    <label class="" for="remember">{{\App\CPU\translate('i_agree_to_Your_terms')}}<a
                                            class="font-size-sm" target="_blank" href="{{route('terms')}}">
                                            {{\App\CPU\translate('terms_and_condition')}}
                                        </a></label>
                                </div>

                            </div>
                            <div class="flex-between row" style="direction: {{ Session::get('direction') }}">
                                <div class="mx-1">
                                    <div class="text-right">
                                        <button class="btn btn-primary" id="sign-up" type="submit1" disabled>
                                            <i class="czi-user {{Session::get('direction') === "rtl" ? 'ml-2 mr-n1' : 'mr-2 ml-n1'}}"></i>
                                            Trader Sign Up
                                        </button>
                                    </div>
                                </div>
                                <div class="mx-1">
                                    <a class="btn btn-outline-primary" href="{{route('customer.auth.login')}}">
                                        <i class="fa fa-sign-in"></i> {{\App\CPU\translate('sing_in')}}
                                    </a>
                                </div>
                                <div class="col-12 mt-3">
                                    <div class="row">
                                        @foreach (\App\CPU\Helpers::get_business_settings('social_login') as $socialLoginService)
                                            @if (isset($socialLoginService) && $socialLoginService['status']==true)
                                                <div class="col-sm-6 text-center mt-1">
                                                    <a class="btn btn-outline-primary"
                                                       href="{{route('customer.auth.service-login', $socialLoginService['login_medium'])}}"
                                                       style="width: 100%">
                                                        <i class="czi-{{ $socialLoginService['login_medium'] }} {{Session::get('direction') === "rtl" ? 'ml-2 mr-n1' : 'mr-2 ml-n1'}}"></i>
                                                        {{\App\CPU\translate('sing_up_with_'.$socialLoginService['login_medium'])}}
                                                    </a>
                                                </div>
                                            @endif
                                        @endforeach
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('script')
    <script>
        $('#inputCheckd').change(function () {
            // console.log('jell');
            if ($(this).is(':checked')) {
                $('#sign-up').removeAttr('disabled');
            } else {
                $('#sign-up').attr('disabled', 'disabled');
            }

        });
        /*$('#sign-up-form').submit(function (e) {
            e.preventDefault();
            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                }
            });
            $.post({
                url: '{{route('customer.auth.register-trader')}}',
                dataType: 'json',
                data: $('#sign-up-form').serialize(),
                beforeSend: function () {
                    $('#loading').show();
                },
                success: function (data) {
                    if (data.errors) {
                        for (var i = 0; i < data.errors.length; i++) {
                            toastr.error(data.errors[i].message, {
                                CloseButton: true,
                                ProgressBar: true
                            });
                        }
                    } else {
                        toastr.success(data.message, {
                            CloseButton: true,
                            ProgressBar: true
                        });
                        setInterval(function () {
                            location.href = data.url;
                        }, 2000);
                    }
                },
                complete: function () {
                    $('#loading').hide();
                },
                error: function () {
                  console.log(response)
                }
            });
        });*/
    </script>
@endpush
