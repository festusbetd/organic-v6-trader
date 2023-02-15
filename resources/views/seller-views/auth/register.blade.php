@extends('layouts.front-end.app')

@section('title',\App\CPU\translate('Seller Apply'))

@push('css_or_js')
<link href="{{asset('public/assets/back-end')}}/css/select2.min.css" rel="stylesheet"/>
<link href="{{asset('public/assets/back-end/css/croppie.css')}}" rel="stylesheet">
<meta name="csrf-token" content="{{ csrf_token() }}">
@endpush


@section('content')

<div class="container main-card rtl" style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">

    <div class="card o-hidden border-0 shadow-lg my-4">
        <div class="card-body ">
            <!-- Nested Row within Card Body -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="p-5">
                        <div class="text-center mb-2 ">
                            <h3 class="" > {{\App\CPU\translate('Farmer')}} {{\App\CPU\translate('Application')}}</h3>
                            <hr>
                        </div>
                        <form class="user" action="{{route('shop.apply')}}" method="post" enctype="multipart/form-data">
                            @csrf
                            <h5 class="black">{{\App\CPU\translate('Seller')}} {{\App\CPU\translate('Info')}} </h5>
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <input type="text" class="form-control form-control-user" id="exampleFirstName" name="f_name" value="{{old('f_name')}}" placeholder="{{\App\CPU\translate('first_name')}}" required>
                                </div>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control form-control-user" id="exampleLastName" name="l_name" value="{{old('l_name')}}" placeholder="{{\App\CPU\translate('last_name')}}" required>
                                </div>
                            </div>
                            <div class="form-group row">
                            <div class="col-sm-6 mb-3 mb-sm-0 mt-4">
                                    <input type="text" class="form-control form-control-user" id="exampleInputID" name="id_number" value="{{old('id_number')}}" placeholder="Farmer ID/Passport No" required>
                                </div>
                                <div class="col-sm-6 mb-3 mb-sm-0 mt-4">
                                    <input type="text" class="form-control form-control-user" id="exampleInputEmployeeNumber" name="empoyee_number" value="{{old('empoyee_number')}}" placeholder="Farmer Registration Number" required>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0 mt-4">
                                    <input type="email" class="form-control form-control-user" id="exampleInputEmail" name="email" value="{{old('email')}}" placeholder="{{\App\CPU\translate('email_address')}}" required>
                                </div>
                                <div class="col-sm-6"><small class="text-danger">( * {{\App\CPU\translate('country_code_is_must')}} {{\App\CPU\translate('like_for_BD_880')}} )</small>
                                    <input type="number" class="form-control form-control-user" id="exampleInputPhone" name="phone" value="{{old('phone')}}" placeholder="{{\App\CPU\translate('phone_number')}}" required>
                                </div>
                            </div>
                     <!-- Added -->
                     <div class="form-group row">
                        
                                <div class="col-sm-6 mb-3 mb-sm-0">
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
                                <div class="col-sm-6">
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


                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    
                                <input class="form-control" type="kra_pin" value="{{old('kra_pin')}}"  name="kra_pin" placeholder="KRA Number"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};" required>
                                        <div class="invalid-feedback">Please enter valid KRA Number!</div>
                            </div>
                                <div class="col-sm-6">
                                        <input class="form-control" type="other_phone_number" value="{{old('other_phone_number')}}" placeholder="Other Phone Number"  name="other_phone_number"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};" required>
                                        <div class="invalid-feedback">Please enter valid Phone Number!</div>
                            
                            </div>
                            </div>


                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                <select list="user_type_name" class="form-control" value="{{old('user_type_name')}}" type="text" name="user_type_name"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                               required>
                                          
                                               <option value="">Select User Type</option>
                                               <option value='Individual'>Individual</option>
                                                    <option value='Group'>Group</option>
                                                    
                                                </select>
                                               
                                                <div class="invalid-feedback">Please enter your User Type!</div>    
                            
                            </div>
                                <div class="col-sm-6">
                                    
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


                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                <input class="form-control" type="text" value="{{old('constituency')}}"  name="constituency" placeholder="Constituency"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};" required>
                                        <div class="invalid-feedback">Please enter valid Constituency!</div>
                                    
                            </div>
                                <div class="col-sm-6">
                                <input class="form-control" type="text" value="{{old('ward')}}"  name="ward" placeholder="Ward"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};" required>
                                        <div class="invalid-feedback">Please enter valid Ward!</div>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                <input class="form-control" type="text" value="{{old('village')}}"  name="village" placeholder="Village"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};" required>
                                        <div class="invalid-feedback">Please enter validVillage!</div>
                                    
                            </div>
                                <div class="col-sm-6">
                            <input class="form-control" type="text" value="{{old('group_or_co_operative')}}"  name="group_or_co_operative" placeholder="Group/Co-operative"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};" required>
                                        <div class="invalid-feedback">Please enter valid Group/Co-operative!</div>
                                </div>
                            </div>


                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                <input class="form-control" type="text" value="{{old('total_land_size')}}"  name="total_land_size" placeholder="Total Land (size)"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};" required>
                                        <div class="invalid-feedback">Please enter valid Total Land (size)!</div>
                                    
                            </div>
                                <div class="col-sm-6">
                                <input class="form-control" type="text" value="{{old('total_land_size_organic')}}"  name="total_land_size_organic" placeholder="Land under Organic (size)"
                                               style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};" required>
                                        <div class="invalid-feedback">Please enter valid total_land_size_organic!</div>
                                </div>
                            </div>

                   <!-- Added -->

                        

                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <input type="password" class="form-control form-control-user" minlength="6" id="exampleInputPassword" name="password" placeholder="{{\App\CPU\translate('password')}}" required>
                                </div>
                                <div class="col-sm-6">
                                    <input type="password" class="form-control form-control-user" minlength="6" id="exampleRepeatPassword" placeholder="{{\App\CPU\translate('repeat_password')}}" required>
                                    <div class="pass invalid-feedback">{{\App\CPU\translate('Repeat')}}  {{\App\CPU\translate('password')}} {{\App\CPU\translate('not match')}} .</div>
                                </div>
                            </div>
                            <div class="">
                                <div class="pb-1">
                                    <center>
                                        <img style="width: auto;border: 1px solid; border-radius: 10px; max-height:200px;" id="viewer"
                                            src="{{asset('public\assets\back-end\img\400x400\img2.jpg')}}" alt="banner image"/>
                                    </center>
                                </div>

                                <div class="form-group">
                                    <div class="custom-file" style="text-align: left">
                                        <input type="file" name="image" id="customFileUpload" class="custom-file-input"
                                            accept=".jpg, .png, .jpeg, .gif, .bmp, .tif, .tiff|image/*">
                                        <label class="custom-file-label" for="customFileUpload">{{\App\CPU\translate('Upload')}} {{\App\CPU\translate('image')}}</label>
                                    </div>
                                </div>
                            </div>


                            <h5 class="black">{{\App\CPU\translate('Farm')}} {{\App\CPU\translate('Info')}}</h5>
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0 ">
                                    <input type="text" class="form-control form-control-user" id="shop_name" name="shop_name" placeholder="Farm Name" value="{{old('shop_name')}}"required>
                                </div>
                                <div class="col-sm-6">
                                    <textarea name="shop_address" class="form-control" id="shop_address"rows="1" placeholder="Farm Address">{{old('shop_address')}}</textarea>
                                </div>
                            </div>
                            <div class="">
                                <div class="pb-1">
                                    <center>
                                        <img style="width: auto;border: 1px solid; border-radius: 10px; max-height:200px;" id="viewerLogo"
                                            src="{{asset('public\assets\back-end\img\400x400\img2.jpg')}}" alt="banner image"/>
                                    </center>
                                </div>

                                <div class="form-group">
                                    <div class="custom-file" style="text-align: left">
                                        <input type="file" name="logo" id="LogoUpload" class="custom-file-input"
                                            accept=".jpg, .png, .jpeg, .gif, .bmp, .tif, .tiff|image/*">
                                        <label class="custom-file-label" for="LogoUpload">{{\App\CPU\translate('Upload')}} {{\App\CPU\translate('logo')}}</label>
                                    </div>
                                </div>
                            </div>
                            <div class="">
                                <div class="pb-1">
                                    <center>
                                        <img style="width: auto;border: 1px solid; border-radius: 10px; max-height:200px;" id="viewerBanner"
                                             src="{{asset('public\assets\back-end\img\400x400\img2.jpg')}}" alt="banner image"/>
                                    </center>
                                </div>

                                <div class="form-group">
                                    <div class="custom-file" style="text-align: left">
                                        <input type="file" name="banner" id="BannerUpload" class="custom-file-input"
                                               accept=".jpg, .png, .jpeg, .gif, .bmp, .tif, .tiff|image/*" style="overflow: hidden; padding: 2%">
                                        <label class="custom-file-label" for="BannerUpload">{{\App\CPU\translate('Upload')}} {{\App\CPU\translate('Banner')}}</label>
                                    </div>
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
                            <button type="submit" class="btn btn-primary btn-user btn-block" id="apply">{{\App\CPU\translate('Apply')}} {{\App\CPU\translate('Farmer')}} </button>
                        </form>
                        <hr>
                        <div class="text-center">
                            <a class="small"  href="{{route('seller.auth.login')}}">{{\App\CPU\translate('already_have_an_account?_login.')}}</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
@push('script')
@if ($errors->any())
    <script>
        @foreach($errors->all() as $error)
        toastr.error('{{$error}}', Error, {
            CloseButton: true,
            ProgressBar: true
        });
        @endforeach
    </script>


@endif
<script>

$('#inputCheckd').change(function () {
            // console.log('jell');
            if ($(this).is(':checked')) {
                $('#sign-up').removeAttr('disabled');
                alert('Yes')
            } else {
                $('#sign-up').attr('disabled', 'disabled');
                alert('No')
            }

        });


    $('#exampleInputPassword ,#exampleRepeatPassword').on('keyup',function () {
        var pass = $("#exampleInputPassword").val();
        var passRepeat = $("#exampleRepeatPassword").val();
        if (pass==passRepeat){
            $('.pass').hide();
        }
        else{
            $('.pass').show();
        }
    });
    $('#apply').on('click',function () {

        var image = $("#image-set").val();
        if (image=="")
        {
            $('.image').show();
            return false;
        }
        var pass = $("#exampleInputPassword").val();
        var passRepeat = $("#exampleRepeatPassword").val();
        if (pass!=passRepeat){
            $('.pass').show();
            return false;
        }


    });
    function Validate(file) {
        var x;
        var le = file.length;
        var poin = file.lastIndexOf(".");
        var accu1 = file.substring(poin, le);
        var accu = accu1.toLowerCase();
        if ((accu != '.png') && (accu != '.jpg') && (accu != '.jpeg')) {
            x = 1;
            return x;
        } else {
            x = 0;
            return x;
        }
    }

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#viewer').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#customFileUpload").change(function () {
        readURL(this);
    });

    function readlogoURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#viewerLogo').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    function readBannerURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#viewerBanner').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#LogoUpload").change(function () {
        readlogoURL(this);
    });
    $("#BannerUpload").change(function () {
        readBannerURL(this);
    });
</script>
@endpush
